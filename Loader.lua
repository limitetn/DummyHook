--[[
    DummyHook Local Loader
    For local testing without GitHub hosting
]]

-- Fix for static analysis tools
local readfile = readfile
local game = game

-- This loader is for local testing purposes
-- Replace file paths with your actual GitHub raw URLs when hosting

local function loadScript(path)
    local content = readfile(path)
    -- Use load instead of loadstring for Lua 5.4 compatibility
    return load(content)()
end

-- Try to load from GitHub first, fallback to local files
local function smartLoad(githubUrl, localPath)
    local success, result = pcall(function()
        -- Use load instead of loadstring for Lua 5.4 compatibility
        return load(game:HttpGet(githubUrl))()
    end)
    
    if success then
        return result
    else
        -- Fallback to local file if available
        warn("[DummyHook] Failed to load from GitHub, trying local files...")
        if readfile then
            return loadScript(localPath)
        else
            error("[DummyHook] Cannot load script: No file access!")
        end
    end
end

print("[DummyHook] Starting loader...")
print("[DummyHook] For best experience, host files on GitHub and use the main loader")

-- Load main script
local mainUrl = "https://raw.githubusercontent.com/limitetn/DummyHook/main/Main.lua"
local mainPath = "Main.lua"

local success, err = pcall(function()
    smartLoad(mainUrl, mainPath)
end)

if not success then
    warn("[DummyHook] Loader Error: " .. tostring(err))
    warn("[DummyHook] Please host the script on GitHub for proper functionality")
end
