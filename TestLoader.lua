--[[
    DummyHook Test Loader
    For testing the updated GitHub URLs
]]

-- Test loading the main script with the new URL
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/Main.lua"))()
end)

if not success then
    warn("[DummyHook Test] Loader Error: " .. tostring(err))
else
    print("[DummyHook Test] Script loaded successfully!")
end