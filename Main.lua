-- GitHub Configuration (Update these before pushing to your repo)
local GITHUB_USER = "limitetn"  -- Change to your GitHub username
local GITHUB_REPO = "DummyHook" -- Change to your repository name
local GITHUB_BRANCH = "main"    -- Change if using a different branch

-- Construct base URL
local BASE_URL = ("https://raw.githubusercontent.com/%s/%s/%s/"):format(GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Authenticated flag
local authenticated = false

-- Module loading with fallback
local function loadModule(moduleName, localPath)
    local success, module = pcall(function()
        return loadstring(game:HttpGet(BASE_URL .. "Features/" .. moduleName .. ".lua"))()
    end)
    
    if success and module then
        return module
    else
        -- Fallback to local file if available
        warn("[DummyHook] Failed to load " .. moduleName .. " from GitHub, trying local files...")
        if readfile then
            local localSuccess, localModule = pcall(function()
                return loadstring(readfile(localPath))()
            end)
            if localSuccess then
                return localModule
            end
        end
        warn("[DummyHook] Could not load " .. moduleName)
        return nil
    end
end

-- Simple Key System UI
local function CreateKeyUI(callback)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DummyHook_Auth"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 400, 0, 250)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -125)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Frame
    
    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.new(1, 0, 0, 3)
    Accent.BackgroundColor3 = Color3.fromRGB(130, 195, 65)
    Accent.BorderSizePixel = 0
    Accent.Parent = Frame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "DUMMYHOOK"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 28
    Title.Font = Enum.Font.GothamBold
    Title.Parent = Frame
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, 0, 0, 20)
    Subtitle.Position = UDim2.new(0, 0, 0, 55)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Enter Authentication Key"
    Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    Subtitle.TextSize = 13
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Parent = Frame
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0, 340, 0, 40)
    KeyBox.Position = UDim2.new(0.5, -170, 0, 95)
    KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    KeyBox.BorderSizePixel = 0
    KeyBox.Text = ""
    KeyBox.PlaceholderText = "Enter key..."
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.TextSize = 14
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.Parent = Frame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 4)
    BoxCorner.Parent = KeyBox
    
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0, 150, 0, 35)
    SubmitBtn.Position = UDim2.new(0.5, -75, 0, 150)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(130, 195, 65)
    SubmitBtn.Text = "SUBMIT"
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.TextSize = 14
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.BorderSizePixel = 0
    SubmitBtn.Parent = Frame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = SubmitBtn
    
    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0, 150, 0, 30)
    GetKeyBtn.Position = UDim2.new(0.5, -75, 0, 195)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    GetKeyBtn.Text = "GET KEY"
    GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    GetKeyBtn.TextSize = 12
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.BorderSizePixel = 0
    GetKeyBtn.Parent = Frame
    
    local GetKeyCorner = Instance.new("UICorner")
    GetKeyCorner.CornerRadius = UDim.new(0, 4)
    GetKeyCorner.Parent = GetKeyBtn
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, 0, 0, 15)
    Status.Position = UDim2.new(0, 0, 1, -20)
    Status.BackgroundTransparency = 1
    Status.Text = ""
    Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    Status.TextSize = 11
    Status.Font = Enum.Font.Gotham
    Status.Parent = Frame
    
    SubmitBtn.MouseButton1Click:Connect(function()
        local key = KeyBox.Text
        if key and key ~= "" then
            -- Load KeyManager to validate the key
            local KeyManager = loadModule("KeyManager", "Features/KeyManager.lua")
            if KeyManager then
                -- Initialize KeyManager
                if KeyManager.Initialize and type(KeyManager.Initialize) == "function" then
                    local success, err = pcall(function()
                        KeyManager:Initialize()
                    end)
                    if not success then
                        warn("[DummyHook] Failed to initialize KeyManager: " .. tostring(err))
                    end
                end
                
                -- Validate the key
                local isValid = KeyManager:ValidateKey(key)
                if isValid then
                    Status.Text = "✓ Success!"
                    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                    wait(0.5)
                    ScreenGui:Destroy()
                    authenticated = true
                    if callback then
                        callback()
                    end
                else
                    Status.Text = "✗ Invalid Key"
                    Status.TextColor3 = Color3.fromRGB(255, 100, 100)
                    KeyBox.Text = ""
                end
            else
                Status.Text = "✗ KeyManager not loaded"
                Status.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        else
            Status.Text = "✗ Please enter a key"
            Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    GetKeyBtn.MouseButton1Click:Connect(function()
        -- For demo purposes, we'll just show a message
        Status.Text = "✓ Use DUMMYHOOK-PREMIUM-2025 for demo"
        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
end

-- Main Script Loading
local function LoadMainScript()
    print("[DummyHook] Authenticated! Loading main script...")
    
    -- Load UI Library
    local Library = loadstring(game:HttpGet(BASE_URL .. "UI/Library.lua"))()

    -- Create Window
    local Window = Library:CreateWindow({
        Title = "DummyHook - Advanced Cheat Suite",
        Theme = "Skeet",
        Size = UDim2.new(0, 580, 0, 460),
        KeyBind = Enum.KeyCode.RightShift
    })

    -- Load core modules
    local Notifications = loadModule("Notifications", "Features/Notifications.lua")
    local KeyManager = loadModule("KeyManager", "Features/KeyManager.lua")
    local Aimbot = loadModule("Aimbot", "Features/Aimbot.lua")
    local ESP = loadModule("ESP", "Features/ESP.lua")
    local Crosshair = loadModule("Crosshair", "Features/Crosshair.lua")
    local Misc = loadModule("Misc", "Features/Misc.lua")
    local PlayerManager = loadModule("PlayerManager", "Features/PlayerManager.lua")
    local ThemeManager = loadModule("ThemeManager", "Features/ThemeManager.lua")
    local VisualEffects = loadModule("VisualEffects", "Features/VisualEffects.lua")
    local AdvancedCheats = loadModule("AdvancedCheats", "Features/AdvancedCheats.lua")
    local GameExploits = loadModule("GameExploits", "Features/GameExploits.lua")
    local CharCustomizer = loadModule("CharCustomizer", "Features/CharCustomizer.lua")
    local SkinCustomizer = loadModule("SkinCustomizer", "Features/SkinCustomizer.lua")
    local ConfigManager = loadModule("ConfigManager", "Features/ConfigManager.lua")

    -- Load Sniper Duels specific modules
    local SniperDuels = loadModule("SniperDuels", "Features/SniperDuels.lua")

    -- Check if all modules loaded successfully
    local modulesLoaded = true
    local missingModules = {}

    local requiredModules = {
        {"Notifications", Notifications},
        {"KeyManager", KeyManager},
        {"Aimbot", Aimbot},
        {"ESP", ESP},
        {"Crosshair", Crosshair},
        {"Misc", Misc},
        {"PlayerManager", PlayerManager},
        {"ThemeManager", ThemeManager},
        {"VisualEffects", VisualEffects},
        {"AdvancedCheats", AdvancedCheats},
        {"GameExploits", GameExploits},
        {"CharCustomizer", CharCustomizer},
        {"SkinCustomizer", SkinCustomizer},
        {"ConfigManager", ConfigManager},
        {"SniperDuels", SniperDuels}
    }

    for _, module in ipairs(requiredModules) do
        if not module[2] then
            modulesLoaded = false
            table.insert(missingModules, module[1])
        end
    end

    if not modulesLoaded then
        warn("[DummyHook] Warning: The following modules failed to load: " .. table.concat(missingModules, ", "))
        warn("[DummyHook] Some features may not work correctly.")
    end

    -- Initialize modules that need initialization
    -- Only call Initialize if the module exists and has an Initialize method
    local function safeInitialize(module)
        if module and type(module) == "table" and module.Initialize and type(module.Initialize) == "function" then
            local success, err = pcall(function()
                module:Initialize()
            end)
            if not success then
                warn("[DummyHook] Failed to initialize module: " .. tostring(err))
            end
        end
    end

    safeInitialize(Notifications)
    safeInitialize(KeyManager)
    safeInitialize(GameExploits)
    safeInitialize(ConfigManager)
    safeInitialize(SniperDuels)

    -- Initialize modules that have local Initialize functions
    if Aimbot and type(Aimbot) == "table" and Aimbot.Initialize and type(Aimbot.Initialize) == "function" then
        Aimbot.Initialize()
    end

    if ESP and type(ESP) == "table" and ESP.Initialize and type(ESP.Initialize) == "function" then
        ESP.Initialize()
    end

    if Crosshair and type(Crosshair) == "table" and Crosshair.Initialize and type(Crosshair.Initialize) == "function" then
        Crosshair.Initialize()
    end

    if ThemeManager and type(ThemeManager) == "table" then
        if ThemeManager.Initialize and type(ThemeManager.Initialize) == "function" then
            ThemeManager:Initialize(Window)
        end
    end

    -- Create Tabs with debugging
    print("[DummyHook] Creating tabs...")
    
    -- Rage Tab
    local RageTab = Window:CreateTab("Rage")
    print("[DummyHook] Created Rage tab")
    
    -- Aimbot Section
    local AimbotSection = RageTab:CreateSection("Aimbot")
    AimbotSection:AddToggle("Enabled", false, function(state)
        if Aimbot then
            Aimbot.Enabled = state
        end
    end)
    
    AimbotSection:AddSlider("FOV", 150, 10, 500, 1, function(value)
        if Aimbot then
            Aimbot.Settings.FOV = value
        end
    end)
    
    AimbotSection:AddSlider("Smoothness", 50, 1, 100, 1, function(value)
        if Aimbot then
            Aimbot.Settings.Smoothness = value
        end
    end)
    
    AimbotSection:AddDropdown("Target Part", {"Head", "Torso", "Closest"}, "Head", function(option)
        if Aimbot then
            Aimbot.Settings.TargetPart = option
        end
    end)
    
    AimbotSection:AddToggle("Visibility Check", true, function(state)
        if Aimbot then
            Aimbot.Settings.VisibilityCheck = state
        end
    end)
    
    AimbotSection:AddToggle("Team Check", true, function(state)
        if Aimbot then
            Aimbot.Settings.TeamCheck = state
        end
    end)
    
    -- TriggerBot Section
    local TriggerBotSection = RageTab:CreateSection("TriggerBot")
    TriggerBotSection:AddToggle("Enabled", false, function(state)
        if Aimbot then
            Aimbot.Settings.TriggerBot = state
        end
    end)
    
    TriggerBotSection:AddSlider("Trigger Delay", 100, 1, 1000, 1, function(value)
        if Aimbot then
            Aimbot.Settings.TriggerDelay = value
        end
    end)
    
    -- Anti-Aim Section
    local AntiAimSection = RageTab:CreateSection("Anti-Aim")
    AntiAimSection:AddToggle("Enabled", false, function(state)
        if AdvancedCheats then
            AdvancedCheats.Settings.AntiAim = state
        end
    end)
    
    AntiAimSection:AddDropdown("Pitch", {"Up", "Down", "Jitter", "Random"}, "Down", function(option)
        if AdvancedCheats then
            AdvancedCheats.Settings.AntiAimPitch = option
        end
    end)
    
    AntiAimSection:AddDropdown("Yaw", {"Spin", "Backwards", "Jitter", "Random"}, "Spin", function(option)
        if AdvancedCheats then
            AdvancedCheats.Settings.AntiAimYaw = option
        end
    end)
    
    -- Resolver Section
    local ResolverSection = RageTab:CreateSection("Resolver")
    ResolverSection:AddToggle("Enabled", false, function(state)
        if Aimbot then
            Aimbot.Settings.Resolver = state
        end
    end)
    
    ResolverSection:AddDropdown("Mode", {"Basic", "Advanced"}, "Basic", function(option)
        if Aimbot then
            Aimbot.Settings.ResolverMode = option
        end
    end)
    
    -- Visuals Tab
    local VisualsTab = Window:CreateTab("Visuals")
    print("[DummyHook] Created Visuals tab")
    
    -- ESP Section
    local ESPSection = VisualsTab:CreateSection("ESP")
    ESPSection:AddToggle("Enabled", false, function(state)
        if ESP then
            ESP.Enabled = state
        end
    end)
    
    ESPSection:AddToggle("Box ESP", true, function(state)
        if ESP then
            ESP.Settings.BoxESP = state
        end
    end)
    
    ESPSection:AddToggle("Name ESP", true, function(state)
        if ESP then
            ESP.Settings.NameESP = state
        end
    end)
    
    ESPSection:AddToggle("Health ESP", true, function(state)
        if ESP then
            ESP.Settings.HealthESP = state
        end
    end)
    
    ESPSection:AddToggle("Distance ESP", false, function(state)
        if ESP then
            ESP.Settings.DistanceESP = state
        end
    end)
    
    ESPSection:AddToggle("Weapon ESP", false, function(state)
        if ESP then
            ESP.Settings.WeaponESP = state
        end
    end)
    
    -- Crosshair Section
    local CrosshairSection = VisualsTab:CreateSection("Crosshair")
    CrosshairSection:AddToggle("Enabled", true, function(state)
        if Crosshair then
            Crosshair.Enabled = state
        end
    end)
    
    CrosshairSection:AddDropdown("Style", {"Cross", "Circle", "Square"}, "Cross", function(option)
        if Crosshair then
            Crosshair.Settings.Style = option
        end
    end)
    
    CrosshairSection:AddSlider("Size", 20, 5, 50, 1, function(value)
        if Crosshair then
            Crosshair.Settings.Size = value
        end
    end)
    
    CrosshairSection:AddSlider("Thickness", 2, 1, 5, 1, function(value)
        if Crosshair then
            Crosshair.Settings.Thickness = value
        end
    end)
    
    CrosshairSection:AddToggle("Dot", true, function(state)
        if Crosshair then
            Crosshair.Settings.Dot = state
        end
    end)
    
    CrosshairSection:AddToggle("Outline", true, function(state)
        if Crosshair then
            Crosshair.Settings.Outline = state
        end
    end)
    
    -- Chams Section
    local ChamsSection = VisualsTab:CreateSection("Chams")
    ChamsSection:AddToggle("Enabled", false, function(state)
        if VisualEffects then
            VisualEffects.Settings.Chams = state
        end
    end)
    
    ChamsSection:AddToggle("Visible Chams", true, function(state)
        if VisualEffects then
            VisualEffects.Settings.VisibleChams = state
        end
    end)
    
    ChamsSection:AddToggle("Occluded Chams", false, function(state)
        if VisualEffects then
            VisualEffects.Settings.OccludedChams = state
        end
    end)
    
    -- Glow Section
    local GlowSection = VisualsTab:CreateSection("Glow")
    GlowSection:AddToggle("Enabled", false, function(state)
        if VisualEffects then
            VisualEffects.Settings.Glow = state
        end
    end)
    
    GlowSection:AddSlider("Glow Intensity", 50, 1, 100, 1, function(value)
        if VisualEffects then
            VisualEffects.Settings.GlowIntensity = value
        end
    end)
    
    -- Misc Tab
    local MiscTab = Window:CreateTab("Misc")
    print("[DummyHook] Created Misc tab")
    
    -- Movement Section
    local MovementSection = MiscTab:CreateSection("Movement")
    MovementSection:AddSlider("Walk Speed", 16, 1, 100, 1, function(value)
        if Misc then
            Misc:SetWalkSpeed(value)
        end
    end)
    
    MovementSection:AddSlider("Jump Power", 50, 1, 200, 1, function(value)
        if Misc then
            Misc:SetJumpPower(value)
        end
    end)
    
    MovementSection:AddToggle("Infinite Jump", false, function(state)
        if Misc then
            Misc.Settings.InfiniteJump = state
        end
    end)
    
    MovementSection:AddToggle("No Clip", false, function(state)
        if Misc then
            Misc:SetNoClip(state)
        end
    end)
    
    MovementSection:AddToggle("Fly", false, function(state)
        if Misc then
            Misc:SetFly(state)
        end
    end)
    
    MovementSection:AddSlider("Fly Speed", 50, 1, 200, 1, function(value)
        if Misc then
            Misc.Settings.FlySpeed = value
        end
    end)
    
    -- Bunny Hop Section
    local BunnyHopSection = MiscTab:CreateSection("Bunny Hop")
    BunnyHopSection:AddToggle("Enabled", false, function(state)
        if Misc then
            Misc.Settings.BunnyHop = state
        end
    end)
    
    BunnyHopSection:AddSlider("Strafe Speed", 1, 1, 10, 1, function(value)
        if Misc then
            Misc.Settings.AutoStrafeSpeed = value
        end
    end)
    
    -- SpinBot Section
    local SpinBotSection = MiscTab:CreateSection("SpinBot")
    SpinBotSection:AddToggle("Enabled", false, function(state)
        if Misc then
            Misc.Settings.SpinBot = state
        end
    end)
    
    SpinBotSection:AddSlider("Spin Speed", 20, 1, 100, 1, function(value)
        if Misc then
            Misc.Settings.SpinSpeed = value
        end
    end)
    
    SpinBotSection:AddDropdown("Spin Mode", {"Horizontal", "Vertical", "Random", "Jitter"}, "Horizontal", function(option)
        if Misc then
            Misc.Settings.SpinMode = option
        end
    end)
    
    -- Player List Section
    local PlayerListSection = MiscTab:CreateSection("Player List")
    PlayerListSection:AddToggle("Enabled", true, function(state)
        if PlayerManager then
            PlayerManager.Enabled = state
        end
    end)
    
    PlayerListSection:AddToggle("Team Colors", true, function(state)
        if PlayerManager then
            PlayerManager.Settings.TeamColors = state
        end
    end)
    
    -- Exploits Tab
    local ExploitsTab = Window:CreateTab("Exploits")
    print("[DummyHook] Created Exploits tab")
    
    -- Game Exploits Section
    local GameExploitsSection = ExploitsTab:CreateSection("Game Exploits")
    GameExploitsSection:AddToggle("Infinite Money", false, function(state)
        if GameExploits then
            GameExploits.Settings.InfiniteMoney = state
        end
    end)
    
    GameExploitsSection:AddToggle("Instant Reload", false, function(state)
        if GameExploits then
            GameExploits.Settings.InstantReload = state
        end
    end)
    
    GameExploitsSection:AddToggle("No Recoil", false, function(state)
        if GameExploits then
            GameExploits.Settings.NoRecoil = state
        end
    end)
    
    GameExploitsSection:AddToggle("No Spread", false, function(state)
        if GameExploits then
            GameExploits.Settings.NoSpread = state
        end
    end)
    
    -- Character Customizer Section
    local CharCustomizerSection = ExploitsTab:CreateSection("Character Customizer")
    CharCustomizerSection:AddToggle("Enabled", false, function(state)
        if CharCustomizer then
            CharCustomizer.Enabled = state
        end
    end)
    
    CharCustomizerSection:AddSlider("Size Modifier", 100, 1, 200, 1, function(value)
        if CharCustomizer then
            CharCustomizer.Settings.SizeModifier = value
        end
    end)
    
    CharCustomizerSection:AddToggle("Headless", false, function(state)
        if CharCustomizer then
            CharCustomizer.Settings.Headless = state
        end
    end)
    
    CharCustomizerSection:AddToggle("Invisible", false, function(state)
        if CharCustomizer then
            CharCustomizer.Settings.Invisible = state
        end
    end)
    
    -- Skin Customizer Section
    local SkinCustomizerSection = ExploitsTab:CreateSection("Skin Customizer")
    SkinCustomizerSection:AddToggle("Enabled", false, function(state)
        if SkinCustomizer then
            SkinCustomizer.Enabled = state
        end
    end)
    
    SkinCustomizerSection:AddButton("Apply Rainbow Skins", function()
        if SkinCustomizer then
            SkinCustomizer:ApplyRainbowSkins()
            if Notifications then
                Notifications:Success("Skin Customizer", "Applied rainbow skins!", 3)
            end
        end
    end)
    
    SkinCustomizerSection:AddButton("Reset Skins", function()
        if SkinCustomizer then
            SkinCustomizer:ResetSkins()
            if Notifications then
                Notifications:Success("Skin Customizer", "Skins reset!", 3)
            end
        end
    end)
    
    -- Sniper Duels Tab
    local SniperDuelsTab = Window:CreateTab("Sniper Duels")
    print("[DummyHook] Created Sniper Duels tab")
    
    -- Create specialized section for Sniper Duels
    local SniperDuelsSpecializedSection = SniperDuelsTab:CreateSection("Sniper Duels Specialized")
    
    -- Add Sniper Duels specific buttons
    SniperDuelsSpecializedSection:AddButton("Dupe All Skins (x1)", function()
        if SniperDuels then
            local skins = SniperDuels:GetDetectedSkins()
            for _, skinName in ipairs(skins) do
                SniperDuels:DupeSkin(skinName, 1)
                wait(0.1)
            end
            if Notifications then
                Notifications:Success("Sniper Duels", "Duped all skins!", 3)
            end
        end
    end)
    
    -- Free Currency Generation
    SniperDuelsSpecializedSection:AddButton("Generate Free Currency", function()
        if SniperDuels then
            SniperDuels:GenerateFreeCurrency(1000000)
            if Notifications then
                Notifications:Success("Sniper Duels", "Generated 1,000,000 free currency!", 3)
            end
        end
    end)
    
    -- Case Opening Section
    local CaseOpeningSection = SniperDuelsTab:CreateSection("Case Opening")
    CaseOpeningSection:AddToggle("Auto Open Cases", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.AutoOpenCases = state
            SniperDuels:SetAutoOpenCases(state)
        end
    end)
    
    CaseOpeningSection:AddSlider("Case Open Speed", 1, 1, 10, 1, function(value)
        if SniperDuels then
            SniperDuels.Settings.CaseOpenSpeed = value
        end
    end)
    
    -- Updated case names to match Sniper Duels actual case identifiers
    local caseNames = {
        "Release",           -- Release Case
        "Halloween2025",     -- Hallows Basket
        "Beta",
        "Alpha", 
        "Omega"
    }
    
    CaseOpeningSection:AddDropdown("Open Specific Case", caseNames, "Release", function(caseName)
        if SniperDuels then
            SniperDuels:OpenCase(caseName)
            if Notifications then
                Notifications:Success("Sniper Duels", "Opening " .. caseName .. " case!", 3)
            end
        end
    end)
    
    -- Config Tab
    local ConfigTab = Window:CreateTab("Config")
    print("[DummyHook] Created Config tab")
    
    -- Settings Section
    local SettingsSection = ConfigTab:CreateSection("Settings")
    
    SettingsSection:AddToggle("Key System", true, function(state)
        if KeyManager then
            KeyManager.Enabled = state
        end
    end)
    
    SettingsSection:AddToggle("Notifications", true, function(state)
        if Notifications then
            Notifications.Enabled = state
        end
    end)
    
    -- Theme Section
    local ThemeSection = ConfigTab:CreateSection("Theme")
    
    ThemeSection:AddDropdown("Theme Preset", {"Skeet", "Aimware", "Custom"}, "Skeet", function(theme)
        if ThemeManager then
            ThemeManager:SetTheme(theme)
        end
    end)
    
    ThemeSection:AddToggle("RGB Mode", false, function(state)
        if ThemeManager then
            ThemeManager.RGBMode = state
        end
    end)
    
    -- Save/Load Config Section
    local ConfigSection = ConfigTab:CreateSection("Configuration")
    
    ConfigSection:AddButton("Save Config", function()
        if ConfigManager then
            ConfigManager:SaveConfig("default")
            if Notifications then
                Notifications:Success("Config", "Configuration saved!", 3)
            end
        end
    end)
    
    ConfigSection:AddButton("Load Config", function()
        if ConfigManager then
            ConfigManager:LoadConfig("default")
            if Notifications then
                Notifications:Success("Config", "Configuration loaded!", 3)
            end
        end
    end)
    
    ConfigSection:AddButton("Reset Config", function()
        if ConfigManager then
            ConfigManager:ResetConfig()
            if Notifications then
                Notifications:Success("Config", "Configuration reset!", 3)
            end
        end
    end)
    
    -- Info Section
    local InfoSection = ConfigTab:CreateSection("Information")
    
    InfoSection:AddLabel("Version: v1.0.0")
    InfoSection:AddLabel("Status: Loaded")
    InfoSection:AddLabel("Modules: " .. (modulesLoaded and "All Loaded" or "Some Missing"))
    
    -- Final initialization
    print("[DummyHook] Main script loaded successfully!")
    print("[DummyHook] All tabs created. Press RightShift to open the menu.")
    
    if Notifications then
        Notifications:Success("DummyHook", "Loaded successfully! Press RightShift to open.", 5)
    end
end

-- Initialize
CreateKeyUI(LoadMainScript)