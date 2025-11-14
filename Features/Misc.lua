--[[
    DummyHook Misc Module
    Miscellaneous features like speed, fly, noclip, etc.
]]

local Misc = {
    Settings = {
        WalkSpeed = 16,
        JumpPower = 50,
        NoClip = false,
        Fly = false,
        FlySpeed = 50,
        InfiniteJump = false,
        SpinBot = false,
        SpinSpeed = 20,
        SpinMode = "Horizontal", -- Horizontal, Vertical, Random, Jitter
        FakeLag = false,
        AntiAim = false,
        AntiAimPitch = "Down", -- Up, Down, Jitter, Random
        AntiAimYaw = "Spin", -- Spin, Backwards, Jitter, Random
        BunnyHop = false,
        EdgeJump = false,
        AutoStrafeSpeed = 1,
        HideName = false,
        AntiOBS = false,
        ChatSpam = false,
        ChatSpamDelay = 1,
        ChatSpamMessage = "DummyHook on top!",
    },
    Connections = {},
    OriginalValues = {},
    SpinAngle = 0,
    OriginalNameDisplay = nil,
    ChatSpamMessages = {
        "DummyHook on top!",
        "Get good or get DummyHook",
        "Premium features unlocked",
        "DummyHook.io",
        "Too easy with DummyHook"
    }
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Utility Functions
local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid()
    local character = GetCharacter()
    return character and character:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart()
    local character = GetCharacter()
    return character and character:FindFirstChild("HumanoidRootPart")
end

-- Walk Speed
function Misc:SetWalkSpeed(value)
    self.Settings.WalkSpeed = value
    
    if self.Connections.WalkSpeed then
        self.Connections.WalkSpeed:Disconnect()
    end
    
    local function updateSpeed()
        local humanoid = GetHumanoid()
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
    
    updateSpeed()
    
    self.Connections.WalkSpeed = RunService.Heartbeat:Connect(updateSpeed)
end

-- Jump Power
function Misc:SetJumpPower(value)
    self.Settings.JumpPower = value
    
    if self.Connections.JumpPower then
        self.Connections.JumpPower:Disconnect()
    end
    
    local function updateJump()
        local humanoid = GetHumanoid()
        if humanoid then
            humanoid.JumpPower = value
        end
    end
    
    updateJump()
    
    self.Connections.JumpPower = RunService.Heartbeat:Connect(updateJump)
end

-- NoClip
function Misc:SetNoClip(value)
    self.Settings.NoClip = value
    
    if self.Connections.NoClip then
        self.Connections.NoClip:Disconnect()
        self.Connections.NoClip = nil
    end
    
    if value then
        self.Connections.NoClip = RunService.Stepped:Connect(function()
            local character = GetCharacter()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        local character = GetCharacter()
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- Fly
function Misc:SetFly(value)
    self.Settings.Fly = value
    
    if self.Connections.Fly then
        self.Connections.Fly:Disconnect()
        self.Connections.Fly = nil
    end
    
    if self.Connections.FlyControl then
        self.Connections.FlyControl:Disconnect()
        self.Connections.FlyControl = nil
    end
    
    if value then
        local rootPart = GetRootPart()
        if not rootPart then return end
        
        -- Modern approach: Use AlignPosition and AlignOrientation
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Name = "DummyHook_FlyVelocity"
        bodyVelocity.Parent = rootPart
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
        bodyGyro.P = 10000
        bodyGyro.Name = "DummyHook_FlyGyro"
        bodyGyro.Parent = rootPart
        
        self.Connections.Fly = RunService.Heartbeat:Connect(function()
            local humanoid = GetHumanoid()
            local root = GetRootPart()
            
            if not humanoid or not root then
                self:SetFly(false)
                return
            end
            
            local camera = workspace.CurrentCamera
            local moveDirection = humanoid.MoveDirection
            
            if moveDirection.Magnitude > 0 then
                bodyVelocity.Velocity = camera.CFrame.LookVector * self.Settings.FlySpeed
            else
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
            
            bodyGyro.CFrame = camera.CFrame
        end)
        
        self.Connections.FlyControl = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            local root = GetRootPart()
            if not root then return end
            
            local bv = root:FindFirstChild("DummyHook_FlyVelocity")
            if not bv then return end
            
            if input.KeyCode == Enum.KeyCode.Space then
                bv.Velocity = bv.Velocity + Vector3.new(0, self.Settings.FlySpeed, 0)
            elseif input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.LeftShift then
                bv.Velocity = bv.Velocity + Vector3.new(0, -self.Settings.FlySpeed, 0)
            end
        end)
    else
        local rootPart = GetRootPart()
        if rootPart then
            for _, object in pairs(rootPart:GetChildren()) do
                if object.Name == "DummyHook_FlyVelocity" or object.Name == "DummyHook_FlyGyro" then
                    object:Destroy()
                end
            end
        end
    end
end

-- Infinite Jump
function Misc:SetInfiniteJump(value)
    self.Settings.InfiniteJump = value
    
    if self.Connections.InfiniteJump then
        self.Connections.InfiniteJump:Disconnect()
        self.Connections.InfiniteJump = nil
    end
    
    if value then
        self.Connections.InfiniteJump = UserInputService.JumpRequest:Connect(function()
            local humanoid = GetHumanoid()
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

-- FOV Changer
function Misc:SetFOV(value)
    local camera = workspace.CurrentCamera
    camera.FieldOfView = value
end

-- Anti-AFK
function Misc:SetAntiAFK(value)
    if self.Connections.AntiAFK then
        self.Connections.AntiAFK:Disconnect()
        self.Connections.AntiAFK = nil
    end
    
    if value then
        local virtualUser = game:GetService("VirtualUser")
        self.Connections.AntiAFK = LocalPlayer.Idled:Connect(function()
            virtualUser:CaptureController()
            virtualUser:ClickButton2(Vector2.new())
        end)
    end
end

-- Full Bright
function Misc:SetFullBright(value)
    local lighting = game:GetService("Lighting")
    
    if value then
        self.OriginalValues.Ambient = lighting.Ambient
        self.OriginalValues.OutdoorAmbient = lighting.OutdoorAmbient
        self.OriginalValues.Brightness = lighting.Brightness
        
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        lighting.Brightness = 2
    else
        if self.OriginalValues.Ambient then
            lighting.Ambient = self.OriginalValues.Ambient
            lighting.OutdoorAmbient = self.OriginalValues.OutdoorAmbient
            lighting.Brightness = self.OriginalValues.Brightness
        end
    end
end

-- Remove Fog
function Misc:SetNoFog(value)
    local lighting = game:GetService("Lighting")
    
    if value then
        self.OriginalValues.FogEnd = lighting.FogEnd
        lighting.FogEnd = 100000
    else
        if self.OriginalValues.FogEnd then
            lighting.FogEnd = self.OriginalValues.FogEnd
        end
    end
end

-- SpinBot (Skeet/Aimware style)
function Misc:SetSpinBot(value)
    self.Settings.SpinBot = value
    
    if self.Connections.SpinBot then
        self.Connections.SpinBot:Disconnect()
        self.Connections.SpinBot = nil
    end
    
    if value then
        self.Connections.SpinBot = RunService.RenderStepped:Connect(function()
            local character = GetCharacter()
            local rootPart = GetRootPart()
            
            if not character or not rootPart then return end
            
            local spinSpeed = self.Settings.SpinSpeed
            
            if self.Settings.SpinMode == "Horizontal" then
                -- Classic spin
                self.SpinAngle = (self.SpinAngle + spinSpeed) % 360
                rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(0, math.rad(self.SpinAngle), 0)
            elseif self.Settings.SpinMode == "Vertical" then
                -- Vertical spin (looks weird but funny)
                self.SpinAngle = (self.SpinAngle + spinSpeed) % 360
                rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(math.rad(self.SpinAngle), 0, 0)
            elseif self.Settings.SpinMode == "Random" then
                -- Random rotation
                rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(
                    math.rad(math.random(0, 360)),
                    math.rad(math.random(0, 360)),
                    math.rad(math.random(0, 360))
                )
            elseif self.Settings.SpinMode == "Jitter" then
                -- Jitter spin (rapid random changes)
                local jitterAmount = 180
                self.SpinAngle = (self.SpinAngle + (math.random(-jitterAmount, jitterAmount))) % 360
                rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(0, math.rad(self.SpinAngle), 0)
            end
        end)
    end
end

-- Anti-Aim (Advanced)
function Misc:SetAntiAim(value)
    self.Settings.AntiAim = value
    
    if self.Connections.AntiAim then
        self.Connections.AntiAim:Disconnect()
        self.Connections.AntiAim = nil
    end
    
    if value then
        self.Connections.AntiAim = RunService.RenderStepped:Connect(function()
            local character = GetCharacter()
            local rootPart = GetRootPart()
            
            if not character or not rootPart then return end
            
            local currentCFrame = rootPart.CFrame
            local yaw = 0
            local pitch = 0
            
            -- Yaw (horizontal)
            if self.Settings.AntiAimYaw == "Spin" then
                self.SpinAngle = (self.SpinAngle + self.Settings.SpinSpeed) % 360
                yaw = math.rad(self.SpinAngle)
            elseif self.Settings.AntiAimYaw == "Backwards" then
                yaw = math.rad(180)
            elseif self.Settings.AntiAimYaw == "Jitter" then
                yaw = math.rad(tick() % 2 == 0 and 90 or -90)
            elseif self.Settings.AntiAimYaw == "Random" then
                yaw = math.rad(math.random(0, 360))
            end
            
            -- Pitch (vertical)
            if self.Settings.AntiAimPitch == "Down" then
                pitch = math.rad(89)
            elseif self.Settings.AntiAimPitch == "Up" then
                pitch = math.rad(-89)
            elseif self.Settings.AntiAimPitch == "Jitter" then
                pitch = math.rad(tick() % 2 == 0 and 89 or -89)
            elseif self.Settings.AntiAimPitch == "Random" then
                pitch = math.rad(math.random(-89, 89))
            end
            
            rootPart.CFrame = CFrame.new(currentCFrame.Position) * CFrame.Angles(pitch, yaw, 0)
        end)
    end
end

-- Bunny Hop
function Misc:SetBunnyHop(value)
    self.Settings.BunnyHop = value
    
    if self.Connections.BunnyHop then
        self.Connections.BunnyHop:Disconnect()
        self.Connections.BunnyHop = nil
    end
    
    if value then
        self.Connections.BunnyHop = RunService.Heartbeat:Connect(function()
            local humanoid = GetHumanoid()
            if humanoid and humanoid.MoveDirection.Magnitude > 0 then
                if humanoid.FloorMaterial ~= Enum.Material.Air then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end

-- Fake Lag (desync)
function Misc:SetFakeLag(value)
    self.Settings.FakeLag = value
    
    if self.Connections.FakeLag then
        self.Connections.FakeLag:Disconnect()
        self.Connections.FakeLag = nil
    end
    
    if value then
        local lagTicks = 0
        self.Connections.FakeLag = RunService.Heartbeat:Connect(function()
            local rootPart = GetRootPart()
            if not rootPart then return end
            
            lagTicks = lagTicks + 1
            
            if lagTicks % 15 == 0 then
                -- Simulate lag by teleporting back slightly
                local velocity = rootPart.AssemblyVelocity
                rootPart.CFrame = rootPart.CFrame - (velocity * 0.1)
            end
        end)
    end
end

-- Hide Name / Change Name to DummyHook
function Misc:SetHideName(value)
    self.Settings.HideName = value
    
    local character = GetCharacter()
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    -- Method 1: Modify BillboardGui name displays
    for _, obj in pairs(head:GetChildren()) do
        if obj:IsA("BillboardGui") then
            for _, child in pairs(obj:GetDescendants()) do
                if child:IsA("TextLabel") then
                    if value then
                        if not self.OriginalNameDisplay then
                            self.OriginalNameDisplay = child.Text
                        end
                        child.Text = "DummyHook"
                    else
                        if self.OriginalNameDisplay then
                            child.Text = self.OriginalNameDisplay
                        end
                    end
                end
            end
        end
    end
    
    -- Method 2: Change DisplayName (visible to others in new Roblox)
    local humanoid = GetHumanoid()
    if humanoid then
        if value then
            if not self.OriginalValues.DisplayName then
                self.OriginalValues.DisplayName = humanoid.DisplayName
            end
            humanoid.DisplayName = "DummyHook"
        else
            if self.OriginalValues.DisplayName then
                humanoid.DisplayName = self.OriginalValues.DisplayName
            end
        end
        
        -- Also control distance type
        if value then
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
        else
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
        end
    end
    
    -- Method 3: Hook nametag rendering (advanced)
    if value and not self.Connections.NameHook then
        self.Connections.NameHook = RunService.Heartbeat:Connect(function()
            pcall(function()
                local char = GetCharacter()
                if char then
                    local h = char:FindFirstChild("Head")
                    if h then
                        for _, gui in pairs(h:GetChildren()) do
                            if gui:IsA("BillboardGui") then
                                for _, label in pairs(gui:GetDescendants()) do
                                    if label:IsA("TextLabel") and label.Text ~= "DummyHook" then
                                        label.Text = "DummyHook"
                                    end
                                end
                            end
                        end
                    end
                    
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.DisplayName ~= "DummyHook" then
                        hum.DisplayName = "DummyHook"
                    end
                end
            end)
        end)
    elseif not value and self.Connections.NameHook then
        self.Connections.NameHook:Disconnect()
        self.Connections.NameHook = nil
    end
    
    print("[Misc] Name " .. (value and "changed to DummyHook" or "restored"))
end

-- Anti OBS (Screen Capture Protection)
function Misc:SetAntiOBS(value)
    self.Settings.AntiOBS = value
    
    if value then
        -- Method 1: Transparency manipulation
        local character = GetCharacter()
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Texture") then
                    if not self.OriginalValues[part] then
                        self.OriginalValues[part] = {}
                        if part:IsA("BasePart") then
                            self.OriginalValues[part].Transparency = part.Transparency
                        end
                    end
                end
            end
        end
        
        -- Method 2: Render blocking
        if self.Connections.AntiOBS then
            self.Connections.AntiOBS:Disconnect()
        end
        
        self.Connections.AntiOBS = RunService.RenderStepped:Connect(function()
            -- Rapidly change transparency to confuse screen capture
            local character = GetCharacter()
            if character then
                local tick_value = tick() % 0.1
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = tick_value > 0.05 and 0 or 1
                    end
                end
            end
        end)
        
        print("[Misc] Anti-OBS enabled (may cause visual glitches)")
    else
        if self.Connections.AntiOBS then
            self.Connections.AntiOBS:Disconnect()
            self.Connections.AntiOBS = nil
        end
        
        -- Restore transparency
        for part, values in pairs(self.OriginalValues) do
            if part:IsA("BasePart") and values.Transparency then
                part.Transparency = values.Transparency
            end
        end
    end
end

-- Chat Spammer
function Misc:SetChatSpam(value)
    self.Settings.ChatSpam = value
    
    if self.Connections.ChatSpam then
        self.Connections.ChatSpam:Disconnect()
        self.Connections.ChatSpam = nil
    end
    
    if value then
        local messageIndex = 1
        
        self.Connections.ChatSpam = RunService.Heartbeat:Connect(function()
            if tick() % self.Settings.ChatSpamDelay < 0.016 then
                local message = self.Settings.ChatSpamMessage
                
                -- Try new TextChatService first
                pcall(function()
                    if TextChatService.ChatInputBarConfiguration then
                        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(message)
                    end
                end)
                
                -- Fallback to old chat
                pcall(function()
                    local chatRemote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                    if chatRemote then
                        local sayMessageRemote = chatRemote:FindFirstChild("SayMessageRequest")
                        if sayMessageRemote then
                            sayMessageRemote:FireServer(message, "All")
                        end
                    end
                end)
                
                -- Cycle through messages if using preset
                if message == "DummyHook on top!" then
                    messageIndex = (messageIndex % #self.ChatSpamMessages) + 1
                    self.Settings.ChatSpamMessage = self.ChatSpamMessages[messageIndex]
                end
            end
        end)
        
        print("[Misc] Chat spam enabled")
    end
end

-- Cleanup
function Misc:Cleanup()
    for _, connection in pairs(self.Connections) do
        connection:Disconnect()
    end
    
    self.Connections = {}
    
    -- Restore original values
    local humanoid = GetHumanoid()
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
    
    self:SetNoClip(false)
    self:SetFly(false)
    self:SetSpinBot(false)
    self:SetAntiAim(false)
    self:SetBunnyHop(false)
    self:SetFakeLag(false)
    self:SetHideName(false)
    self:SetAntiOBS(false)
    self:SetChatSpam(false)
end

return Misc
