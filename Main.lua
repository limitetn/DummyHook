-- GitHub Configuration (Update these before pushing to your repo)
local GITHUB_USER = "limitetn"  -- Change to your GitHub username
local GITHUB_REPO = "DummyHook" -- Change to your repository name
local GITHUB_BRANCH = "main"    -- Change if using a different branch

-- Construct base URL
local BASE_URL = ("https://raw.githubusercontent.com/%s/%s/%s/"):format(GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH)

-- Load UI Library
local Library = loadstring(game:HttpGet(BASE_URL .. "UI/Library.lua"))()

-- Create Window
local Window = Library:CreateWindow({
    Title = "DummyHook - Sniper Duels Edition",
    Theme = "Skeet",
    Size = UDim2.new(0, 580, 0, 460),
    KeyBind = Enum.KeyCode.RightShift
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

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

-- Create Sniper Duels Tab
local SniperDuelsTab = Window:CreateTab("Sniper Duels")

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
        Notifications:Success("Sniper Duels", "Duped all skins!", 3)
    end
end)

-- Free Currency Generation
SniperDuelsSpecializedSection:AddButton("Generate Free Currency", function()
    if SniperDuels then
        SniperDuels:GenerateFreeCurrency(1000000)
        Notifications:Success("Sniper Duels", "Generated 1,000,000 free currency!", 3)
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

CaseOpeningSection:AddDropdown("Open Specific Case", caseNames, function(caseName)
    if SniperDuels then
        SniperDuels:OpenCase(caseName)
        Notifications:Success("Sniper Duels", "Opening " .. caseName .. " case!", 3)
    end
end)

-- Config Tab
local ConfigTab = Window:CreateTab("Config")

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

ThemeSection:AddDropdown("Theme Preset", {"Skeet", "Aimware", "Custom"}, function(theme)
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
        Notifications:Success("Config", "Configuration saved!", 3)
    end
end)

ConfigSection:AddButton("Load Config", function()
    if ConfigManager then
        ConfigManager:LoadConfig("default")
        Notifications:Success("Config", "Configuration loaded!", 3)
    end
end)

ConfigSection:AddButton("Reset Config", function()
    if ConfigManager then
        ConfigManager:ResetConfig()
        Notifications:Success("Config", "Configuration reset!", 3)
    end
end)

-- Info Section
local InfoSection = ConfigTab:CreateSection("Information")

InfoSection:AddLabel("Version: v1.0.0")
InfoSection:AddLabel("Status: Loaded")
InfoSection:AddLabel("Modules: " .. (modulesLoaded and "All Loaded" or "Some Missing"))

-- Final initialization
print("[DummyHook] Main script loaded successfully!")
print("[DummyHook] Press RightShift to open the menu.")

if Notifications then
    Notifications:Success("DummyHook", "Loaded successfully! Press RightShift to open.", 5)
end