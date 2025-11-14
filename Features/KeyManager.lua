--[[
    DummyHook Key Management System
    Advanced key validation with pastebin integration and encryption
]]

local KeyManager = {
    Keys = {},
    PastebinURL = "https://pastebin.com/raw/pzf7297f", -- Replace with actual pastebin URL
    EncryptionKey = "DUMMYHOOK_ENCRYPTION_KEY_2025", -- Simple XOR encryption key
    LastUpdate = 0,
    UpdateInterval = 300, -- 5 minutes
    Cache = {}
}

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- Simple XOR encryption/decryption
local function XOREncryptDecrypt(data, key)
    local result = {}
    for i = 1, #data do
        local dataByte = string.byte(data, i)
        local keyByte = string.byte(key, ((i - 1) % #key) + 1)
        result[i] = string.char(dataByte ~ keyByte)
    end
    return table.concat(result)
end

-- Base64 encoding (for safe transmission)
local function Base64Encode(data)
    return HttpService:UrlEncode(data)
end

local function Base64Decode(data)
    return HttpService:UrlDecode(data)
end

-- Initialize the key manager
function KeyManager:Initialize()
    -- Load default key for standalone version
    self.Keys["DUMMYHOOK-PREMIUM-2025"] = {
        Level = "Premium",
        Expiry = os.time() + (365 * 24 * 60 * 60), -- 1 year from now
        HWID = "STANDALONE"
    }
    
    -- Try to fetch keys from pastebin
    pcall(function()
        spawn(function()
            self:UpdateKeysFromPastebin()
        end)
    end)
end

-- Fetch and update keys from pastebin
function KeyManager:UpdateKeysFromPastebin()
    local success, result = pcall(function()
        return game:HttpGet(self.PastebinURL, true)
    end)
    
    if success and result then
        -- Decrypt the data
        local decryptSuccess, decryptedData = pcall(function()
            return XOREncryptDecrypt(result, self.EncryptionKey)
        end)
        
        if not decryptSuccess then
            warn("[KeyManager] Failed to decrypt data: " .. tostring(decryptedData))
            return false
        end
        
        -- Parse JSON
        local jsonSuccess, keys = pcall(function()
            return HttpService:JSONDecode(decryptedData)
        end)
        
        if jsonSuccess and type(keys) == "table" then
            self.Keys = keys
            self.LastUpdate = os.time()
            return true
        else
            warn("[KeyManager] Failed to parse JSON: " .. tostring(keys))
        end
    else
        warn("[KeyManager] Failed to fetch data from Pastebin: " .. tostring(result))
    end
    
    return false
end

-- Validate a key
function KeyManager:ValidateKey(key, hwid)
    -- Check if we need to update keys
    if os.time() - self.LastUpdate > self.UpdateInterval then
        pcall(function()
            self:UpdateKeysFromPastebin()
        end)
    end
    
    -- Check if key exists
    if not self.Keys[key] then
        return false, "Invalid key"
    end
    
    local keyData = self.Keys[key]
    
    -- Check expiry
    if keyData.Expiry and os.time() > keyData.Expiry then
        return false, "Key expired"
    end
    
    -- Check HWID if required
    if keyData.HWID and keyData.HWID ~= "ANY" and keyData.HWID ~= hwid then
        return false, "HWID mismatch"
    end
    
    return true, "Valid key", keyData.Level
end

-- Generate a new key (for admin use)
function KeyManager:GenerateKey(level, days, hwid)
    local success, key = pcall(function()
        return "DUMMYHOOK-" .. string.upper(HttpService:GenerateGUID(false):sub(1, 16))
    end)
    
    if not success then
        warn("[KeyManager] Failed to generate key: " .. tostring(key))
        return nil
    end
    
    local expiry = os.time() + (days * 24 * 60 * 60)
    
    self.Keys[key] = {
        Level = level or "Premium",
        Expiry = expiry,
        HWID = hwid or "ANY"
    }
    
    return key
end

-- Get key information
function KeyManager:GetKeyInfo(key)
    return self.Keys[key]
end

-- Encrypt keys for pastebin storage
function KeyManager:ExportEncryptedKeys()
    local success, jsonData = pcall(function()
        return HttpService:JSONEncode(self.Keys)
    end)
    
    if not success then
        warn("[KeyManager] Failed to encode JSON: " .. tostring(jsonData))
        return nil
    end
    
    local encryptSuccess, encryptedData = pcall(function()
        return XOREncryptDecrypt(jsonData, self.EncryptionKey)
    end)
    
    if not encryptSuccess then
        warn("[KeyManager] Failed to encrypt data: " .. tostring(encryptedData))
        return nil
    end
    
    return encryptedData
end

return KeyManager