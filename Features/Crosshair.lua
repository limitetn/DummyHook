--[[
    DummyHook Crosshair Module
    Customizable Crosshair
]]

local Crosshair = {
    Enabled = false,
    Settings = {
        Size = 15,
        Thickness = 2,
        Gap = 5,
        Color = Color3.fromRGB(0, 255, 0),
        Outline = true,
        OutlineColor = Color3.fromRGB(0, 0, 0),
        Dot = false,
        DynamicColor = false,
        RainbowMode = false,
    },
    Drawings = {},
    Connections = {}
}

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- Create Crosshair Elements
local function CreateCrosshair()
    -- Clear existing
    for _, drawing in pairs(Crosshair.Drawings) do
        drawing:Remove()
    end
    Crosshair.Drawings = {}
    
    local screenSize = Camera.ViewportSize
    local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    
    -- Top Line
    local topLine = Drawing.new("Line")
    topLine.Thickness = Crosshair.Settings.Thickness
    topLine.Color = Crosshair.Settings.Color
    topLine.Transparency = 1
    topLine.Visible = true
    Crosshair.Drawings.TopLine = topLine
    
    -- Bottom Line
    local bottomLine = Drawing.new("Line")
    bottomLine.Thickness = Crosshair.Settings.Thickness
    bottomLine.Color = Crosshair.Settings.Color
    bottomLine.Transparency = 1
    bottomLine.Visible = true
    Crosshair.Drawings.BottomLine = bottomLine
    
    -- Left Line
    local leftLine = Drawing.new("Line")
    leftLine.Thickness = Crosshair.Settings.Thickness
    leftLine.Color = Crosshair.Settings.Color
    leftLine.Transparency = 1
    leftLine.Visible = true
    Crosshair.Drawings.LeftLine = leftLine
    
    -- Right Line
    local rightLine = Drawing.new("Line")
    rightLine.Thickness = Crosshair.Settings.Thickness
    rightLine.Color = Crosshair.Settings.Color
    rightLine.Transparency = 1
    rightLine.Visible = true
    Crosshair.Drawings.RightLine = rightLine
    
    -- Outlines
    if Crosshair.Settings.Outline then
        local topOutline = Drawing.new("Line")
        topOutline.Thickness = Crosshair.Settings.Thickness + 2
        topOutline.Color = Crosshair.Settings.OutlineColor
        topOutline.Transparency = 1
        topOutline.Visible = true
        topOutline.ZIndex = 0
        Crosshair.Drawings.TopOutline = topOutline
        
        local bottomOutline = Drawing.new("Line")
        bottomOutline.Thickness = Crosshair.Settings.Thickness + 2
        bottomOutline.Color = Crosshair.Settings.OutlineColor
        bottomOutline.Transparency = 1
        bottomOutline.Visible = true
        bottomOutline.ZIndex = 0
        Crosshair.Drawings.BottomOutline = bottomOutline
        
        local leftOutline = Drawing.new("Line")
        leftOutline.Thickness = Crosshair.Settings.Thickness + 2
        leftOutline.Color = Crosshair.Settings.OutlineColor
        leftOutline.Transparency = 1
        leftOutline.Visible = true
        leftOutline.ZIndex = 0
        Crosshair.Drawings.LeftOutline = leftOutline
        
        local rightOutline = Drawing.new("Line")
        rightOutline.Thickness = Crosshair.Settings.Thickness + 2
        rightOutline.Color = Crosshair.Settings.OutlineColor
        rightOutline.Transparency = 1
        rightOutline.Visible = true
        rightOutline.ZIndex = 0
        Crosshair.Drawings.RightOutline = rightOutline
    end
    
    -- Center Dot
    if Crosshair.Settings.Dot then
        local dot = Drawing.new("Circle")
        dot.Radius = 2
        dot.Thickness = 1
        dot.Color = Crosshair.Settings.Color
        dot.Transparency = 1
        dot.Filled = true
        dot.Visible = true
        Crosshair.Drawings.Dot = dot
    end
end

