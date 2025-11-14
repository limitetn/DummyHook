--[[
    DummyHook Key Management System
    Advanced key validation with pastebin integration and encryption
]]

local KeyManager = {
    Keys = {},
    PastebinURL = "https://pastebin.com/raw/YOUR_PASTEBIN_KEY_HERE", -- Replace with actual pastebin URL
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
    spawn(function()
        self:UpdateKeysFromPastebin()
    end)
end

-- Fetch and update keys from pastebin
function KeyManager:UpdateKeysFromPastebin()
    local success, result = pcall(function()
        return game:HttpGet(self.PastebinURL, true)
    end)
    
    if success and result then
        -- Decrypt the data
        local decryptedData = XOREncryptDecrypt(result, self.EncryptionKey)
        
        -- Parse JSON
        local success, keys = pcall(function()
            return HttpService:JSONDecode(decryptedData)
        end)
        
        if success and type(keys) == "table" then
            self.Keys = keys
            self.LastUpdate = os.time()
            return true
        end
    end
    
    return false
end

-- Validate a key
function KeyManager:ValidateKey(key, hwid)
    -- Check if we need to update keys
    if os.time() - self.LastUpdate > self.UpdateInterval then
        self:UpdateKeysFromPastebin()
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
    local key = "DUMMYHOOK-" .. string.upper(HttpService:GenerateGUID(false):sub(1, 16))
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
    local jsonData = HttpService:JSONEncode(self.Keys)
    return XOREncryptDecrypt(jsonData, self.EncryptionKey)
end

return KeyManager