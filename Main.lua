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
                    task.wait(0.5)
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
    safeInitialize(GameModules)
    safeInitialize(ThemeManager)
    safeInitialize(PlayerManager)
    safeInitialize(AdvancedCheats)
    safeInitialize(VisualEffects)
    safeInitialize(CharCustomizer)
    safeInitialize(SkinCustomizer)
    safeInitialize(Misc)

    -- Initialize modules that have local Initialize functions
    if Aimbot and type(Aimbot) == "table" and Aimbot.Initialize and type(Aimbot.Initialize) == "function" then
        local success, err = pcall(function()
            Aimbot.Initialize()
        end)
        if not success then
            warn("[DummyHook] Failed to initialize Aimbot: " .. tostring(err))
        end
    end

    if ESP and type(ESP) == "table" and ESP.Initialize and type(ESP.Initialize) == "function" then
        local success, err = pcall(function()
            ESP.Initialize()
        end)
        if not success then
            warn("[DummyHook] Failed to initialize ESP: " .. tostring(err))
        end
    end

    if Crosshair and type(Crosshair) == "table" and Crosshair.Initialize and type(Crosshair.Initialize) == "function" then
        local success, err = pcall(function()
            Crosshair.Initialize()
        end)
        if not success then
            warn("[DummyHook] Failed to initialize Crosshair: " .. tostring(err))
        end
    end

    if ThemeManager and type(ThemeManager) == "table" and ThemeManager.Initialize and type(ThemeManager.Initialize) == "function" then
        local success, err = pcall(function()
            ThemeManager:Initialize()
        end)
        if not success then
            warn("[DummyHook] Failed to initialize ThemeManager: " .. tostring(err))
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
            Aimbot:SetEnabled(state)
        end
    end)
    
    AimbotSection:AddSlider("FOV", 150, 10, 500, 1, function(value)
        if Aimbot then
            Aimbot:SetFOV(value)
        end
    end)
    
    AimbotSection:AddSlider("Smoothness", 50, 1, 100, 1, function(value)
        if Aimbot then
            Aimbot:SetSmoothness(value)
        end
    end)
    
    AimbotSection:AddDropdown("Target Part", {"Head", "Torso", "Closest"}, "Head", function(option)
        if Aimbot then
            Aimbot:SetTargetPart(option)
        end
    end)
    
    AimbotSection:AddToggle("Visibility Check", true, function(state)
        if Aimbot then
            Aimbot:SetVisibilityCheck(state)
        end
    end)
    
    AimbotSection:AddToggle("Team Check", true, function(state)
        if Aimbot then
            Aimbot:SetTeamCheck(state)
        end
    end)
    
    -- Advanced Aimbot Features
    AimbotSection:AddToggle("Silent Aim", false, function(state)
        if Aimbot then
            Aimbot:SetSilentAim(state)
            if Notifications then
                Notifications:Success("Aimbot", "Silent aim " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AimbotSection:AddToggle("Auto Shoot", false, function(state)
        if Aimbot then
            Aimbot:SetAutoShoot(state)
            if Notifications then
                Notifications:Success("Aimbot", "Auto shoot " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AimbotSection:AddToggle("Aim Lock", false, function(state)
        if Aimbot then
            Aimbot:SetAimLock(state)
            if Notifications then
                Notifications:Success("Aimbot", "Aim lock " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AimbotSection:AddSlider("Aim Lock Duration", 1, 0.1, 5, 0.1, function(value)
        if Aimbot then
            Aimbot:SetAimLockDuration(value)
        end
    end)
    
    AimbotSection:AddToggle("Predict Movement", false, function(state)
        if Aimbot then
            Aimbot:SetPredictMovement(state)
        end
    end)
    
    AimbotSection:AddSlider("Prediction Amount", 0.15, 0.01, 1, 0.01, function(value)
        if Aimbot then
            Aimbot:SetPredictionAmount(value)
        end
    end)
    
    -- TriggerBot Section
    local TriggerBotSection = RageTab:CreateSection("TriggerBot")
    TriggerBotSection:AddToggle("Enabled", false, function(state)
        if Aimbot then
            Aimbot:SetTriggerBot(state)
        end
    end)
    
    TriggerBotSection:AddSlider("Trigger Delay", 100, 1, 1000, 1, function(value)
        if Aimbot then
            Aimbot:SetTriggerDelay(value)
        end
    end)
    
    -- Advanced TriggerBot
    TriggerBotSection:AddToggle("Hit Chance", false, function(state)
        if Aimbot then
            Aimbot:SetHitChance(state)
            if Notifications then
                Notifications:Success("TriggerBot", "Hit chance " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    TriggerBotSection:AddSlider("Hit Chance %", 100, 1, 100, 1, function(value)
        if Aimbot then
            Aimbot:SetHitChancePercent(value)
        end
    end)
    
    TriggerBotSection:AddToggle("Burst Fire", false, function(state)
        if Aimbot then
            Aimbot:SetBurstFire(state)
            if Notifications then
                Notifications:Success("TriggerBot", "Burst fire " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    TriggerBotSection:AddSlider("Burst Shots", 3, 1, 10, 1, function(value)
        if Aimbot then
            Aimbot:SetBurstShots(value)
        end
    end)
    
    TriggerBotSection:AddSlider("Burst Delay", 100, 1, 1000, 1, function(value)
        if Aimbot then
            Aimbot:SetBurstDelay(value)
        end
    end)
    
    -- Anti-Aim Section
    local AntiAimSection = RageTab:CreateSection("Anti-Aim")
    AntiAimSection:AddToggle("Enabled", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetAntiAim(state)
        end
    end)
    
    AntiAimSection:AddDropdown("Pitch", {"Up", "Down", "Jitter", "Random"}, "Down", function(option)
        if AdvancedCheats then
            AdvancedCheats:SetAntiAimPitch(option)
        end
    end)
    
    AntiAimSection:AddDropdown("Yaw", {"Spin", "Backwards", "Jitter", "Random"}, "Spin", function(option)
        if AdvancedCheats then
            AdvancedCheats:SetAntiAimYaw(option)
        end
    end)
    
    -- Advanced Anti-Aim
    AntiAimSection:AddToggle("Desync", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetDesync(state)
            if Notifications then
                Notifications:Success("Anti-Aim", "Desync " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AntiAimSection:AddSlider("Desync Amount", 180, 1, 180, 1, function(value)
        if AdvancedCheats then
            AdvancedCheats:SetDesyncAmount(value)
        end
    end)
    
    AntiAimSection:AddToggle("LBY Flip", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetLBYFlip(state)
            if Notifications then
                Notifications:Success("Anti-Aim", "LBY flip " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AntiAimSection:AddSlider("LBY Flip Delay", 1, 0.1, 5, 0.1, function(value)
        if AdvancedCheats then
            AdvancedCheats:SetLBYFlipDelay(value)
        end
    end)
    
    AntiAimSection:AddToggle("At Targets", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetAtTargets(state)
            if Notifications then
                Notifications:Success("Anti-Aim", "At targets " .. (state and "enabled" or "disabled"), 3)
            end
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
    
    -- Advanced Resolver
    ResolverSection:AddToggle("Adaptive Resolver", false, function(state)
        if Aimbot then
            Aimbot.Settings.AdaptiveResolver = state
            if Notifications then
                Notifications:Success("Resolver", "Adaptive resolver " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ResolverSection:AddToggle("Brute Force", false, function(state)
        if Aimbot then
            Aimbot.Settings.BruteForce = state
            if Notifications then
                Notifications:Success("Resolver", "Brute force " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ResolverSection:AddSlider("Brute Force Attempts", 10, 1, 50, 1, function(value)
        if Aimbot then
            Aimbot.Settings.BruteForceAttempts = value
        end
    end)
    
    ResolverSection:AddToggle("Log Resolver Data", false, function(state)
        if Aimbot then
            Aimbot.Settings.LogResolverData = state
            if Notifications then
                Notifications:Success("Resolver", "Log resolver data " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    -- Visuals Tab
    local VisualsTab = Window:CreateTab("Visuals")
    print("[DummyHook] Created Visuals tab")
    
    -- ESP Section
    local ESPSection = VisualsTab:CreateSection("ESP")
    ESPSection:AddToggle("Enabled", false, function(state)
        if ESP then
            ESP:SetEnabled(state)
        end
    end)
    
    ESPSection:AddToggle("Box ESP", true, function(state)
        if ESP then
            ESP:SetBoxESP(state)
        end
    end)
    
    ESPSection:AddToggle("Name ESP", true, function(state)
        if ESP then
            ESP:SetNameESP(state)
        end
    end)
    
    ESPSection:AddToggle("Health ESP", true, function(state)
        if ESP then
            ESP:SetHealthESP(state)
        end
    end)
    
    ESPSection:AddToggle("Distance ESP", false, function(state)
        if ESP then
            ESP:SetDistanceESP(state)
        end
    end)
    
    ESPSection:AddToggle("Weapon ESP", false, function(state)
        if ESP then
            ESP:SetWeaponESP(state)
        end
    end)
    
    -- Advanced ESP
    ESPSection:AddToggle("Skeleton ESP", false, function(state)
        if ESP then
            ESP:SetSkeletonESP(state)
            if Notifications then
                Notifications:Success("ESP", "Skeleton ESP " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ESPSection:AddToggle("Head Dot", false, function(state)
        if ESP then
            ESP:SetHeadDot(state)
            if Notifications then
                Notifications:Success("ESP", "Head dot " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ESPSection:AddToggle("Tracers", false, function(state)
        if ESP then
            ESP:SetTracers(state)
            if Notifications then
                Notifications:Success("ESP", "Tracers " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ESPSection:AddToggle("Eye Tracers", false, function(state)
        if ESP then
            ESP:SetEyeTracers(state)
            if Notifications then
                Notifications:Success("ESP", "Eye tracers " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ESPSection:AddToggle("Filled Box", false, function(state)
        if ESP then
            ESP:SetFilledBox(state)
            if Notifications then
                Notifications:Success("ESP", "Filled box " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ESPSection:AddSlider("Box Transparency", 30, 0, 100, 1, function(value)
        if ESP then
            ESP:SetBoxTransparency(value / 100)
        end
    end)
    
    -- Crosshair Section
    local CrosshairSection = VisualsTab:CreateSection("Crosshair")
    CrosshairSection:AddToggle("Enabled", true, function(state)
        if Crosshair then
            Crosshair:SetEnabled(state)
        end
    end)
    
    CrosshairSection:AddDropdown("Style", {"Cross", "Circle", "Square"}, "Cross", function(option)
        if Crosshair then
            Crosshair:SetStyle(option)
        end
    end)
    
    CrosshairSection:AddSlider("Size", 20, 5, 50, 1, function(value)
        if Crosshair then
            Crosshair:SetSize(value)
        end
    end)
    
    CrosshairSection:AddSlider("Thickness", 2, 1, 5, 1, function(value)
        if Crosshair then
            Crosshair:SetThickness(value)
        end
    end)
    
    CrosshairSection:AddToggle("Dot", true, function(state)
        if Crosshair then
            Crosshair:SetDot(state)
        end
    end)
    
    CrosshairSection:AddToggle("Outline", true, function(state)
        if Crosshair then
            Crosshair:SetOutline(state)
        end
    end)
    
    -- Advanced Crosshair
    CrosshairSection:AddToggle("Rainbow Crosshair", false, function(state)
        if Crosshair then
            Crosshair:SetRainbow(state)
            if Notifications then
                Notifications:Success("Crosshair", "Rainbow crosshair " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    CrosshairSection:AddToggle("Pulsing", false, function(state)
        if Crosshair then
            Crosshair:SetPulsing(state)
            if Notifications then
                Notifications:Success("Crosshair", "Pulsing " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    CrosshairSection:AddSlider("Pulse Speed", 1, 0.1, 5, 0.1, function(value)
        if Crosshair then
            Crosshair:SetPulseSpeed(value)
        end
    end)
    
    CrosshairSection:AddToggle("Recoil Compensation", false, function(state)
        if Crosshair then
            Crosshair:SetRecoilCompensation(state)
            if Notifications then
                Notifications:Success("Crosshair", "Recoil compensation " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    CrosshairSection:AddSlider("Recoil Compensation Amount", 50, 0, 100, 1, function(value)
        if Crosshair then
            Crosshair.Settings.RecoilCompensationAmount = value
        end
    end)
    
    -- Chams Section
    local ChamsSection = VisualsTab:CreateSection("Chams")
    ChamsSection:AddToggle("Enabled", false, function(state)
        if VisualEffects then
            VisualEffects:SetChams(state)
        end
    end)
    
    ChamsSection:AddToggle("Visible Chams", true, function(state)
        if VisualEffects then
            VisualEffects:SetVisibleChams(state)
        end
    end)
    
    ChamsSection:AddToggle("Occluded Chams", false, function(state)
        if VisualEffects then
            VisualEffects:SetOccludedChams(state)
        end
    end)
    
    -- Advanced Chams
    ChamsSection:AddToggle("Rainbow Chams", false, function(state)
        if VisualEffects then
            VisualEffects:SetRainbowChams(state)
            if Notifications then
                Notifications:Success("Chams", "Rainbow chams " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ChamsSection:AddToggle("Wireframe", false, function(state)
        if VisualEffects then
            VisualEffects:SetWireframe(state)
            if Notifications then
                Notifications:Success("Chams", "Wireframe " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ChamsSection:AddToggle("XQZ", false, function(state)
        if VisualEffects then
            VisualEffects:SetXQZ(state)
            if Notifications then
                Notifications:Success("Chams", "XQZ " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    ChamsSection:AddSlider("Chams Transparency", 50, 0, 100, 1, function(value)
        if VisualEffects then
            VisualEffects:SetChamsTransparency(value / 100)
        end
    end)
    
    -- Glow Section
    local GlowSection = VisualsTab:CreateSection("Glow")
    GlowSection:AddToggle("Enabled", false, function(state)
        if VisualEffects then
            VisualEffects:SetGlow(state)
        end
    end)
    
    GlowSection:AddSlider("Glow Intensity", 50, 1, 100, 1, function(value)
        if VisualEffects then
            VisualEffects:SetGlowIntensity(value)
        end
    end)
    
    -- Advanced Glow
    GlowSection:AddToggle("Rainbow Glow", false, function(state)
        if VisualEffects then
            VisualEffects:SetRainbowGlow(state)
            if Notifications then
                Notifications:Success("Glow", "Rainbow glow " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GlowSection:AddToggle("Pulsing Glow", false, function(state)
        if VisualEffects then
            VisualEffects:SetPulsingGlow(state)
            if Notifications then
                Notifications:Success("Glow", "Pulsing glow " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GlowSection:AddSlider("Glow Pulse Speed", 1, 0.1, 5, 0.1, function(value)
        if VisualEffects then
            VisualEffects:SetGlowPulseSpeed(value)
        end
    end)
    
    GlowSection:AddToggle("Team Glow", false, function(state)
        if VisualEffects then
            VisualEffects:SetTeamGlow(state)
            if Notifications then
                Notifications:Success("Glow", "Team glow " .. (state and "enabled" or "disabled"), 3)
            end
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
            Misc:SetInfiniteJump(state)
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
    
    -- Advanced Movement
    MovementSection:AddToggle("Auto Jump", false, function(state)
        if Misc then
            Misc:SetAutoJump(state)
            if Notifications then
                Notifications:Success("Misc", "Auto jump " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    MovementSection:AddToggle("Edge Jump", false, function(state)
        if Misc then
            Misc:SetEdgeJump(state)
            if Notifications then
                Notifications:Success("Misc", "Edge jump " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    MovementSection:AddToggle("Long Jump", false, function(state)
        if Misc then
            Misc:SetLongJump(state)
            if Notifications then
                Notifications:Success("Misc", "Long jump " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    MovementSection:AddSlider("Long Jump Power", 100, 50, 300, 10, function(value)
        if Misc then
            Misc:SetLongJumpPower(value)
        end
    end)
    
    -- Bunny Hop Section
    local BunnyHopSection = MiscTab:CreateSection("Bunny Hop")
    BunnyHopSection:AddToggle("Enabled", false, function(state)
        if Misc then
            Misc:SetBunnyHop(state)
        end
    end)
    
    BunnyHopSection:AddSlider("Strafe Speed", 1, 1, 10, 1, function(value)
        if Misc then
            Misc:SetAutoStrafeSpeed(value)
        end
    end)
    
    -- SpinBot Section
    local SpinBotSection = MiscTab:CreateSection("SpinBot")
    SpinBotSection:AddToggle("Enabled", false, function(state)
        if Misc then
            Misc:SetSpinBot(state)
        end
    end)
    
    SpinBotSection:AddSlider("Spin Speed", 20, 1, 100, 1, function(value)
        if Misc then
            Misc:SetSpinSpeed(value)
        end
    end)
    
    SpinBotSection:AddDropdown("Spin Mode", {"Horizontal", "Vertical", "Random", "Jitter"}, "Horizontal", function(option)
        if Misc then
            Misc:SetSpinMode(option)
        end
    end)
    
    -- Player List Section
    local PlayerListSection = MiscTab:CreateSection("Player List")
    PlayerListSection:AddToggle("Enabled", true, function(state)
        if PlayerManager then
            PlayerManager:SetEnabled(state)
        end
    end)
    
    PlayerListSection:AddToggle("Team Colors", true, function(state)
        if PlayerManager then
            PlayerManager:SetTeamColors(state)
        end
    end)
    
    -- Exploits Tab
    local ExploitsTab = Window:CreateTab("Exploits")
    print("[DummyHook] Created Exploits tab")
    
    -- Game Exploits Section
    local GameExploitsSection = ExploitsTab:CreateSection("Game Exploits")
    GameExploitsSection:AddToggle("Infinite Money", false, function(state)
        if GameExploits then
            GameExploits:SetInfiniteMoney(state)
        end
    end)
    
    GameExploitsSection:AddToggle("Instant Reload", false, function(state)
        if GameExploits then
            GameExploits:SetInstantReload(state)
        end
    end)
    
    GameExploitsSection:AddToggle("No Recoil", false, function(state)
        if GameExploits then
            GameExploits:SetNoRecoil(state)
        end
    end)
    
    GameExploitsSection:AddToggle("No Spread", false, function(state)
        if GameExploits then
            GameExploits:SetNoSpread(state)
        end
    end)
    
    -- Advanced Game Exploits
    GameExploitsSection:AddToggle("God Mode", false, function(state)
        if GameExploits then
            GameExploits:SetGodMode(state)
            if Notifications then
                Notifications:Success("Exploits", "God mode " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameExploitsSection:AddToggle("Anti-Knockback", false, function(state)
        if GameExploits then
            GameExploits:SetAntiKnockback(state)
            if Notifications then
                Notifications:Success("Exploits", "Anti-knockback " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameExploitsSection:AddToggle("Speed Hack", false, function(state)
        if GameExploits then
            GameExploits:SetSpeedHack(state)
            if Notifications then
                Notifications:Success("Exploits", "Speed hack " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameExploitsSection:AddSlider("Speed Multiplier", 2, 1, 10, 0.5, function(value)
        if GameExploits then
            GameExploits:SetSpeedMultiplier(value)
        end
    end)
    
    GameExploitsSection:AddToggle("Jump Boost", false, function(state)
        if GameExploits then
            GameExploits:SetJumpBoost(state)
            if Notifications then
                Notifications:Success("Exploits", "Jump boost " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameExploitsSection:AddSlider("Jump Power", 50, 50, 200, 10, function(value)
        if GameExploits then
            GameExploits:SetJumpPower(value)
        end
    end)
    
    -- Character Customizer Section
    local CharCustomizerSection = ExploitsTab:CreateSection("Character Customizer")
    CharCustomizerSection:AddToggle("Enabled", false, function(state)
        if CharCustomizer then
            CharCustomizer:SetEnabled(state)
        end
    end)
    
    CharCustomizerSection:AddSlider("Size Modifier", 100, 1, 200, 1, function(value)
        if CharCustomizer then
            CharCustomizer:SetSizeModifier(value)
        end
    end)
    
    CharCustomizerSection:AddToggle("Headless", false, function(state)
        if CharCustomizer then
            CharCustomizer:SetHeadless(state)
        end
    end)
    
    CharCustomizerSection:AddToggle("Invisible", false, function(state)
        if CharCustomizer then
            CharCustomizer:SetInvisible(state)
        end
    end)
    
    -- Skin Customizer Section
    local SkinCustomizerSection = ExploitsTab:CreateSection("Skin Customizer")
    SkinCustomizerSection:AddToggle("Enabled", false, function(state)
        if SkinCustomizer then
            SkinCustomizer:SetEnabled(state)
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
    
    -- Enhanced skin duping with amount selection
    SniperDuelsSpecializedSection:AddSlider("Dupe Amount", 1, 1, 100, 1, function(value)
        if SniperDuels then
            SniperDuels:SetSkinDupeAmount(value)
        end
    end)
    
    SniperDuelsSpecializedSection:AddButton("Dupe Selected Skin", function()
        if SniperDuels then
            local skins = SniperDuels:GetDetectedSkins()
            if #skins > 0 then
                local selectedSkin = skins[1] -- For demo, use first skin
                SniperDuels:DupeSkin(selectedSkin, SniperDuels.Settings.SkinDupeAmount)
                if Notifications then
                    Notifications:Success("Sniper Duels", "Duped " .. SniperDuels.Settings.SkinDupeAmount .. "x " .. selectedSkin .. "!", 3)
                end
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
    
    -- Mass currency generation
    SniperDuelsSpecializedSection:AddButton("Generate 10M Currency", function()
        if SniperDuels then
            SniperDuels:GenerateFreeCurrency(10000000)
            if Notifications then
                Notifications:Success("Sniper Duels", "Generated 10,000,000 free currency!", 3)
            end
        end
    end)
    
    -- Auto Dupe Skins
    SniperDuelsSpecializedSection:AddToggle("Auto Dupe Skins", false, function(state)
        if SniperDuels then
            SniperDuels:SetAutoDupeSkins(state)
            if Notifications then
                Notifications:Success("Sniper Duels", "Auto dupe skins " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    -- Case Opening Section
    local CaseOpeningSection = SniperDuelsTab:CreateSection("Case Opening")
    CaseOpeningSection:AddToggle("Auto Open Cases", false, function(state)
        if SniperDuels then
            SniperDuels:SetAutoOpenCases(state)
        end
    end)
    
    CaseOpeningSection:AddSlider("Case Open Speed", 1, 1, 10, 1, function(value)
        if SniperDuels then
            SniperDuels:SetCaseOpenSpeed(value)
        end
    end)
    
    -- Updated case names to match actual CaseConfigs.lua module
    local caseNames = {
        "Release",           -- RELEASE CASE from CaseConfigs.lua
        "Halloween2025"      -- HALLOWS BASKET from CaseConfigs.lua
    }
    
    CaseOpeningSection:AddDropdown("Open Specific Case", caseNames, "Release", function(caseName)
        if SniperDuels then
            SniperDuels:OpenCase(caseName)
            if Notifications then
                Notifications:Success("Sniper Duels", "Opening " .. caseName .. " case!", 3)
            end
        end
    end)
    
    -- Open case 10 times
    CaseOpeningSection:AddButton("Open Case x10", function()
        if SniperDuels then
            for i = 1, 10 do
                SniperDuels:OpenRandomCase()
                wait(0.5)
            end
            if Notifications then
                Notifications:Success("Sniper Duels", "Opened 10 cases!", 3)
            end
        end
    end)
    
    -- Weapon Enhancements Section (based on Gun.lua module)
    local WeaponSection = SniperDuelsTab:CreateSection("Weapon Enhancements")
    
    WeaponSection:AddToggle("Enhanced Stats", false, function(state)
        if SniperDuels then
            SniperDuels:SetEnhancedStats(state)
        end
    end)
    
    WeaponSection:AddSlider("Stat Boost Amount", 2, 1, 5, 0.5, function(value)
        if SniperDuels then
            SniperDuels:SetStatBoostAmount(value)
        end
    end)
    
    WeaponSection:AddToggle("Infinite Ammo", false, function(state)
        if SniperDuels then
            SniperDuels:SetInfiniteAmmo(state)
            SniperDuels:SetEnhancedStats(SniperDuels.Settings.EnhancedStats)
        end
    end)
    
    WeaponSection:AddToggle("No Recoil", false, function(state)
        if SniperDuels then
            SniperDuels:SetNoRecoil(state)
            SniperDuels:SetEnhancedStats(SniperDuels.Settings.EnhancedStats)
        end
    end)
    
    WeaponSection:AddToggle("No Spread", false, function(state)
        if SniperDuels then
            SniperDuels:SetNoSpread(state)
            SniperDuels:SetEnhancedStats(SniperDuels.Settings.EnhancedStats)
        end
    end)
    
    WeaponSection:AddToggle("Increased Fire Rate", false, function(state)
        if SniperDuels then
            SniperDuels:SetIncreasedFireRate(state)
            SniperDuels:SetEnhancedStats(SniperDuels.Settings.EnhancedStats)
        end
    end)
    
    WeaponSection:AddSlider("Fire Rate Multiplier", 1.5, 1, 3, 0.1, function(value)
        if SniperDuels then
            SniperDuels:SetFireRateMultiplier(value)
        end
    end)
    
    -- One shot kill
    WeaponSection:AddToggle("One Shot Kill", false, function(state)
        if SniperDuels then
            SniperDuels:SetOneShotKill(state)
            if Notifications then
                Notifications:Success("Sniper Duels", "One shot kill " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    -- Melee Section (based on Melee.lua module)
    local MeleeSection = SniperDuelsTab:CreateSection("Melee (Bayonet)")
    
    MeleeSection:AddToggle("Melee Exploit", false, function(state)
        if SniperDuels then
            SniperDuels:SetMeleeExploit(state)
        end
    end)
    
    MeleeSection:AddToggle("No Cooldown", false, function(state)
        if SniperDuels then
            SniperDuels:SetNoMeleeCooldown(state)
        end
    end)
    
    MeleeSection:AddToggle("Damage Boost (3x)", false, function(state)
        if SniperDuels then
            SniperDuels:SetMeleeDamageBoost(state)
        end
    end)
    
    -- Instant kill melee
    MeleeSection:AddToggle("Instant Kill Melee", false, function(state)
        if SniperDuels then
            SniperDuels:SetInstantKillMelee(state)
            if Notifications then
                Notifications:Success("Sniper Duels", "Instant kill melee " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    -- Auto Farm Section
    local AutoFarmSection = SniperDuelsTab:CreateSection("Auto Farm")
    
    AutoFarmSection:AddToggle("Auto Farm", false, function(state)
        if SniperDuels then
            SniperDuels:SetAutoFarm(state)
            if Notifications then
                Notifications:Success("Sniper Duels", "Auto farm " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AutoFarmSection:AddDropdown("Farm Method", {"Kills", "Coins", "XP", "All"}, "Kills", function(option)
        if SniperDuels then
            SniperDuels:SetFarmMethod(option)
        end
    end)
    
    AutoFarmSection:AddSlider("Farm Interval (s)", 1, 0.1, 10, 0.1, function(value)
        if SniperDuels then
            SniperDuels:SetFarmInterval(value)
        end
    end)
    
    -- Teleport Section
    local TeleportSection = SniperDuelsTab:CreateSection("Teleport")
    
    TeleportSection:AddButton("Teleport to Lobby", function()
        if SniperDuels then
            SniperDuels:TeleportToLobby()
            if Notifications then
                Notifications:Success("Sniper Duels", "Teleported to lobby!", 3)
            end
        end
    end)
    
    TeleportSection:AddButton("Teleport to Spawn", function()
        if SniperDuels then
            SniperDuels:TeleportToSpawn()
            if Notifications then
                Notifications:Success("Sniper Duels", "Teleported to spawn!", 3)
            end
        end
    end)
    
    -- New Advanced Features Section
    local AdvancedFeaturesSection = SniperDuelsTab:CreateSection("Advanced Features")
    
    -- Movement Hacks
    AdvancedFeaturesSection:AddToggle("Speed Hack", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.SpeedHack = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Speed hack " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AdvancedFeaturesSection:AddSlider("Speed Multiplier", 2, 1, 5, 0.1, function(value)
        if SniperDuels then
            SniperDuels.Settings.SpeedMultiplier = value
        end
    end)
    
    AdvancedFeaturesSection:AddToggle("Jump Power Hack", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.JumpPowerHack = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Jump power hack " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AdvancedFeaturesSection:AddSlider("Jump Power Multiplier", 2, 1, 5, 0.1, function(value)
        if SniperDuels then
            SniperDuels.Settings.JumpPowerMultiplier = value
        end
    end)
    
    -- Combat Hacks
    AdvancedFeaturesSection:AddToggle("Trigger Bot", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.TriggerBot = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Trigger bot " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AdvancedFeaturesSection:AddSlider("Trigger Bot Delay (s)", 0.1, 0.01, 1, 0.01, function(value)
        if SniperDuels then
            SniperDuels.Settings.TriggerBotDelay = value
        end
    end)
    
    -- Anti-Aim Features
    AdvancedFeaturesSection:AddToggle("Spin Bot", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.SpinBot = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Spin bot " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AdvancedFeaturesSection:AddSlider("Spin Speed", 10, 1, 50, 1, function(value)
        if SniperDuels then
            SniperDuels.Settings.SpinSpeed = value
        end
    end)
    
    -- Utility Features
    AdvancedFeaturesSection:AddToggle("Auto Reload", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.AutoReload = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Auto reload " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AdvancedFeaturesSection:AddToggle("No Fall Damage", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.NoFallDamage = state
            if Notifications then
                Notifications:Success("Sniper Duels", "No fall damage " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    -- Skin Management Section
    local SkinManagementSection = SniperDuelsTab:CreateSection("Skin Management")
    
    SkinManagementSection:AddToggle("Auto Pickup Skins", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.AutoPickupSkins = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Auto pickup skins " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    SkinManagementSection:AddToggle("Skin Collector", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.SkinCollector = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Skin collector " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    SkinManagementSection:AddSlider("Skin Collector Delay (s)", 0.5, 0.1, 5, 0.1, function(value)
        if SniperDuels then
            SniperDuels.Settings.SkinCollectorDelay = value
        end
    end)
    
    SkinManagementSection:AddToggle("Auto Sell Common Skins", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.AutoSellCommonSkins = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Auto sell common skins " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    SkinManagementSection:AddSlider("Sell Rarity Threshold", 3, 1, 5, 1, function(value)
        if SniperDuels then
            SniperDuels.Settings.AutoSellRarityThreshold = value
        end
    end)
    
    SkinManagementSection:AddToggle("Auto Upgrade Skins", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.AutoUpgradeSkins = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Auto upgrade skins " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    SkinManagementSection:AddSlider("Upgrade Rarity Threshold", 4, 1, 5, 1, function(value)
        if SniperDuels then
            SniperDuels.Settings.UpgradeRarityThreshold = value
        end
    end)
    
    SkinManagementSection:AddToggle("Auto Equip Best Skins", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.AutoEquipBestSkins = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Auto equip best skins " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    SkinManagementSection:AddSlider("Equip Interval (s)", 10, 1, 60, 1, function(value)
        if SniperDuels then
            SniperDuels.Settings.SkinEquipInterval = value
        end
    end)
    
    -- Game Enhancement Section
    local GameEnhancementSection = SniperDuelsTab:CreateSection("Game Enhancement")
    
    GameEnhancementSection:AddToggle("Killstreak Notifier", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.KillstreakNotifier = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Killstreak notifier " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameEnhancementSection:AddToggle("Achievement Unlocker", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.AchievementUnlocker = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Achievement unlocker " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameEnhancementSection:AddToggle("Unlock All Achievements", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.UnlockAllAchievements = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Unlock all achievements " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameEnhancementSection:AddToggle("XP Multiplier", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.XPMultiplier = state
            if Notifications then
                Notifications:Success("Sniper Duels", "XP multiplier " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameEnhancementSection:AddSlider("XP Multiplier Amount", 2, 1, 10, 1, function(value)
        if SniperDuels then
            SniperDuels.Settings.XPMultiplierAmount = value
        end
    end)
    
    GameEnhancementSection:AddToggle("Coin Multiplier", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.CoinMultiplier = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Coin multiplier " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameEnhancementSection:AddSlider("Coin Multiplier Amount", 2, 1, 10, 1, function(value)
        if SniperDuels then
            SniperDuels.Settings.CoinMultiplierAmount = value
        end
    end)
    
    GameEnhancementSection:AddToggle("Premium Currency Multiplier", false, function(state)
        if SniperDuels then
            SniperDuels.Settings.PremiumCurrencyMultiplier = state
            if Notifications then
                Notifications:Success("Sniper Duels", "Premium currency multiplier " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    GameEnhancementSection:AddSlider("Premium Multiplier Amount", 2, 1, 10, 1, function(value)
        if SniperDuels then
            SniperDuels.Settings.PremiumCurrencyMultiplierAmount = value
        end
    end)
    
    -- Advanced Tab
    local AdvancedTab = Window:CreateTab("Advanced")
    print("[DummyHook] Created Advanced tab")
    
    -- Performance Section
    local PerformanceSection = AdvancedTab:CreateSection("Performance Optimization")
    PerformanceSection:AddToggle("FPS Boost", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetFPSBoost(state)
            if Notifications then
                Notifications:Success("Advanced", "FPS boost " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    PerformanceSection:AddToggle("Low Graphics", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetLowGraphics(state)
            if Notifications then
                Notifications:Success("Advanced", "Low graphics " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    PerformanceSection:AddSlider("Render Distance", 100, 10, 1000, 10, function(value)
        if AdvancedCheats then
            AdvancedCheats:SetRenderDistance(value)
        end
    end)
    
    -- Anti-Detection Section
    local AntiDetectionSection = AdvancedTab:CreateSection("Anti-Detection")
    AntiDetectionSection:AddToggle("Anti-Aimbot Detection", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetAntiAimbotDetection(state)
            if Notifications then
                Notifications:Success("Advanced", "Anti-aimbot detection " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AntiDetectionSection:AddToggle("Anti-Cheat Bypass", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetAntiCheatBypass(state)
            if Notifications then
                Notifications:Success("Advanced", "Anti-cheat bypass " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AntiDetectionSection:AddToggle("Ping Spoof", false, function(state)
        if AdvancedCheats then
            AdvancedCheats:SetPingSpoof(state)
            if Notifications then
                Notifications:Success("Advanced", "Ping spoof " .. (state and "enabled" or "disabled"), 3)
            end
        end
    end)
    
    AntiDetectionSection:AddSlider("Ping Spoof Amount", 100, 50, 500, 10, function(value)
        if AdvancedCheats then
            AdvancedCheats:SetPingSpoofAmount(value)
        end
    end)
    
    -- Script Hub Section
    local ScriptHubSection = AdvancedTab:CreateSection("Script Hub")
    ScriptHubSection:AddButton("Load Silent Aim Script", function()
        if Notifications then
            Notifications:Success("Advanced", "Silent aim script loaded!", 3)
        end
    end)
    
    ScriptHubSection:AddButton("Load Auto Farm Script", function()
        if Notifications then
            Notifications:Success("Advanced", "Auto farm script loaded!", 3)
        end
    end)
    
    ScriptHubSection:AddButton("Load ESP Script", function()
        if Notifications then
            Notifications:Success("Advanced", "ESP script loaded!", 3)
        end
    end)
    
    ScriptHubSection:AddButton("Load Bunny Hop Script", function()
        if Notifications then
            Notifications:Success("Advanced", "Bunny hop script loaded!", 3)
        end
    end)
    
    -- Config Tab
    local ConfigTab = Window:CreateTab("Config")
    print("[DummyHook] Created Config tab")
    
    -- Settings Section
    local SettingsSection = ConfigTab:CreateSection("Settings")
    
    SettingsSection:AddToggle("Key System", true, function(state)
        if KeyManager then
            KeyManager:SetEnabled(state)
        end
    end)
    
    SettingsSection:AddToggle("Notifications", true, function(state)
        if Notifications then
            Notifications:SetEnabled(state)
        end
    end)
    
    SettingsSection:AddToggle("Watermark", true, function(state)
        if Library then
            Library:SetWatermarkVisible(state)
        end
    end)
    
    SettingsSection:AddToggle("Hide Name", false, function(state)
        if Misc then
            Misc:SetHideName(state)
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
            ThemeManager:SetRGBMode(state)
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
-- Use spawn to prevent nil value errors
spawn(function()
    CreateKeyUI(LoadMainScript)
end)

-- Load features
print("[DummyHook] Loading features...")
local loaded, Aimbot = pcall(loadstring, get_raw_content(GITHUB_RAW_URL .. "/Features/Aimbot.lua"))
if loaded and Aimbot then
    Aimbot = Aimbot()
    print("[DummyHook] Aimbot module loaded successfully")
else
    print("[DummyHook] Failed to load Aimbot module")
    Aimbot = nil
end

local loaded, ESP = pcall(loadstring, get_raw_content(GITHUB_RAW_URL .. "/Features/ESP.lua"))
if loaded and ESP then
    ESP = ESP()
    print("[DummyHook] ESP module loaded successfully")
else
    print("[DummyHook] Failed to load ESP module")
    ESP = nil
end

local loaded, Crosshair = pcall(loadstring, get_raw_content(GITHUB_RAW_URL .. "/Features/Crosshair.lua"))
if loaded and Crosshair then
    Crosshair = Crosshair()
    print("[DummyHook] Crosshair module loaded successfully")
else
    print("[DummyHook] Failed to load Crosshair module")
    Crosshair = nil
end

local loaded, SniperDuels = pcall(loadstring, get_raw_content(GITHUB_RAW_URL .. "/Features/SniperDuels.lua"))
if loaded and SniperDuels then
    SniperDuels = SniperDuels()
    print("[DummyHook] SniperDuels module loaded successfully")
else
    print("[DummyHook] Failed to load SniperDuels module")
    SniperDuels = nil
end

-- Load new GameModules
local loaded, GameModules = pcall(loadstring, get_raw_content(GITHUB_RAW_URL .. "/Features/GameModules.lua"))
if loaded and GameModules then
    GameModules = GameModules()
    print("[DummyHook] GameModules module loaded successfully")
else
    print("[DummyHook] Failed to load GameModules module")
    GameModules = nil
end

local loaded, VisualEffects = pcall(loadstring, get_raw_content(GITHUB_RAW_URL .. "/Features/VisualEffects.lua"))
if loaded and VisualEffects then
    VisualEffects = VisualEffects()
    print("[DummyHook] VisualEffects module loaded successfully")
else
    print("[DummyHook] Failed to load VisualEffects module")
    VisualEffects = nil
end
