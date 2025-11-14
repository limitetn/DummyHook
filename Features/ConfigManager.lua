--[[
    DummyHook Config Manager
    Save/Load configurations, profiles, and settings
]]

local ConfigManager = {
    CurrentProfile = "Default",
    Profiles = {},
    AutoSave = false
}

local HttpService = game:GetService("HttpService")

-- Initialize default profile
function ConfigManager:Initialize()
    self.Profiles["Default"] = {
        Aimbot = {},
        ESP = {},
        Misc = {},
        Exploits = {},
        Theme = "Skeet",
        Customization = {}
    }
end

-- Save current settings to profile
function ConfigManager:SaveProfile(profileName, settings)
    profileName = profileName or self.CurrentProfile
    
    self.Profiles[profileName] = {
        Aimbot = settings.Aimbot or {},
        ESP = settings.ESP or {},
        Misc = settings.Misc or {},
        Exploits = settings.Exploits or {},
        Theme = settings.Theme or "Skeet",
        Customization = settings.Customization or {},
        SavedAt = os.time()
    }
    
    -- Try to save to file (if writefile is available)
    local success = pcall(function()
        if writefile then
            local json = HttpService:JSONEncode(self.Profiles[profileName])
            writefile("DummyHook_" .. profileName .. ".json", json)
        end
    end)
    
    return success
end

-- Load profile
function ConfigManager:LoadProfile(profileName)
    profileName = profileName or self.CurrentProfile
    
    -- Try to load from file first
    local success = pcall(function()
        if readfile and isfile and isfile("DummyHook_" .. profileName .. ".json") then
            local json = readfile("DummyHook_" .. profileName .. ".json")
            self.Profiles[profileName] = HttpService:JSONDecode(json)
            return true
        end
    end)
    
    if self.Profiles[profileName] then
        self.CurrentProfile = profileName
        return self.Profiles[profileName]
    end
    
    return nil
end

-- Delete profile
function ConfigManager:DeleteProfile(profileName)
    if profileName == "Default" then
        return false -- Can't delete default
    end
    
    self.Profiles[profileName] = nil
    
    -- Delete file if exists
    pcall(function()
        if delfile and isfile and isfile("DummyHook_" .. profileName .. ".json") then
            delfile("DummyHook_" .. profileName .. ".json")
        end
    end)
    
    return true
end

-- Get all profile names
function ConfigManager:GetProfileNames()
    local names = {}
    for name, _ in pairs(self.Profiles) do
        table.insert(names, name)
    end
    
    -- Check for file-saved profiles
    pcall(function()
        if listfiles then
            local files = listfiles("DummyHook")
            for _, file in pairs(files) do
                local profileName = file:match("DummyHook_(.+)%.json")
                if profileName and not self.Profiles[profileName] then
                    table.insert(names, profileName)
                end
            end
        end
    end)
    
    return names
end

-- Export config to clipboard
function ConfigManager:ExportConfig(profileName)
    profileName = profileName or self.CurrentProfile
    local profile = self.Profiles[profileName]
    
    if not profile then return nil end
    
    local json = HttpService:JSONEncode(profile)
    
    -- Try to copy to clipboard
    pcall(function()
        if setclipboard then
            setclipboard(json)
        end
    end)
    
    return json
end

-- Import config from string
function ConfigManager:ImportConfig(configString, profileName)
    profileName = profileName or "Imported_" .. os.time()
    
    local success, config = pcall(function()
        return HttpService:JSONDecode(configString)
    end)
    
    if success and config then
        self.Profiles[profileName] = config
        return true, profileName
    end
    
    return false, nil
end

-- Quick save current settings
function ConfigManager:QuickSave(settings)
    return self:SaveProfile("QuickSave", settings)
end

-- Quick load
function ConfigManager:QuickLoad()
    return self:LoadProfile("QuickSave")
end

-- Auto-save functionality
function ConfigManager:EnableAutoSave(interval, settings)
    self.AutoSave = true
    
    spawn(function()
        while self.AutoSave do
            task.wait(interval or 60) -- Default 60 seconds
            self:QuickSave(settings)
        end
    end)
end

function ConfigManager:DisableAutoSave()
    self.AutoSave = false
end

-- Reset to defaults
function ConfigManager:ResetToDefaults()
    self:Initialize()
    return self.Profiles["Default"]
end

return ConfigManager
