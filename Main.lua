--[[
    DummyHook V1.0
    Premium Roblox Universal Script
    Features: Aimbot, ESP, Crosshair with Key System
    Inspired by Aimware & Skeet UI Design
]]

local DummyHook = {
    Version = "1.0.0",
    Loaded = false,
    Authenticated = false
}

-- Key System Configuration
local KeySystem = {
    Enabled = true,
    Key = "DUMMYHOOK-PREMIUM-2025",
    KeyURL = "https://dummyhook.io/getkey", -- Placeholder URL
    Discord = "discord.gg/dummyhook"
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Load Modules
local function loadModule(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    return success and result or nil
end

-- Cool Animation with Music
local function showIntroAnimation(callback)
    print("[DummyHook] Starting intro animation")
    
    local AnimationGUI = Instance.new("ScreenGui")
    AnimationGUI.Name = "DummyHook_Animation"
    AnimationGUI.ResetOnSpawn = false
    AnimationGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.Parent = AnimationGUI
    
    local DummyHookText = Instance.new("TextLabel")
    DummyHookText.Size = UDim2.new(1, 0, 0, 100)
    DummyHookText.Position = UDim2.new(0, 0, 0.4, -50)
    DummyHookText.BackgroundTransparency = 1
    DummyHookText.Text = "DummyHook"
    DummyHookText.TextColor3 = Color3.fromRGB(130, 195, 65)
    DummyHookText.TextSize = 48
    DummyHookText.Font = Enum.Font.GothamBold
    DummyHookText.Parent = AnimationGUI
    
    local SubtitleText = Instance.new("TextLabel")
    SubtitleText.Size = UDim2.new(1, 0, 0, 50)
    SubtitleText.Position = UDim2.new(0, 0, 0.4, 50)
    SubtitleText.BackgroundTransparency = 1
    SubtitleText.Text = "The perfect Hook, for fps."
    SubtitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubtitleText.TextSize = 24
    SubtitleText.Font = Enum.Font.Gotham
    SubtitleText.Parent = AnimationGUI
    
    -- Add rainbow effect to DummyHook text
    local RainbowGradient = Instance.new("UIGradient")
    RainbowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 195, 65)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(90, 180, 220)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 90, 220))
    }
    RainbowGradient.Parent = DummyHookText
    
    AnimationGUI.Parent = CoreGui
    
    -- Animate the text
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Fade in
    local fadeInTween = TweenService:Create(Background, tweenInfo, {BackgroundTransparency = 0.7})
    fadeInTween:Play()
    
    -- Scale and fade in text
    DummyHookText.TextTransparency = 1
    SubtitleText.TextTransparency = 1
    DummyHookText.Size = UDim2.new(1, 0, 0, 0)
    SubtitleText.Size = UDim2.new(1, 0, 0, 0)
    
    local textTween1 = TweenService:Create(DummyHookText, tweenInfo, {TextTransparency = 0, Size = UDim2.new(1, 0, 0, 100)})
    local textTween2 = TweenService:Create(SubtitleText, tweenInfo, {TextTransparency = 0, Size = UDim2.new(1, 0, 0, 50)})
    
    textTween1:Play()
    textTween2:Play()
    
    -- Wait for animation to complete
    wait(2)
    
    -- Fade out
    local fadeOutTween = TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    local textFade1 = TweenService:Create(DummyHookText, TweenInfo.new(0.5), {TextTransparency = 1})
    local textFade2 = TweenService:Create(SubtitleText, TweenInfo.new(0.5), {TextTransparency = 1})
    
    fadeOutTween:Play()
    textFade1:Play()
    textFade2:Play()
    
    wait(0.5)
    AnimationGUI:Destroy()
    print("[DummyHook] Animation completed")
    
    if callback then
        callback()
    end
end

