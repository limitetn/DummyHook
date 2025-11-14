--[[
    DummyHook Aimbot Module
    Advanced Aimbot with FOV, Smoothing, Visibility Check
]]

local Aimbot = {
    Enabled = false,
    Settings = {
        FOV = 150,
        Smoothness = 50,
        TargetPart = "Head",
        VisibilityCheck = true,
        TeamCheck = true,
        DrawFOV = true,
        FOVColor = Color3.fromRGB(255, 255, 255),
        PredictMovement = false,
        PredictionAmount = 0.15,
        IgnoreWalls = false,
        TriggerBot = false,
        AutoShoot = false,
        SilentAim = false,
        AimPart = "Closest", -- Closest, Head, Torso, Random
        Resolver = false,
        ResolverMode = "Basic", -- Basic, Advanced
        StickyAim = false,
        AimAssist = false,
        AimAssistStrength = 30,
        LockMode = 1, -- 1 = Camera Lock, 2 = Mouse Movement
        MouseSensitivity = 0.15, -- Lower = smoother mouse movement
        ShakeReduction = true,
    },
    CurrentTarget = nil,
    FOVCircle = nil,
    Connections = {},
    LastResolveAngles = {},
    OriginalNamecall = nil
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Utility Functions
local function GetMouse()
    return LocalPlayer:GetMouse()
end

local function IsAlive(player)
    if not player or not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0
end

local function GetDistance(part)
    if not part then return math.huge end
    return (Camera.CFrame.Position - part.Position).Magnitude
end

local function IsVisible(targetPart)
    if not targetPart then return false end
    if Aimbot.Settings.IgnoreWalls then return true end
    
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * (targetPart.Position - origin).Magnitude
    
    local ray = Ray.new(origin, direction)
    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
    
    return hit and hit:IsDescendantOf(targetPart.Parent)
end

local function WorldToScreen(position)
    local screenPos, onScreen = Camera:WorldToViewportPoint(position)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

local function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    local mouse = GetMouse()
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsAlive(player) then
            -- Team check
            if not (Aimbot.Settings.TeamCheck and player.Team == LocalPlayer.Team) then
                local character = player.Character
                local targetPart = character:FindFirstChild(Aimbot.Settings.TargetPart)
                
                if targetPart then
                    -- Visibility check
                    if not Aimbot.Settings.VisibilityCheck or IsVisible(targetPart) then
                        local screenPos, onScreen = WorldToScreen(targetPart.Position)
                        
                        if onScreen then
                            local distance = (mousePos - screenPos).Magnitude
                            
                            -- FOV check
                            if distance <= Aimbot.Settings.FOV then
        
                                if distance < closestDistance then
                                    closestDistance = distance
                                    closestPlayer = player
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function PredictPosition(targetPart)
    if not Aimbot.Settings.PredictMovement then
        return targetPart.Position
    end
    
    local velocity = targetPart.AssemblyVelocity
    local prediction = targetPart.Position + (velocity * Aimbot.Settings.PredictionAmount)
    
    return prediction
end

-- Resolver (counter anti-aim)
local function ResolveTarget(targetPart)
    if not Aimbot.Settings.Resolver then
        return targetPart.Position
    end
    
    local player = Players:GetPlayerFromCharacter(targetPart.Parent)
    if not player then return targetPart.Position end
    
    -- Basic resolver: predict based on velocity
    if Aimbot.Settings.ResolverMode == "Basic" then
        local velocity = targetPart.AssemblyVelocity
        return targetPart.Position + (velocity * 0.1)
    end
    
    -- Advanced resolver: track angle changes
    if Aimbot.Settings.ResolverMode == "Advanced" then
        local currentAngle = math.deg(math.atan2(targetPart.CFrame.LookVector.Z, targetPart.CFrame.LookVector.X))
        local lastAngle = Aimbot.LastResolveAngles[player.UserId] or currentAngle
        local angleDelta = currentAngle - lastAngle
        
        Aimbot.LastResolveAngles[player.UserId] = currentAngle
        
        -- If angle is changing rapidly (likely anti-aim), predict opposite
        if math.abs(angleDelta) > 45 then
            local resolveOffset = CFrame.Angles(0, math.rad(-angleDelta), 0) * Vector3.new(0, 0, 2)
            return targetPart.Position + resolveOffset
        end
    end
    
    return targetPart.Position
end

-- Silent Aim (fires at target without moving camera)
local SilentAimHooked = false
local SilentAimTarget = nil

local function ApplySilentAim(targetPart)
    if not Aimbot.Settings.SilentAim then return end
    
    SilentAimTarget = targetPart
    local targetPos = ResolveTarget(targetPart)
    
    -- Hook mouse position only once
    if not SilentAimHooked then
        local success = pcall(function()
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            
            local oldNamecall = mt.__namecall
            local oldIndex = mt.__index
            
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                if SilentAimTarget and Aimbot.Settings.SilentAim then
                    -- Hook Ray casting
                    if method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRay" then
                        local ray = args[1]
                        if ray then
                            local newRay = Ray.new(
                                Camera.CFrame.Position,
                                (SilentAimTarget.Position - Camera.CFrame.Position).Unit * 1000
                            )
                            args[1] = newRay
                        end
                    end
                    
                    -- Hook FireServer for tools
                    if method == "FireServer" or method == "InvokeServer" then
                        if tostring(self):lower():find("shoot") or tostring(self):lower():find("fire") or tostring(self):lower():find("gun") then
                            -- Replace position argument with target
                            for i, arg in pairs(args) do
                                if typeof(arg) == "Vector3" then
                                    args[i] = SilentAimTarget.Position
                                elseif typeof(arg) == "CFrame" then
                                    args[i] = CFrame.new(SilentAimTarget.Position)
                                end
                            end
                        end
                    end
                end
                
                return oldNamecall(self, unpack(args))
            end)
            
            mt.__index = newcclosure(function(self, key)
                if SilentAimTarget and Aimbot.Settings.SilentAim then
                    -- Hook Mouse.Hit and Mouse.Target
                    if key == "Hit" then
                        local mouse = GetMouse()
                        if self == mouse then
                            return CFrame.new(SilentAimTarget.Position)
                        end
                    elseif key == "Target" then
                        local mouse = GetMouse()
                        if self == mouse then
                            return SilentAimTarget
                        end
                    end
                end
                
                return oldIndex(self, key)
            end)
            
            setreadonly(mt, true)
            SilentAimHooked = true
            print("[Aimbot] Silent aim hooked successfully!")
        end)
        
        if not success then
            warn("[Aimbot] Silent aim failed - executor doesn't support metatable hooking")
        end
    end
