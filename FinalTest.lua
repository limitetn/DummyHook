--[[
    DummyHook Final Test
    Tests that all components are working with the new GitHub account
]]

print("[DummyHook Test] Starting test...")

-- Test 1: Main script
local function testMainScript()
    print("[DummyHook Test] Testing main script loading...")
    local success, err = pcall(function()
        local content = game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/Main.lua")
        if content and #content > 0 then
            print("[DummyHook Test] ✓ Main script loaded successfully")
            return true
        else
            print("[DummyHook Test] ✗ Main script is empty")
            return false
        end
    end)
    
    if not success then
        print("[DummyHook Test] ✗ Failed to load main script: " .. tostring(err))
        return false
    end
    
    return true
end

-- Test 2: UI Library
local function testUILibrary()
    print("[DummyHook Test] Testing UI library loading...")
    local success, err = pcall(function()
        local content = game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/UI/Library.lua")
        if content and #content > 0 then
            print("[DummyHook Test] ✓ UI library loaded successfully")
            return true
        else
            print("[DummyHook Test] ✗ UI library is empty")
            return false
        end
    end)
    
    if not success then
        print("[DummyHook Test] ✗ Failed to load UI library: " .. tostring(err))
        return false
    end
    
    return true
end

-- Test 3: Features
local function testFeatures()
    print("[DummyHook Test] Testing feature modules...")
    local features = {
        "Features/Aimbot.lua",
        "Features/ESP.lua",
        "Features/Crosshair.lua",
        "Features/Misc.lua",
        "Features/GameExploits.lua"
    }
    
    local successCount = 0
    for _, feature in ipairs(features) do
        local success, err = pcall(function()
            local content = game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/" .. feature)
            if content and #content > 0 then
                print("[DummyHook Test] ✓ " .. feature .. " loaded successfully")
                successCount = successCount + 1
            else
                print("[DummyHook Test] ✗ " .. feature .. " is empty")
            end
        end)
        
        if not success then
            print("[DummyHook Test] ✗ Failed to load " .. feature .. ": " .. tostring(err))
        end
    end
    
    if successCount == #features then
        print("[DummyHook Test] ✓ All feature modules loaded successfully")
        return true
    else
        print("[DummyHook Test] ✗ Only " .. successCount .. "/" .. #features .. " feature modules loaded")
        return false
    end
end

-- Run all tests
local mainSuccess = testMainScript()
local uiSuccess = testUILibrary()
local featureSuccess = testFeatures()

print("[DummyHook Test] === Test Results ===")
if mainSuccess and uiSuccess and featureSuccess then
    print("[DummyHook Test] ✓ All tests passed! The script is ready to use.")
    print("[DummyHook Test] You can now use this loadstring:")
    print("loadstring(game:HttpGet('https://raw.githubusercontent.com/limitetn/DummyHook/main/Main.lua'))()")
else
    print("[DummyHook Test] ✗ Some tests failed. Please check the errors above.")
end