-- Key System GUI
local function createKeySystem()
    local KeyGUI = Instance.new("ScreenGui")
    KeyGUI.Name = "DummyHook_KeySystem"
    KeyGUI.ResetOnSpawn = false
    KeyGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 280)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = KeyGUI
    
    -- Accent Border (Skeet-style)
    local TopAccent = Instance.new("Frame")
    TopAccent.Size = UDim2.new(1, 0, 0, 2)
    TopAccent.BackgroundColor3 = Color3.fromRGB(130, 195, 65)
    TopAccent.BorderSizePixel = 0
    TopAccent.Parent = MainFrame
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 195, 65)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(90, 180, 220)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 90, 220))
    }
    UIGradient.Parent = TopAccent
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "DUMMYHOOK"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, 0, 0, 20)
    Subtitle.Position = UDim2.new(0, 0, 0, 50)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Premium Authentication System"
    Subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
    Subtitle.TextSize = 12
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Parent = MainFrame
    
    -- Key Input Box
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0, 380, 0, 40)
    KeyBox.Position = UDim2.new(0.5, -190, 0, 90)
    KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    KeyBox.BorderSizePixel = 0
    KeyBox.Text = ""
    KeyBox.PlaceholderText = "Enter your key here..."
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    KeyBox.TextSize = 14
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.ClearTextOnFocus = false
    KeyBox.Parent = MainFrame
    
    local KeyBoxCorner = Instance.new("UICorner")
    KeyBoxCorner.CornerRadius = UDim.new(0, 4)
    KeyBoxCorner.Parent = KeyBox
    
    -- Submit Button
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0, 180, 0, 38)
    SubmitBtn.Position = UDim2.new(0.5, -90, 0, 145)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(130, 195, 65)
    SubmitBtn.BorderSizePixel = 0
    SubmitBtn.Text = "SUBMIT KEY"
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.TextSize = 14
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.Parent = MainFrame
    
    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, 4)
    SubmitCorner.Parent = SubmitBtn
    
    -- Get Key Button
    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0, 180, 0, 35)
    GetKeyBtn.Position = UDim2.new(0.5, -90, 0, 195)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    GetKeyBtn.BorderSizePixel = 0
    GetKeyBtn.Text = "GET KEY"
    GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    GetKeyBtn.TextSize = 13
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.Parent = MainFrame
    
    local GetKeyCorner = Instance.new("UICorner")
    GetKeyCorner.CornerRadius = UDim.new(0, 4)
    GetKeyCorner.Parent = GetKeyBtn
    
    -- Discord Button
    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Size = UDim2.new(0, 180, 0, 25)
    DiscordBtn.Position = UDim2.new(0.5, -90, 0, 242)
    DiscordBtn.BackgroundTransparency = 1
    DiscordBtn.Text = "Discord: " .. KeySystem.Discord
    DiscordBtn.TextColor3 = Color3.fromRGB(90, 180, 220)
    DiscordBtn.TextSize = 11
    DiscordBtn.Font = Enum.Font.Gotham
    DiscordBtn.Parent = MainFrame
    
    -- Status Label
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, 20)
    StatusLabel.Position = UDim2.new(0, 0, 1, -25)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    StatusLabel.TextSize = 11
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Parent = MainFrame
    
    -- Shadow Effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ZIndex = 0
    Shadow.Parent = MainFrame
    
    -- Button Hover Effects
    SubmitBtn.MouseEnter:Connect(function()
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(145, 210, 80)
    end)
    SubmitBtn.MouseLeave:Connect(function()
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(130, 195, 65)
    end)
    
    GetKeyBtn.MouseEnter:Connect(function()
        GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    end)
    GetKeyBtn.MouseLeave:Connect(function()
        GetKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    end)
    
    -- Button Functionality
    SubmitBtn.MouseButton1Click:Connect(function()
        local enteredKey = KeyBox.Text
        if enteredKey == KeySystem.Key then
            StatusLabel.Text = "✓ Authentication Successful!"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            wait(1)
            KeyGUI:Destroy()
            DummyHook.Authenticated = true
            loadMainScript()
        else
            StatusLabel.Text = "✗ Invalid Key! Please try again."
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            KeyBox.Text = ""
        end
    end)
    
    GetKeyBtn.MouseButton1Click:Connect(function()
        setclipboard(KeySystem.KeyURL)
        StatusLabel.Text = "✓ Key link copied to clipboard!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
    
    DiscordBtn.MouseButton1Click:Connect(function()
        setclipboard(KeySystem.Discord)
        StatusLabel.Text = "✓ Discord copied to clipboard!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
    
    KeyGUI.Parent = CoreGui
end

-- Main Script Loader
function loadMainScript()
    print("[DummyHook] Loading main interface...")
    
    -- Create loading notification
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DummyHook";
            Text = "Loading modules...";
            Duration = 3;
            Icon = "rbxassetid://7733992358";
        })
    end)
    
    -- GitHub Repository Configuration
    -- REPLACE 'YourGitHubUsername' with your actual GitHub username
    local GITHUB_USER = "etnson9"
    local GITHUB_REPO = "DummyHook"
    local GITHUB_BRANCH = "main"
    local BASE_URL = string.format("https://raw.githubusercontent.com/%s/%s/%s/", GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH)
    
    -- Load UI Library
    local Library = loadstring(game:HttpGet(BASE_URL .. "UI/Library.lua"))()
    
    -- Load Features with error handling
    local function loadModule(name)
        local success, module = pcall(function()
            return loadstring(game:HttpGet(BASE_URL .. name))()
        end)
        
        if not success then
            warn("[DummyHook] Failed to load module: " .. name .. " - " .. tostring(module))
            return nil
        end
        
        if module == nil then
            warn("[DummyHook] Module loaded but returned nil: " .. name)
            return nil
        end
        
        print("[DummyHook] Successfully loaded: " .. name)
        return module
    end
    
    local ESP = loadModule("Features/ESP.lua")
    local Aimbot = loadModule("Features/Aimbot.lua")
    local Crosshair = loadModule("Features/Crosshair.lua")
    local Misc = loadModule("Features/Misc.lua")
    local GameExploits = loadModule("Features/GameExploits.lua")
    local PlayerManager = loadModule("Features/PlayerManager.lua")
    local CharCustomizer = loadModule("Features/CharCustomizer.lua")
    local ThemeManager = loadModule("Features/ThemeManager.lua")
    local ConfigManager = loadModule("Features/ConfigManager.lua")
    local VisualEffects = loadModule("Features/VisualEffects.lua")
    local SkinCustomizer = loadModule("Features/SkinCustomizer.lua")
    local Notifications = loadModule("Features/Notifications.lua")
    local AdvancedCheats = loadModule("Features/AdvancedCheats.lua")
    
    -- Check if all modules loaded successfully
    if not ESP or not Aimbot or not Crosshair or not Misc or not GameExploits or not PlayerManager or not CharCustomizer or not ThemeManager or not ConfigManager or not VisualEffects or not SkinCustomizer or not Notifications or not AdvancedCheats then
        warn("[DummyHook] Failed to load one or more modules. Aborting.")
        return
    end
    
    -- Initialize Game Exploits
    GameExploits:Initialize()
    
    -- Create Main Window
    local Window = Library:CreateWindow({
        Title = "DUMMYHOOK | Premium",
        Theme = "Skeet", -- Skeet/Aimware style
        Size = UDim2.new(0, 580, 0, 460),
        KeyBind = Enum.KeyCode.RightShift
    })
    
    -- Create Tabs
    local RageTab = Window:CreateTab("Rage")
    local VisualsTab = Window:CreateTab("Visuals")
    local PlayersTab = Window:CreateTab("Players")
    local MiscTab = Window:CreateTab("Misc")
    local ExploitsTab = Window:CreateTab("Exploits")
    local ConfigTab = Window:CreateTab("Config")
    
    -- Rage Tab (Aimbot)
    local AimbotSection = RageTab:CreateSection("Aimbot")
    AimbotSection:AddToggle("Enable Aimbot", false, function(value)
        Aimbot:SetEnabled(value)
    end)
    AimbotSection:AddSlider("FOV", 50, 500, 150, function(value)
        Aimbot:SetFOV(value)
    end)
    AimbotSection:AddSlider("Smoothness", 0, 100, 50, function(value)
        Aimbot:SetSmoothness(value)
    end)
    AimbotSection:AddDropdown("Target Part", {"Head", "Torso", "HumanoidRootPart"}, "Head", function(value)
        Aimbot:SetTargetPart(value)
    end)
    AimbotSection:AddToggle("Visibility Check", true, function(value)
        Aimbot:SetVisibilityCheck(value)
    end)
    AimbotSection:AddToggle("Team Check", true, function(value)
        Aimbot:SetTeamCheck(value)
    end)
    AimbotSection:AddDropdown("Lock Mode", {"Camera Lock", "Mouse Movement"}, "Camera Lock", function(value)
        Aimbot.Settings.LockMode = value == "Camera Lock" and 1 or 2
    end)
    AimbotSection:AddSlider("Mouse Sensitivity", 0.01, 0.5, 0.15, function(value)
        Aimbot.Settings.MouseSensitivity = value
    end)
    AimbotSection:AddToggle("Shake Reduction", true, function(value)
        Aimbot.Settings.ShakeReduction = value
    end)
    
    local AdvancedAimSection = RageTab:CreateSection("Advanced Aim")
    AdvancedAimSection:AddToggle("Silent Aim", false, function(value)
        Aimbot:SetSilentAim(value)
    end)
    AdvancedAimSection:AddToggle("Sticky Aim", false, function(value)
        Aimbot:SetStickyAim(value)
    end)
    AdvancedAimSection:AddToggle("Aim Assist", false, function(value)
        Aimbot:SetAimAssist(value)
    end)
    AdvancedAimSection:AddSlider("Assist Strength", 1, 100, 30, function(value)
        Aimbot.Settings.AimAssistStrength = value
    end)
    AdvancedAimSection:AddToggle("Resolver (Anti-AA)", false, function(value)
        Aimbot:SetResolver(value)
    end)
    AdvancedAimSection:AddDropdown("Resolver Mode", {"Basic", "Advanced"}, "Basic", function(value)
        Aimbot.Settings.ResolverMode = value
    end)
    AdvancedAimSection:AddToggle("Trigger Bot", false, function(value)
        Aimbot:SetTriggerBot(value)
    end)
    
    -- Visuals Tab (ESP)
    local ESPSection = VisualsTab:CreateSection("ESP")
    ESPSection:AddToggle("Enable ESP", false, function(value)
        ESP:SetEnabled(value)
    end)
    ESPSection:AddToggle("Boxes", true, function(value)
        ESP:SetBoxes(value)
    end)
    ESPSection:AddToggle("Names", true, function(value)
        ESP:SetNames(value)
    end)
    ESPSection:AddToggle("Distance", true, function(value)
        ESP:SetDistance(value)
    end)
    ESPSection:AddToggle("Health Bar", true, function(value)
        ESP:SetHealthBar(value)
    end)
    ESPSection:AddToggle("Tracers", false, function(value)
        ESP:SetTracers(value)
    end)
    ESPSection:AddToggle("Chams", false, function(value)
        ESP:SetChams(value)
    end)
    ESPSection:AddToggle("Rainbow ESP", false, function(value)
        ESP.Settings.RainbowESP = value
    end)
    ESPSection:AddToggle("Team Colors", true, function(value)
        ESP.Settings.TeamColor = value
    end)
    ESPSection:AddColorPicker("Box Color", Color3.fromRGB(255, 255, 255), function(value)
        ESP:SetBoxColor(value)
    end)
    ESPSection:AddSlider("Max Distance", 500, 5000, 2000, function(value)
        ESP.Settings.MaxDistance = value
    end)
    
    local CrosshairSection = VisualsTab:CreateSection("Crosshair")
    CrosshairSection:AddToggle("Enable Crosshair", false, function(value)
        Crosshair:SetEnabled(value)
    end)
    CrosshairSection:AddSlider("Size", 5, 50, 15, function(value)
        Crosshair:SetSize(value)
    end)
    CrosshairSection:AddSlider("Thickness", 1, 10, 2, function(value)
        Crosshair:SetThickness(value)
    end)
    CrosshairSection:AddToggle("Rainbow Mode", false, function(value)
        Crosshair:SetRainbow(value)
    end)
    CrosshairSection:AddToggle("Center Dot", false, function(value)
        Crosshair:SetDot(value)
    end)
    CrosshairSection:AddColorPicker("Color", Color3.fromRGB(0, 255, 0), function(value)
        Crosshair:SetColor(value)
    end)
    
    -- Players Tab
    local PlayerListSection = PlayersTab:CreateSection("Player List")
    
    -- Create player selection dropdown
    local playerNames = {}
    local playerObjects = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerNames, player.Name)
            playerObjects[player.Name] = player
        end
    end
    
    local selectedPlayer = nil
    PlayerListSection:AddDropdown("Select Player", playerNames, playerNames[1] or "None", function(value)
        selectedPlayer = playerObjects[value]
    end)
    
    local PlayerActionsSection = PlayersTab:CreateSection("Actions")
    PlayerActionsSection:AddButton("Spectate", function()
        if selectedPlayer then
            PlayerManager:Spectate(selectedPlayer)
        end
    end)
    PlayerActionsSection:AddButton("Stop Spectate", function()
        PlayerManager:StopSpectate()
    end)
    PlayerActionsSection:AddButton("Teleport To", function()
        if selectedPlayer then
            PlayerManager:TeleportTo(selectedPlayer)
        end
    end)
    PlayerActionsSection:AddButton("View Stats", function()
        if selectedPlayer then
            local stats = PlayerManager:GetPlayerStats(selectedPlayer)
            print("========== Player Stats ==========")
            for key, value in pairs(stats) do
                print(key .. ": " .. tostring(value))
            end
            print("==================================")
        end
    end)
    
    local FriendSection = PlayersTab:CreateSection("Friend System")
    FriendSection:AddButton("Add Friend", function()
        if selectedPlayer then
            PlayerManager:AddFriend(selectedPlayer)
        end
    end)
    FriendSection:AddButton("Remove Friend", function()
        if selectedPlayer then
            PlayerManager:RemoveFriend(selectedPlayer)
        end
    end)
    FriendSection:AddToggle("ESP Friends Only", false, function(value)
        -- Implement friend-only ESP filter
    end)
    
    -- Misc Tab
    local MovementSection = MiscTab:CreateSection("Movement")
    MovementSection:AddSlider("Walk Speed", 16, 200, 16, function(value)
        Misc:SetWalkSpeed(value)
    end)
    MovementSection:AddSlider("Jump Power", 50, 200, 50, function(value)
        Misc:SetJumpPower(value)
    end)
    
    local UtilitySection = MiscTab:CreateSection("Utility")
    UtilitySection:AddToggle("No Clip", false, function(value)
        Misc:SetNoClip(value)
    end)
    UtilitySection:AddToggle("Fly", false, function(value)
        Misc:SetFly(value)
    end)
    UtilitySection:AddToggle("Infinite Jump", false, function(value)
        Misc:SetInfiniteJump(value)
    end)
    
    -- Advanced Features (Skeet/Aimware style)
    local AdvancedSection = MiscTab:CreateSection("Advanced")
    AdvancedSection:AddToggle("SpinBot", false, function(value)
        Misc:SetSpinBot(value)
    end)
    AdvancedSection:AddSlider("Spin Speed", 1, 50, 20, function(value)
        Misc.Settings.SpinSpeed = value
    end)
    AdvancedSection:AddDropdown("Spin Mode", {"Horizontal", "Vertical", "Random", "Jitter"}, "Horizontal", function(value)
        Misc.Settings.SpinMode = value
    end)
    
    AdvancedSection:AddToggle("Anti-Aim", false, function(value)
        Misc:SetAntiAim(value)
    end)
    AdvancedSection:AddDropdown("AA Pitch", {"Down", "Up", "Jitter", "Random"}, "Down", function(value)
        Misc.Settings.AntiAimPitch = value
    end)
    AdvancedSection:AddDropdown("AA Yaw", {"Spin", "Backwards", "Jitter", "Random"}, "Spin", function(value)
        Misc.Settings.AntiAimYaw = value
    end)
    
    AdvancedSection:AddToggle("Bunny Hop", false, function(value)
        Misc:SetBunnyHop(value)
    end)
    AdvancedSection:AddToggle("Fake Lag", false, function(value)
        Misc:SetFakeLag(value)
    end)
    
    local UtilSection = MiscTab:CreateSection("Utility")
    UtilSection:AddToggle("Hide Name", false, function(value)
        Misc:SetHideName(value)
    end)
    UtilSection:AddToggle("Anti-OBS", false, function(value)
        Misc:SetAntiOBS(value)
    end)
    UtilSection:AddToggle("Chat Spam", false, function(value)
        Misc:SetChatSpam(value)
    end)
    UtilSection:AddSlider("Spam Delay", 0.5, 5, 1, function(value)
        Misc.Settings.ChatSpamDelay = value
    end)
    
    local CharSection = MiscTab:CreateSection("Character")
    CharSection:AddToggle("Rainbow Body", false, function(value)
        CharCustomizer:SetRainbowBody(value)
    end)
    CharSection:AddToggle("Big Head", false, function(value)
        CharCustomizer:SetBigHead(value)
    end)
    CharSection:AddToggle("Invisible", false, function(value)
        CharCustomizer:SetInvisible(value)
    end)
    CharSection:AddButton("Remove Accessories", function()
        CharCustomizer:RemoveAccessories()
    end)
    CharSection:AddButton("Naked", function()
        CharCustomizer:SetNaked()
    end)
    CharSection:AddButton("Restore Look", function()
        CharCustomizer:RestoreAppearance()
    end)
    
    local SkinSection = MiscTab:CreateSection("Skin Customization")
    SkinSection:AddToggle("Rainbow Body", false, function(value)
        SkinCustomizer:SetRainbowBody(value)
    end)
    SkinSection:AddSlider("Rainbow Speed", 0.1, 5, 1, function(value)
        SkinCustomizer.Settings.RainbowSpeed = value
    end)
    SkinSection:AddToggle("Rainbow Accessories", false, function(value)
        SkinCustomizer:SetRainbowAccessories(value)
    end)
    SkinSection:AddColorPicker("Body Color", Color3.fromRGB(255, 255, 255), function(value)
        SkinCustomizer:SetBodyColor(value)
    end)
    SkinSection:AddDropdown("Material", {"SmoothPlastic", "Neon", "Glass", "ForceField", "Wood", "Metal", "DiamondPlate"}, "SmoothPlastic", function(value)
        local materials = {
            SmoothPlastic = Enum.Material.SmoothPlastic,
            Neon = Enum.Material.Neon,
            Glass = Enum.Material.Glass,
            ForceField = Enum.Material.ForceField,
            Wood = Enum.Material.Wood,
            Metal = Enum.Material.Metal,
            DiamondPlate = Enum.Material.DiamondPlate
        }
        SkinCustomizer:SetMaterial(materials[value])
    end)
    SkinSection:AddSlider("Reflectance", 0, 1, 0, function(value)
        SkinCustomizer:SetReflectance(value)
    end)
    SkinSection:AddSlider("Transparency", 0, 1, 0, function(value)
        SkinCustomizer:SetTransparency(value)
    end)
    SkinSection:AddSlider("Head Scale", 0.1, 5, 1, function(value)
        SkinCustomizer:SetCharacterScale(value, SkinCustomizer.Settings.BodyScale)
    end)
    SkinSection:AddSlider("Body Scale", 0.1, 5, 1, function(value)
        SkinCustomizer:SetCharacterScale(SkinCustomizer.Settings.HeadScale, value)
    end)
    SkinSection:AddDropdown("Outfit Preset", {"Default", "Neon", "Glass", "ForceField", "Wood", "Metal", "DiamondPlate"}, "Default", function(value)
        SkinCustomizer:SetOutfitPreset(value)
    end)
    
    local KeybindsSection = MiscTab:CreateSection("Keybinds")
    KeybindsSection:AddButton("Set Aimbot Key", function()
        Notifications:Info("Keybind Setup", "Press any key to set as Aimbot key", 3)
        -- Keybind logic would go here
    end)
    KeybindsSection:AddButton("Set ESP Key", function()
        Notifications:Info("Keybind Setup", "Press any key to set as ESP key", 3)
    end)
    KeybindsSection:AddButton("Set Fly Key", function()
        Notifications:Info("Keybind Setup", "Press any key to set as Fly key", 3)
    end)
    KeybindsSection:AddButton("Reset All Keybinds", function()
        Notifications:Success("Keybinds", "All keybinds reset to defaults", 3)
    end)
    
    local AdvancedMovementSection = MiscTab:CreateSection("Advanced Movement")
    AdvancedMovementSection:AddToggle("Speed Hack", false, function(value)
        AdvancedCheats:SetSpeedHack(value)
    end)
    AdvancedMovementSection:AddSlider("Speed Multiplier", 1, 10, 2, function(value)
        AdvancedCheats.Settings.SpeedMultiplier = value
    end)
    AdvancedMovementSection:AddToggle("Fly", false, function(value)
        AdvancedCheats:SetFly(value)
    end)
    AdvancedMovementSection:AddSlider("Fly Speed", 10, 100, 50, function(value)
        AdvancedCheats.Settings.FlySpeed = value
    end)
    AdvancedMovementSection:AddToggle("Noclip", false, function(value)
        AdvancedCheats:SetNoclip(value)
    end)
    AdvancedMovementSection:AddToggle("Infinite Jump", false, function(value)
        AdvancedCheats:SetInfiniteJump(value)
    end)
    
    local AdvancedCombatSection = MiscTab:CreateSection("Advanced Combat")
    AdvancedCombatSection:AddToggle("Auto Clicker", false, function(value)
        AdvancedCheats:SetAutoClicker(value)
    end)
    AdvancedCombatSection:AddSlider("Clicks Per Second", 1, 50, 10, function(value)
        AdvancedCheats.Settings.ClicksPerSecond = value
    end)
    AdvancedCombatSection:AddToggle("Reach", false, function(value)
        AdvancedCheats:SetReach(value)
    end)
    AdvancedCombatSection:AddSlider("Reach Distance", 10, 50, 20, function(value)
        AdvancedCheats.Settings.ReachDistance = value
    end)
    AdvancedCombatSection:AddToggle("Critical Hits", false, function(value)
        AdvancedCheats.Settings.Criticals = value
    end)
    AdvancedCombatSection:AddSlider("Critical Chance", 0, 100, 50, function(value)
        AdvancedCheats.Settings.CriticalChance = value
    end)
    
    -- Exploits Tab (Game-specific)
    local SniperDuelsSection = ExploitsTab:CreateSection("Sniper Duels")
    SniperDuelsSection:AddToggle("Item Duping (Enable First)", false, function(value)
        GameExploits:SetItemDuping(value)
    end)
    SniperDuelsSection:AddButton("Dupe Current Item (x10)", function()
        -- Automatically detect currently held item
        local itemName = nil -- Let the function auto-detect
        GameExploits:DupeItem(itemName, 10)
    end)
    SniperDuelsSection:AddToggle("Infinite Money", false, function(value)
        GameExploits:SetInfiniteMoney(value)
    end)
    SniperDuelsSection:AddToggle("Infinite Ammo", false, function(value)
        GameExploits:SetInfiniteAmmo(value)
    end)
    SniperDuelsSection:AddToggle("No Recoil", false, function(value)
        GameExploits:SetNoRecoil(value)
    end)
    SniperDuelsSection:AddToggle("Rapid Fire", false, function(value)
        GameExploits:SetRapidFire(value)
    end)
    SniperDuelsSection:AddButton("Unlock All Weapons", function()
        GameExploits:SetUnlockAllWeapons(true)
    end)
    SniperDuelsSection:AddToggle("Auto Farm", false, function(value)
        GameExploits:SetAutoFarm(value)
    end)
    SniperDuelsSection:AddToggle("God Mode", false, function(value)
        GameExploits:SetGodMode(value)
    end)
    SniperDuelsSection:AddToggle("Instant Kill", false, function(value)
        GameExploits:SetInstantKill(value)
    end)
    
    local UniversalSection = ExploitsTab:CreateSection("Universal Exploits")
    UniversalSection:AddButton("Remove Kill Barriers", function()
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Name:lower():find("kill") then
                part:Destroy()
            end
        end
    end)
    UniversalSection:AddButton("Remove Laser Walls", function()
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and (part.Name:lower():find("laser") or part.Transparency > 0.9) then
                part.CanCollide = false
            end
        end
    end)
    UniversalSection:AddButton("Collect All Coins", function()
        for _, coin in pairs(workspace:GetDescendants()) do
            if coin.Name:lower():find("coin") or coin.Name:lower():find("cash") then
                if coin:IsA("BasePart") then
                    coin.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end)
    
    -- Config Tab
    ConfigManager:Initialize()
    
    local ThemeSection = ConfigTab:CreateSection("Theme Customization")
    local themeNames = ThemeManager:GetThemeNames()
    ThemeSection:AddDropdown("Select Theme", themeNames, "Skeet", function(value)
        ThemeManager:ApplyTheme(value)
        -- Reload UI with new theme
        Library:UpdateTheme(ThemeManager:GetCurrentTheme())
    end)
    
    ThemeSection:AddToggle("RGB Mode", false, function(value)
        if value then
            ThemeManager:StartRGBMode()
        else
            ThemeManager:StopRGBMode()
        end
    end)
    
    ThemeSection:AddSlider("RGB Speed", 0.1, 5, 1, function(value)
        ThemeManager:SetRGBSpeed(value)
    end)
    
    local VisualFXSection = ConfigTab:CreateSection("Visual Effects")
    VisualFXSection:AddToggle("RGB Trail", false, function(value)
        VisualEffects:SetRGBTrail(value)
    end)
    
    VisualFXSection:AddToggle("Glow Effect", false, function(value)
        VisualEffects:SetGlowEffect(value)
    end)
    
    VisualFXSection:AddToggle("Particles", false, function(value)
        VisualEffects:SetParticles(value)
    end)
    
    VisualFXSection:AddDropdown("Particle Type", {"Stars", "Sparkles", "Fire", "Magic"}, "Stars", function(value)
        VisualEffects:SetParticleType(value)
    end)
    
    VisualFXSection:AddToggle("Point Light", false, function(value)
        VisualEffects:SetPointLight(value)
    end)
    
    VisualFXSection:AddSlider("Effect Intensity", 0.1, 3, 1, function(value)
        VisualEffects:SetEffectIntensity(value)
    end)
    
    local ProfileSection = ConfigTab:CreateSection("Profile Management")
    local currentSettings = {}
    
    ProfileSection:AddButton("Save Current Profile", function()
        currentSettings.Aimbot = Aimbot.Settings
        currentSettings.ESP = ESP.Settings
        currentSettings.Misc = Misc.Settings
        currentSettings.Theme = ThemeManager.CurrentTheme
        ConfigManager:SaveProfile("Default", currentSettings)
        print("[DummyHook] Profile saved!")
    end)
    
    ProfileSection:AddButton("Load Profile", function()
        local profile = ConfigManager:LoadProfile("Default")
        if profile then
            print("[DummyHook] Profile loaded!")
        end
    end)
    
    ProfileSection:AddButton("Export to Clipboard", function()
        currentSettings.Aimbot = Aimbot.Settings
        currentSettings.ESP = ESP.Settings
        currentSettings.Misc = Misc.Settings
        local exported = ConfigManager:ExportConfig("Default")
        if exported then
            print("[DummyHook] Config exported to clipboard!")
        end
    end)
    
    ProfileSection:AddButton("Reset to Defaults", function()
        ConfigManager:ResetToDefaults()
        print("[DummyHook] Settings reset to defaults!")
    end)
    
    local ConfigSection = ConfigTab:CreateSection("Configuration")
    ConfigSection:AddToggle("Auto-Save (60s)", false, function(value)
        if value then
            currentSettings.Aimbot = Aimbot.Settings
            currentSettings.ESP = ESP.Settings
            currentSettings.Misc = Misc.Settings
            ConfigManager:EnableAutoSave(60, currentSettings)
        else
            ConfigManager:DisableAutoSave()
        end
    end)
    
    ConfigSection:AddButton("Quick Save", function()
        currentSettings.Aimbot = Aimbot.Settings
        currentSettings.ESP = ESP.Settings
        currentSettings.Misc = Misc.Settings
        ConfigManager:QuickSave(currentSettings)
        print("[DummyHook] Quick saved!")
    end)
    
    ConfigSection:AddButton("Quick Load", function()
        local loaded = ConfigManager:QuickLoad()
        if loaded then
            print("[DummyHook] Quick loaded!")
        end
    end)
    
    ConfigSection:AddButton("Unload Script", function()
        Library:Unload()
        GameExploits:Cleanup()
        Misc:Cleanup()
        VisualEffects:Cleanup()
        SkinCustomizer:Cleanup()
        Notifications:Cleanup()
        -- Reset silent aim
        pcall(function()
            if getrawmetatable then
                local mt = getrawmetatable(game)
                if mt and Aimbot.OriginalNamecall then
                    setreadonly(mt, false)
                    mt.__namecall = Aimbot.OriginalNamecall
                    setreadonly(mt, true)
                end
            end
        end)
    end)
    
    -- Initialize notifications
    Notifications:Initialize()
    
    -- Show welcome notification
    Notifications:Success("DummyHook Loaded", "Press RightShift to open the menu. Enjoy!", 5)
    
    DummyHook.Loaded = true
    print("[DummyHook] Successfully loaded!")
    
    -- Success notification
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DummyHook | Premium";
            Text = "Loaded successfully! Press RightShift to open.";
            Duration = 5;
            Icon = "rbxassetid://7733992358";
        })
    end)
    
    -- Console banner
    print("========================================")
    print("    DummyHook v1.0.0 - Premium")
    print("    Press RightShift to toggle GUI")
    print("   Have fun bby")
    print("========================================")
end

-- Initialize
showIntroAnimation(function()
    if KeySystem.Enabled then
        createKeySystem()
    else
        DummyHook.Authenticated = true
        loadMainScript()
    end
end)

return DummyHook