end

-- Aim Assist (subtle aim pull)
local function ApplyAimAssist()
    if not Aimbot.Settings.AimAssist then return end
    
    local target = GetClosestPlayer()
    if not target then return end
    
    local character = target.Character
    local targetPart = character:FindFirstChild(Aimbot.Settings.TargetPart)
    if not targetPart then return end
    
    local screenPos, onScreen = WorldToScreen(targetPart.Position)
    if not onScreen then return end
    
    local mouse = GetMouse()
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    local distance = (mousePos - screenPos).Magnitude
    
    -- Only assist if close to target
    if distance < Aimbot.Settings.FOV / 2 then
        local pullStrength = Aimbot.Settings.AimAssistStrength / 1000
        local targetPos = targetPart.Position
        local currentCFrame = Camera.CFrame
        local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
        
        Camera.CFrame = currentCFrame:Lerp(targetCFrame, pullStrength)
    end
end

local function AimAt(targetPart)
    if not targetPart then return end
    
    -- Silent aim mode
    if Aimbot.Settings.SilentAim then
        ApplySilentAim(targetPart)
        return
    end
    
    local targetPos = Aimbot.Settings.Resolver and ResolveTarget(targetPart) or PredictPosition(targetPart)
    
    -- Mode 1: Camera Lock (traditional)
    if Aimbot.Settings.LockMode == 1 then
        local currentCFrame = Camera.CFrame
        local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
        
        -- Apply smoothing
        local smoothFactor = (100 - Aimbot.Settings.Smoothness) / 100
        
        if smoothFactor <= 0.01 then
            -- Instant lock
            Camera.CFrame = targetCFrame
        else
            -- Smooth aim with shake reduction
            if Aimbot.Settings.ShakeReduction then
                local lerpedCFrame = currentCFrame:Lerp(targetCFrame, smoothFactor)
                Camera.CFrame = lerpedCFrame
            else
                Camera.CFrame = currentCFrame:Lerp(targetCFrame, smoothFactor)
            end
        end
    -- Mode 2: Mouse Movement (more legit)
    elseif Aimbot.Settings.LockMode == 2 then
        local screenPos, onScreen = WorldToScreen(targetPos)
        if not onScreen then return end
        
        local mouse = GetMouse()
        local mousePos = Vector2.new(mouse.X, mouse.Y)
        local delta = (screenPos - mousePos) * Aimbot.Settings.MouseSensitivity
        
        -- Use mousemoverel if available
        if mousemoverel then
            mousemoverel(delta.X, delta.Y)
        elseif mousemoveabs then
            mousemoveabs(screenPos.X, screenPos.Y)
        else
            -- Fallback to camera lock
            local currentCFrame = Camera.CFrame
            local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
            local smoothFactor = (100 - Aimbot.Settings.Smoothness) / 100
            Camera.CFrame = currentCFrame:Lerp(targetCFrame, smoothFactor)
        end
    end
