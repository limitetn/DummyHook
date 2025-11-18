-- DummyHook Loader
-- This loads the main script properly

local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/Main.lua"))()
end)

if not success then
    warn("[DummyHook] Failed to load: " .. tostring(err))
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DummyHook_Error"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = game:GetService("CoreGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 150)
    frame.Position = UDim2.new(0.5, -200, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "DummyHook - Load Error"
    title.TextColor3 = Color3.fromRGB(255, 100, 100)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.Parent = frame
    
    local message = Instance.new("TextLabel")
    message.Size = UDim2.new(1, -20, 0, 80)
    message.Position = UDim2.new(0, 10, 0, 50)
    message.BackgroundTransparency = 1
    message.Text = "Failed to load DummyHook.\nCheck your internet connection\nand try again."
    message.TextColor3 = Color3.fromRGB(200, 200, 200)
    message.TextSize = 14
    message.Font = Enum.Font.Gotham
    message.TextWrapped = true
    message.TextYAlignment = Enum.TextYAlignment.Top
    message.Parent = frame
end