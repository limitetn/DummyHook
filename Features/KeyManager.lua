local KeyManager = {}
KeyManager.__index = KeyManager

-- Fix for static analysis tools
local game = game
local HttpService = game:GetService("HttpService")

-- Key validation settings
KeyManager.Keys = {}
KeyManager.KeyURL = "https://dummyhook.io/getkey"
KeyManager.Discord = "discord.gg/dummyhook"

-- Load keys from the keylist file
function KeyManager:LoadKeys()
    local success, result = pcall(function()
        local keysJSON = HttpService:GetAsync("https://raw.githubusercontent.com/etnson9/DummyHook/main/Keys/keylist.json")
        local keysTable = HttpService:JSONDecode(keysJSON)
        if type(keysTable) == "table" then
            self.Keys = keysTable
        end
    end)
    
    if not success then
        warn("[KeyManager] Failed to load keys: " .. tostring(result))
        -- Load local backup keys
        self.Keys = {
            ["DUMMYHOOK-PREMIUM-2025"] = {Level = "Premium", Expiry = 1999999999, HWID = "STANDALONE"},
            ["DUMMYHOOK-ELITE-2025"] = {Level = "Elite", Expiry = 1999999999, HWID = "ANY"},
            ["DUMMYHOOK-BASIC-2025"] = {Level = "Basic", Expiry = 1999999999, HWID = "ANY"}
        }
    end
end

-- Validate a key
function KeyManager:ValidateKey(key)
    -- First check if key is in our local list
    if self.Keys[key] then
        return true
    end
    
    -- If not found locally, try to validate with remote server
    local success, result = pcall(function()
        local validationURL = self.KeyURL .. "?key=" .. key
        local response = HttpService:GetAsync(validationURL)
        return response == "VALID"
    end)
    
    return success and result
end

-- Get key information
function KeyManager:GetKeyInfo(key)
    return self.Keys[key] or nil
end

-- Initialize the KeyManager
function KeyManager:Initialize()
    self:LoadKeys()
end

-- Return the KeyManager instance
return KeyManager