end

-- Create FOV Circle
local function CreateFOVCircle()
    if Aimbot.FOVCircle then
        Aimbot.FOVCircle:Remove()
    end
    
    local circle = Drawing.new("Circle")
    circle.Visible = Aimbot.Settings.DrawFOV
    circle.Thickness = 2
    circle.NumSides = 50
    circle.Radius = Aimbot.Settings.FOV
    circle.Color = Aimbot.Settings.FOVColor
    circle.Transparency = 1
    circle.Filled = false
    
    Aimbot.FOVCircle = circle
end

-- Update FOV Circle
local function UpdateFOVCircle()
    if not Aimbot.FOVCircle then return end
    
    local mouse = GetMouse()
    Aimbot.FOVCircle.Position = Vector2.new(mouse.X, mouse.Y)
    Aimbot.FOVCircle.Radius = Aimbot.Settings.FOV
    Aimbot.FOVCircle.Color = Aimbot.Settings.FOVColor
    Aimbot.FOVCircle.Visible = Aimbot.Settings.DrawFOV and Aimbot.Enabled
end

-- Auto Shoot Function
local function AutoShoot()
    if not Aimbot.Settings.AutoShoot then return end
    if not Aimbot.CurrentTarget then return end
    
    -- Simulate mouse click (updated for current Roblox)
    local success = pcall(function()
        if mouse1press and mouse1release then
            mouse1press()
            task.wait(0.05)
            mouse1release()
        elseif mouse1click then
            mouse1click()
        end
    end)
    
    if not success then
        -- Fallback: Try virtual input
        pcall(function()
            local VirtualInputManager = game:GetService("VirtualInputManager")
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end)
    end
end

-- Initialize Aimbot
local function InitializeAimbot()
    CreateFOVCircle()
    
    -- Store original namecall for cleanup
    if not Aimbot.OriginalNamecall then
        local mt = getrawmetatable(game)
        Aimbot.OriginalNamecall = mt.__namecall
    end
    
    Aimbot.Connections.RenderStep = RunService.RenderStepped:Connect(function()
        UpdateFOVCircle()
        
        -- Aim assist (always active when enabled)
        if Aimbot.Settings.AimAssist then
            ApplyAimAssist()
        end
        
        if not Aimbot.Enabled then
            Aimbot.CurrentTarget = nil
            return
        end
        
        -- Check if right mouse button is held (for aimbot activation) or sticky aim
        local shouldAim = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        
        if shouldAim or Aimbot.Settings.StickyAim then
            local target = GetClosestPlayer()
            
            if target then
                Aimbot.CurrentTarget = target
                local character = target.Character
                local targetPart = character:FindFirstChild(Aimbot.Settings.TargetPart)
                
                if targetPart then
                    AimAt(targetPart)
                    
                    -- Trigger bot
                    if Aimbot.Settings.TriggerBot and shouldAim then
                        AutoShoot()
                    end
                end
            else
                Aimbot.CurrentTarget = nil
            end
        else
            Aimbot.CurrentTarget = nil
        end
    end)
end

-- Cleanup Aimbot
local function CleanupAimbot()
    if Aimbot.FOVCircle then
        Aimbot.FOVCircle:Remove()
        Aimbot.FOVCircle = nil
    end
    
    for _, connection in pairs(Aimbot.Connections) do
        connection:Disconnect()
    end
    
    Aimbot.Connections = {}
    Aimbot.CurrentTarget = nil
end

-- Public Methods
function Aimbot:SetEnabled(value)
    self.Enabled = value
    if value then
        InitializeAimbot()
    else
        CleanupAimbot()
    end
end

function Aimbot:SetFOV(value)
    self.Settings.FOV = value
end

function Aimbot:SetSmoothness(value)
    self.Settings.Smoothness = value
end

function Aimbot:SetTargetPart(value)
    self.Settings.TargetPart = value
end

function Aimbot:SetVisibilityCheck(value)
    self.Settings.VisibilityCheck = value
end

function Aimbot:SetTeamCheck(value)
    self.Settings.TeamCheck = value
end

function Aimbot:SetDrawFOV(value)
    self.Settings.DrawFOV = value
end

function Aimbot:SetPredictMovement(value)
    self.Settings.PredictMovement = value
end

function Aimbot:SetTriggerBot(value)
    self.Settings.TriggerBot = value
end

function Aimbot:SetAutoShoot(value)
    self.Settings.AutoShoot = value
end

function Aimbot:SetSilentAim(value)
    self.Settings.SilentAim = value
end

function Aimbot:SetResolver(value)
    self.Settings.Resolver = value
end

function Aimbot:SetStickyAim(value)
    self.Settings.StickyAim = value
end

function Aimbot:SetAimAssist(value)
    self.Settings.AimAssist = value
end

return Aimbot
