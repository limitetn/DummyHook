-- Script to generate encrypted key list for pastebin

local HttpService = game:GetService("HttpService")

-- Simple XOR encryption key
local ENCRYPTION_KEY = "DUMMYHOOK_ENCRYPTION_KEY_2025"

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

-- Key list
local keyList = {
    ["DUMMYHOOK-PREMIUM-2025"] = {
        Level = "Premium",
        Expiry = 1999999999,
        HWID = "STANDALONE"
    },
    ["DUMMYHOOK-ELITE-2025"] = {
        Level = "Elite",
        Expiry = 1999999999,
        HWID = "ANY"
    },
    ["DUMMYHOOK-BASIC-2025"] = {
        Level = "Basic",
        Expiry = 1999999999,
        HWID = "ANY"
    }
}

-- Convert to JSON
local jsonData = HttpService:JSONEncode(keyList)
print("JSON Data:")
print(jsonData)

-- Encrypt
local encryptedData = XOREncryptDecrypt(jsonData, ENCRYPTION_KEY)
print("\nEncrypted Data:")
print(encryptedData)

-- Base64 encode for pastebin
local encodedData = Base64Encode(encryptedData)
print("\nBase64 Encoded Data (for pastebin):")
print(encodedData)

print("\nDecryption test:")
local decoded = HttpService:UrlDecode(encodedData)
local decrypted = XOREncryptDecrypt(decoded, ENCRYPTION_KEY)
print(decrypted)