-- Update Crosshair Position
local function UpdateCrosshair()
    if not Crosshair.Enabled then return end
    
    local screenSize = Camera.ViewportSize
    local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    
    local size = Crosshair.Settings.Size
    local gap = Crosshair.Settings.Gap
    
    -- Rainbow mode
    if Crosshair.Settings.RainbowMode then
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 1, 1)
        Crosshair.Settings.Color = color
    end
    
    local color = Crosshair.Settings.Color
    
    -- Update Lines
    if Crosshair.Drawings.TopLine then
        Crosshair.Drawings.TopLine.From = Vector2.new(center.X, center.Y - gap)
        Crosshair.Drawings.TopLine.To = Vector2.new(center.X, center.Y - gap - size)
        Crosshair.Drawings.TopLine.Color = color
        Crosshair.Drawings.TopLine.Visible = Crosshair.Enabled
    end
    
    if Crosshair.Drawings.BottomLine then
        Crosshair.Drawings.BottomLine.From = Vector2.new(center.X, center.Y + gap)
        Crosshair.Drawings.BottomLine.To = Vector2.new(center.X, center.Y + gap + size)
        Crosshair.Drawings.BottomLine.Color = color
        Crosshair.Drawings.BottomLine.Visible = Crosshair.Enabled
    end
    
    if Crosshair.Drawings.LeftLine then
        Crosshair.Drawings.LeftLine.From = Vector2.new(center.X - gap, center.Y)
        Crosshair.Drawings.LeftLine.To = Vector2.new(center.X - gap - size, center.Y)
        Crosshair.Drawings.LeftLine.Color = color
        Crosshair.Drawings.LeftLine.Visible = Crosshair.Enabled
    end
    
    if Crosshair.Drawings.RightLine then
        Crosshair.Drawings.RightLine.From = Vector2.new(center.X + gap, center.Y)
        Crosshair.Drawings.RightLine.To = Vector2.new(center.X + gap + size, center.Y)
        Crosshair.Drawings.RightLine.Color = color
        Crosshair.Drawings.RightLine.Visible = Crosshair.Enabled
    end
    
    -- Update Outlines
    if Crosshair.Settings.Outline then
        if Crosshair.Drawings.TopOutline then
            Crosshair.Drawings.TopOutline.From = Crosshair.Drawings.TopLine.From
            Crosshair.Drawings.TopOutline.To = Crosshair.Drawings.TopLine.To
            Crosshair.Drawings.TopOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.BottomOutline then
            Crosshair.Drawings.BottomOutline.From = Crosshair.Drawings.BottomLine.From
            Crosshair.Drawings.BottomOutline.To = Crosshair.Drawings.BottomLine.To
            Crosshair.Drawings.BottomOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.LeftOutline then
            Crosshair.Drawings.LeftOutline.From = Crosshair.Drawings.LeftLine.From
            Crosshair.Drawings.LeftOutline.To = Crosshair.Drawings.LeftLine.To
            Crosshair.Drawings.LeftOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.RightOutline then
            Crosshair.Drawings.RightOutline.From = Crosshair.Drawings.RightLine.From
            Crosshair.Drawings.RightOutline.To = Crosshair.Drawings.RightLine.To
            Crosshair.Drawings.RightOutline.Visible = Crosshair.Enabled
        end
    end
    
    -- Update Dot
    if Crosshair.Settings.Dot and Crosshair.Drawings.Dot then
        Crosshair.Drawings.Dot.Position = center
        Crosshair.Drawings.Dot.Color = color
        Crosshair.Drawings.Dot.Visible = Crosshair.Enabled
    end
end

-- Initialize Crosshair
local function InitializeCrosshair()
    CreateCrosshair()
    
    Crosshair.Connections.RenderStep = RunService.RenderStepped:Connect(UpdateCrosshair)
end

-- Cleanup Crosshair
local function CleanupCrosshair()
    for _, drawing in pairs(Crosshair.Drawings) do
        drawing:Remove()
    end
    
    Crosshair.Drawings = {}
    
    for _, connection in pairs(Crosshair.Connections) do
        connection:Disconnect()
    end
    
    Crosshair.Connections = {}
end

-- Public Methods
function Crosshair:SetEnabled(value)
    self.Enabled = value
    if value then
        InitializeCrosshair()
    else
        CleanupCrosshair()
    end
end

function Crosshair:SetSize(value)
    self.Settings.Size = value
    CreateCrosshair()
end

function Crosshair:SetThickness(value)
    self.Settings.Thickness = value
    CreateCrosshair()
end

function Crosshair:SetColor(color)
    self.Settings.Color = color
    self.Settings.RainbowMode = false
end

function Crosshair:SetGap(value)
    self.Settings.Gap = value
end

function Crosshair:SetDot(value)
    self.Settings.Dot = value
    CreateCrosshair()
end

function Crosshair:SetRainbow(value)
    self.Settings.RainbowMode = value
end

return Crosshair
