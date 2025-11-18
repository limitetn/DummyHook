--[[
    DummyHook ESP Module
    CS:GO Style ESP with Boxes, Names, Health, Distance, Tracers, Chams
]]

local ESP = {
    Enabled = false,
    Settings = {
        Boxes = true,
        Names = true,
        Distance = true,
        HealthBar = true,
        HealthText = true,
        Tracers = false,
        Chams = false,
        TeamCheck = true,
        BoxColor = Color3.fromRGB(255, 255, 255),
        TracerColor = Color3.fromRGB(255, 255, 255),
        TextSize = 13,
        MaxDistance = 2000,
        FilledBox = false,
        BoxTransparency = 0.3,
        ShowWeapon = true,
        ShowDisplayName = false,
        RainbowESP = false,
        TeamColor = true,
        SkeletonESP = false,
        HeadDot = true,
        LookTracers = false,
    },
    Objects = {},
    Connections = {}
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Utility Functions
local function IsAlive(player)
    if not player or not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0
end

local function IsVisible(targetPart)
    if not targetPart then return false end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * (targetPart.Position - origin).Magnitude
    
    local ray = Ray.new(origin, direction)
    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
    
    return hit and hit:IsDescendantOf(targetPart.Parent)
end

local function GetDistance(part)
    if not part then return math.huge end
    return (Camera.CFrame.Position - part.Position).Magnitude
end

local function WorldToScreen(position)
    local screenPos, onScreen = Camera:WorldToViewportPoint(position)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

-- Create ESP for a player
local function CreateESP(player)
    if player == LocalPlayer then return end
    if ESP.Objects[player] then return end
    
    local espObject = {
        Player = player,
        Drawings = {}
    }
    
    -- Box
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = ESP.Settings.BoxColor
    box.Thickness = 2
    box.Transparency = 1
    box.Filled = false
    espObject.Drawings.Box = box
    
    -- Box Outline
    local boxOutline = Drawing.new("Square")
    boxOutline.Visible = false
    boxOutline.Color = Color3.fromRGB(0, 0, 0)
    boxOutline.Thickness = 3
    boxOutline.Transparency = 0.5
    boxOutline.Filled = false
    espObject.Drawings.BoxOutline = boxOutline
    
    -- Name
    local name = Drawing.new("Text")
    name.Visible = false
    name.Color = Color3.fromRGB(255, 255, 255)
    name.Size = ESP.Settings.TextSize
    name.Center = true
    name.Outline = true
    name.OutlineColor = Color3.fromRGB(0, 0, 0)
    name.Font = 2
    name.Text = player.Name
    espObject.Drawings.Name = name
    
    -- Health Text
    local healthText = Drawing.new("Text")
    healthText.Visible = false
    healthText.Color = Color3.fromRGB(100, 255, 100)
    healthText.Size = ESP.Settings.TextSize - 2
    healthText.Center = true
    healthText.Outline = true
    healthText.OutlineColor = Color3.fromRGB(0, 0, 0)
    healthText.Font = 2
    espObject.Drawings.HealthText = healthText
    
    -- Distance Text
    local distance = Drawing.new("Text")
    distance.Visible = false
    distance.Color = Color3.fromRGB(200, 200, 200)
    distance.Size = ESP.Settings.TextSize - 2
    distance.Center = true
    distance.Outline = true
    distance.OutlineColor = Color3.fromRGB(0, 0, 0)
    distance.Font = 2
    espObject.Drawings.Distance = distance
    
    -- Health Bar
    local healthBar = Drawing.new("Line")
    healthBar.Visible = false
    healthBar.Color = Color3.fromRGB(0, 255, 0)
    healthBar.Thickness = 3
    healthBar.Transparency = 1
    espObject.Drawings.HealthBar = healthBar
    
    local healthBarBg = Drawing.new("Line")
    healthBarBg.Visible = false
    healthBarBg.Color = Color3.fromRGB(50, 50, 50)
    healthBarBg.Thickness = 3
    healthBarBg.Transparency = 1
    espObject.Drawings.HealthBarBg = healthBarBg
    
    -- Tracer
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = ESP.Settings.TracerColor
    tracer.Thickness = 1
    tracer.Transparency = 1
    espObject.Drawings.Tracer = tracer
    
    ESP.Objects[player] = espObject
end

-- Remove ESP for a player
local function RemoveESP(player)
    if not ESP.Objects[player] then return end
    
    for _, drawing in pairs(ESP.Objects[player].Drawings) do
        drawing:Remove()
    end
    
    ESP.Objects[player] = nil
end

-- Update ESP for a player
local function UpdateESP(player)
    if not ESP.Enabled then return end
    if not ESP.Objects[player] then return end
    if not IsAlive(player) then
        for _, drawing in pairs(ESP.Objects[player].Drawings) do
            drawing.Visible = false
        end
        return
    end
    
    local character = player.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local head = character:FindFirstChild("Head")
    
    if not rootPart or not humanoid or not head then return end
    
    -- Team check
    if ESP.Settings.TeamCheck and player.Team == LocalPlayer.Team then
        for _, drawing in pairs(ESP.Objects[player].Drawings) do
            drawing.Visible = false
        end
        return
    end
    
    -- Distance check
    local dist = GetDistance(rootPart)
    if dist > ESP.Settings.MaxDistance then
        for _, drawing in pairs(ESP.Objects[player].Drawings) do
            drawing.Visible = false
        end
        return
    end
    
    -- Calculate box size
    local headPos, headOnScreen = WorldToScreen(head.Position + Vector3.new(0, 0.5, 0))
    local legPos, legOnScreen = WorldToScreen(rootPart.Position - Vector3.new(0, 3, 0))
    
    if not headOnScreen or not legOnScreen then
        for _, drawing in pairs(ESP.Objects[player].Drawings) do
            drawing.Visible = false
        end
        return
    end
    
    local height = math.abs(headPos.Y - legPos.Y)
    local width = height / 2
    
    -- Update Box
    if ESP.Settings.Boxes then
        local box = ESP.Objects[player].Drawings.Box
        local boxOutline = ESP.Objects[player].Drawings.BoxOutline
        
        box.Size = Vector2.new(width, height)
        box.Position = Vector2.new(legPos.X - width/2, legPos.Y)
        box.Color = ESP.Settings.BoxColor
        box.Visible = true
        
        boxOutline.Size = box.Size
        boxOutline.Position = box.Position
        boxOutline.Visible = true
    else
        ESP.Objects[player].Drawings.Box.Visible = false
        ESP.Objects[player].Drawings.BoxOutline.Visible = false
    end
    
    -- Update Name
    if ESP.Settings.Names then
        local name = ESP.Objects[player].Drawings.Name
        name.Position = Vector2.new(headPos.X, headPos.Y - 20)
        name.Text = player.Name
        name.Visible = true
    else
        ESP.Objects[player].Drawings.Name.Visible = false
    end
    
    -- Update Health
    local healthPercent = humanoid.Health / humanoid.MaxHealth
    
    if ESP.Settings.HealthBar then
        local healthBar = ESP.Objects[player].Drawings.HealthBar
        local healthBarBg = ESP.Objects[player].Drawings.HealthBarBg
        
        healthBarBg.From = Vector2.new(legPos.X - width/2 - 6, legPos.Y)
        healthBarBg.To = Vector2.new(legPos.X - width/2 - 6, headPos.Y)
        healthBarBg.Visible = true
        
        healthBar.From = Vector2.new(legPos.X - width/2 - 6, legPos.Y)
        healthBar.To = Vector2.new(legPos.X - width/2 - 6, legPos.Y - (height * healthPercent))
        healthBar.Color = Color3.fromRGB(
            255 * (1 - healthPercent),
            255 * healthPercent,
            0
        )
        healthBar.Visible = true
        
        local healthText = ESP.Objects[player].Drawings.HealthText
        healthText.Position = Vector2.new(legPos.X - width/2 - 15, legPos.Y - (height * healthPercent) - 5)
        healthText.Text = tostring(math.floor(humanoid.Health))
        healthText.Color = healthBar.Color
        healthText.Visible = true
    else
        ESP.Objects[player].Drawings.HealthBar.Visible = false
        ESP.Objects[player].Drawings.HealthBarBg.Visible = false
        ESP.Objects[player].Drawings.HealthText.Visible = false
    end
    
    -- Update Distance
    if ESP.Settings.Distance then
        local distance = ESP.Objects[player].Drawings.Distance
        distance.Position = Vector2.new(legPos.X, legPos.Y + 5)
        distance.Text = string.format("[%d studs]", math.floor(dist))
        distance.Visible = true
    else
        ESP.Objects[player].Drawings.Distance.Visible = false
    end
    
    -- Update Tracers
    if ESP.Settings.Tracers then
        local tracer = ESP.Objects[player].Drawings.Tracer
        local screenSize = Camera.ViewportSize
        tracer.From = Vector2.new(screenSize.X / 2, screenSize.Y)
        tracer.To = legPos
        tracer.Color = ESP.Settings.TracerColor
        tracer.Visible = true
    else
        ESP.Objects[player].Drawings.Tracer.Visible = false
    end
end

-- Update Chams
local function UpdateChams(player)
    if not ESP.Settings.Chams or not IsAlive(player) then
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part:FindFirstChild("ChamHighlight") then
                    part.ChamHighlight:Destroy()
                end
            end
        end
        return
    end
    
    local character = player.Character
    if not character then return end
    
    -- Use Highlight instance (modern Roblox)
    local highlight = character:FindFirstChildOfClass("Highlight")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.Parent = character
    end
    
    -- Rainbow or team color
    if ESP.Settings.RainbowESP then
        local hue = (tick() % 5) / 5
        highlight.FillColor = Color3.fromHSV(hue, 1, 1)
        highlight.OutlineColor = Color3.fromHSV(hue, 1, 1)
    elseif ESP.Settings.TeamColor and player.Team then
        highlight.FillColor = player.Team.TeamColor.Color
        highlight.OutlineColor = player.Team.TeamColor.Color
    else
        highlight.FillColor = Color3.fromRGB(255, 100, 100)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    end
    
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Enabled = true
end

-- Initialize ESP for all players
local function InitializeESP()
    for _, player in pairs(Players:GetPlayers()) do
        CreateESP(player)
    end
    
    ESP.Connections.PlayerAdded = Players.PlayerAdded:Connect(CreateESP)
    ESP.Connections.PlayerRemoving = Players.PlayerRemoving:Connect(RemoveESP)
    
    ESP.Connections.RenderStep = RunService.RenderStepped:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            UpdateESP(player)
            if ESP.Settings.Chams then
                UpdateChams(player)
            end
        end
    end)
end

-- Cleanup ESP
local function CleanupESP()
    for _, player in pairs(Players:GetPlayers()) do
        RemoveESP(player)
    end
    
    for _, connection in pairs(ESP.Connections) do
        connection:Disconnect()
    end
    
    ESP.Connections = {}
end

-- Public Methods
function ESP:SetEnabled(value)
    self.Enabled = value
    if value then
        InitializeESP()
    else
        CleanupESP()
    end
end

function ESP:SetBoxes(value)
    self.Settings.Boxes = value
end

function ESP:SetNames(value)
    self.Settings.Names = value
end

function ESP:SetDistance(value)
    self.Settings.Distance = value
end

function ESP:SetHealthBar(value)
    self.Settings.HealthBar = value
end

function ESP:SetTracers(value)
    self.Settings.Tracers = value
end

function ESP:SetChams(value)
    self.Settings.Chams = value
end

function ESP:SetBoxColor(color)
    self.Settings.BoxColor = color
end

function ESP:SetTeamCheck(value)
    self.Settings.TeamCheck = value
end

-- Initialize ESP
function ESP:Initialize()
    -- Set up any initial state or connections
    print("[ESP] Initialized")
    return true
end

return ESP
