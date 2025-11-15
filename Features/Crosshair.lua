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
        OutlineThickness = 2,
        Dot = false,
        DotSize = 2,
        DotColor = Color3.fromRGB(0, 255, 0),
        DynamicColor = false,
        RainbowMode = false,
        Style = "Cross", -- Cross, Circle, Square
        Rotation = 0,
        Filled = false,
        Transparency = 1,
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
    
    -- Create based on style
    if Crosshair.Settings.Style == "Cross" then
        CreateCrossStyle(center)
    elseif Crosshair.Settings.Style == "Circle" then
        CreateCircleStyle(center)
    elseif Crosshair.Settings.Style == "Square" then
        CreateSquareStyle(center)
    end
    
    -- Center Dot
    if Crosshair.Settings.Dot then
        local dot = Drawing.new("Circle")
        dot.Radius = Crosshair.Settings.DotSize
        dot.Thickness = 1
        dot.Color = Crosshair.Settings.DotColor
        dot.Transparency = Crosshair.Settings.Transparency
        dot.Filled = Crosshair.Settings.Filled
        dot.Visible = true
        Crosshair.Drawings.Dot = dot
    end
end

-- Create Cross Style
local function CreateCrossStyle(center)
    local size = Crosshair.Settings.Size
    local gap = Crosshair.Settings.Gap
    local thickness = Crosshair.Settings.Thickness
    local color = Crosshair.Settings.Color
    
    -- Top Line
    local topLine = Drawing.new("Line")
    topLine.Thickness = thickness
    topLine.Color = color
    topLine.Transparency = Crosshair.Settings.Transparency
    topLine.Visible = true
    Crosshair.Drawings.TopLine = topLine
    
    -- Bottom Line
    local bottomLine = Drawing.new("Line")
    bottomLine.Thickness = thickness
    bottomLine.Color = color
    bottomLine.Transparency = Crosshair.Settings.Transparency
    bottomLine.Visible = true
    Crosshair.Drawings.BottomLine = bottomLine
    
    -- Left Line
    local leftLine = Drawing.new("Line")
    leftLine.Thickness = thickness
    leftLine.Color = color
    leftLine.Transparency = Crosshair.Settings.Transparency
    leftLine.Visible = true
    Crosshair.Drawings.LeftLine = leftLine
    
    -- Right Line
    local rightLine = Drawing.new("Line")
    rightLine.Thickness = thickness
    rightLine.Color = color
    rightLine.Transparency = Crosshair.Settings.Transparency
    rightLine.Visible = true
    Crosshair.Drawings.RightLine = rightLine
    
    -- Outlines
    if Crosshair.Settings.Outline then
        local outlineThickness = thickness + Crosshair.Settings.OutlineThickness
        local outlineColor = Crosshair.Settings.OutlineColor
        
        local topOutline = Drawing.new("Line")
        topOutline.Thickness = outlineThickness
        topOutline.Color = outlineColor
        topOutline.Transparency = Crosshair.Settings.Transparency
        topOutline.Visible = true
        topOutline.ZIndex = 0
        Crosshair.Drawings.TopOutline = topOutline
        
        local bottomOutline = Drawing.new("Line")
        bottomOutline.Thickness = outlineThickness
        bottomOutline.Color = outlineColor
        bottomOutline.Transparency = Crosshair.Settings.Transparency
        bottomOutline.Visible = true
        bottomOutline.ZIndex = 0
        Crosshair.Drawings.BottomOutline = bottomOutline
        
        local leftOutline = Drawing.new("Line")
        leftOutline.Thickness = outlineThickness
        leftOutline.Color = outlineColor
        leftOutline.Transparency = Crosshair.Settings.Transparency
        leftOutline.Visible = true
        leftOutline.ZIndex = 0
        Crosshair.Drawings.LeftOutline = leftOutline
        
        local rightOutline = Drawing.new("Line")
        rightOutline.Thickness = outlineThickness
        rightOutline.Color = outlineColor
        rightOutline.Transparency = Crosshair.Settings.Transparency
        rightOutline.Visible = true
        rightOutline.ZIndex = 0
        Crosshair.Drawings.RightOutline = rightOutline
    end
end

-- Create Circle Style
local function CreateCircleStyle(center)
    local circle = Drawing.new("Circle")
    circle.Radius = Crosshair.Settings.Size
    circle.Thickness = Crosshair.Settings.Thickness
    circle.Color = Crosshair.Settings.Color
    circle.Transparency = Crosshair.Settings.Transparency
    circle.Filled = Crosshair.Settings.Filled
    circle.NumSides = 50
    circle.Visible = true
    Crosshair.Drawings.Circle = circle
    
    -- Outline
    if Crosshair.Settings.Outline then
        local outline = Drawing.new("Circle")
        outline.Radius = Crosshair.Settings.Size
        outline.Thickness = Crosshair.Settings.Thickness + Crosshair.Settings.OutlineThickness
        outline.Color = Crosshair.Settings.OutlineColor
        outline.Transparency = Crosshair.Settings.Transparency
        outline.Filled = false
        outline.NumSides = 50
        outline.Visible = true
        outline.ZIndex = 0
        Crosshair.Drawings.CircleOutline = outline
    end
end

-- Create Square Style
local function CreateSquareStyle(center)
    local size = Crosshair.Settings.Size
    local thickness = Crosshair.Settings.Thickness
    local color = Crosshair.Settings.Color
    
    -- Top Line
    local topLine = Drawing.new("Line")
    topLine.Thickness = thickness
    topLine.Color = color
    topLine.Transparency = Crosshair.Settings.Transparency
    topLine.Visible = true
    Crosshair.Drawings.TopLine = topLine
    
    -- Bottom Line
    local bottomLine = Drawing.new("Line")
    bottomLine.Thickness = thickness
    bottomLine.Color = color
    bottomLine.Transparency = Crosshair.Settings.Transparency
    bottomLine.Visible = true
    Crosshair.Drawings.BottomLine = bottomLine
    
    -- Left Line
    local leftLine = Drawing.new("Line")
    leftLine.Thickness = thickness
    leftLine.Color = color
    leftLine.Transparency = Crosshair.Settings.Transparency
    leftLine.Visible = true
    Crosshair.Drawings.LeftLine = leftLine
    
    -- Right Line
    local rightLine = Drawing.new("Line")
    rightLine.Thickness = thickness
    rightLine.Color = color
    rightLine.Transparency = Crosshair.Settings.Transparency
    rightLine.Visible = true
    Crosshair.Drawings.RightLine = rightLine
    
    -- Outlines
    if Crosshair.Settings.Outline then
        local outlineThickness = thickness + Crosshair.Settings.OutlineThickness
        local outlineColor = Crosshair.Settings.OutlineColor
        
        local topOutline = Drawing.new("Line")
        topOutline.Thickness = outlineThickness
        topOutline.Color = outlineColor
        topOutline.Transparency = Crosshair.Settings.Transparency
        topOutline.Visible = true
        topOutline.ZIndex = 0
        Crosshair.Drawings.TopOutline = topOutline
        
        local bottomOutline = Drawing.new("Line")
        bottomOutline.Thickness = outlineThickness
        bottomOutline.Color = outlineColor
        bottomOutline.Transparency = Crosshair.Settings.Transparency
        bottomOutline.Visible = true
        bottomOutline.ZIndex = 0
        Crosshair.Drawings.BottomOutline = bottomOutline
        
        local leftOutline = Drawing.new("Line")
        leftOutline.Thickness = outlineThickness
        leftOutline.Color = outlineColor
        leftOutline.Transparency = Crosshair.Settings.Transparency
        leftOutline.Visible = true
        leftOutline.ZIndex = 0
        Crosshair.Drawings.LeftOutline = leftOutline
        
        local rightOutline = Drawing.new("Line")
        rightOutline.Thickness = outlineThickness
        rightOutline.Color = outlineColor
        rightOutline.Transparency = Crosshair.Settings.Transparency
        rightOutline.Visible = true
        rightOutline.ZIndex = 0
        Crosshair.Drawings.RightOutline = rightOutline
    end
end

-- Update Crosshair Position
local function UpdateCrosshair()
    if not Crosshair.Enabled then return end
    
    local screenSize = Camera.ViewportSize
    local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    
    local size = Crosshair.Settings.Size
    local gap = Crosshair.Settings.Gap
    local color = Crosshair.Settings.Color
    
    -- Rainbow mode
    if Crosshair.Settings.RainbowMode then
        local hue = tick() % 5 / 5
        color = Color3.fromHSV(hue, 1, 1)
        Crosshair.Settings.Color = color
    end
    
    -- Update based on style
    if Crosshair.Settings.Style == "Cross" then
        UpdateCrossStyle(center, size, gap, color)
    elseif Crosshair.Settings.Style == "Circle" then
        UpdateCircleStyle(center, size, color)
    elseif Crosshair.Settings.Style == "Square" then
        UpdateSquareStyle(center, size, gap, color)
    end
    
    -- Update Dot
    if Crosshair.Settings.Dot and Crosshair.Drawings.Dot then
        Crosshair.Drawings.Dot.Position = center
        Crosshair.Drawings.Dot.Color = Crosshair.Settings.DotColor
        Crosshair.Drawings.Dot.Radius = Crosshair.Settings.DotSize
        Crosshair.Drawings.Dot.Transparency = Crosshair.Settings.Transparency
        Crosshair.Drawings.Dot.Filled = Crosshair.Settings.Filled
        Crosshair.Drawings.Dot.Visible = Crosshair.Enabled
    end
end

-- Update Cross Style
local function UpdateCrossStyle(center, size, gap, color)
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
            Crosshair.Drawings.TopOutline.Color = Crosshair.Settings.OutlineColor
            Crosshair.Drawings.TopOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.BottomOutline then
            Crosshair.Drawings.BottomOutline.From = Crosshair.Drawings.BottomLine.From
            Crosshair.Drawings.BottomOutline.To = Crosshair.Drawings.BottomLine.To
            Crosshair.Drawings.BottomOutline.Color = Crosshair.Settings.OutlineColor
            Crosshair.Drawings.BottomOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.LeftOutline then
            Crosshair.Drawings.LeftOutline.From = Crosshair.Drawings.LeftLine.From
            Crosshair.Drawings.LeftOutline.To = Crosshair.Drawings.LeftLine.To
            Crosshair.Drawings.LeftOutline.Color = Crosshair.Settings.OutlineColor
            Crosshair.Drawings.LeftOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.RightOutline then
            Crosshair.Drawings.RightOutline.From = Crosshair.Drawings.RightLine.From
            Crosshair.Drawings.RightOutline.To = Crosshair.Drawings.RightLine.To
            Crosshair.Drawings.RightOutline.Color = Crosshair.Settings.OutlineColor
            Crosshair.Drawings.RightOutline.Visible = Crosshair.Enabled
        end
    end
end

-- Update Circle Style
local function UpdateCircleStyle(center, size, color)
    if Crosshair.Drawings.Circle then
        Crosshair.Drawings.Circle.Position = center
        Crosshair.Drawings.Circle.Radius = size
        Crosshair.Drawings.Circle.Color = color
        Crosshair.Drawings.Circle.Transparency = Crosshair.Settings.Transparency
        Crosshair.Drawings.Circle.Filled = Crosshair.Settings.Filled
        Crosshair.Drawings.Circle.Visible = Crosshair.Enabled
    end
    
    if Crosshair.Settings.Outline and Crosshair.Drawings.CircleOutline then
        Crosshair.Drawings.CircleOutline.Position = center
        Crosshair.Drawings.CircleOutline.Radius = size
        Crosshair.Drawings.CircleOutline.Color = Crosshair.Settings.OutlineColor
        Crosshair.Drawings.CircleOutline.Transparency = Crosshair.Settings.Transparency
        Crosshair.Drawings.CircleOutline.Visible = Crosshair.Enabled
    end
end

-- Update Square Style
local function UpdateSquareStyle(center, size, gap, color)
    -- Update Lines (square)
    if Crosshair.Drawings.TopLine then
        Crosshair.Drawings.TopLine.From = Vector2.new(center.X - size, center.Y - gap)
        Crosshair.Drawings.TopLine.To = Vector2.new(center.X + size, center.Y - gap)
        Crosshair.Drawings.TopLine.Color = color
        Crosshair.Drawings.TopLine.Visible = Crosshair.Enabled
    end
    
    if Crosshair.Drawings.BottomLine then
        Crosshair.Drawings.BottomLine.From = Vector2.new(center.X - size, center.Y + gap)
        Crosshair.Drawings.BottomLine.To = Vector2.new(center.X + size, center.Y + gap)
        Crosshair.Drawings.BottomLine.Color = color
        Crosshair.Drawings.BottomLine.Visible = Crosshair.Enabled
    end
    
    if Crosshair.Drawings.LeftLine then
        Crosshair.Drawings.LeftLine.From = Vector2.new(center.X - gap, center.Y - size)
        Crosshair.Drawings.LeftLine.To = Vector2.new(center.X - gap, center.Y + size)
        Crosshair.Drawings.LeftLine.Color = color
        Crosshair.Drawings.LeftLine.Visible = Crosshair.Enabled
    end
    
    if Crosshair.Drawings.RightLine then
        Crosshair.Drawings.RightLine.From = Vector2.new(center.X + gap, center.Y - size)
        Crosshair.Drawings.RightLine.To = Vector2.new(center.X + gap, center.Y + size)
        Crosshair.Drawings.RightLine.Color = color
        Crosshair.Drawings.RightLine.Visible = Crosshair.Enabled
    end
    
    -- Update Outlines
    if Crosshair.Settings.Outline then
        if Crosshair.Drawings.TopOutline then
            Crosshair.Drawings.TopOutline.From = Crosshair.Drawings.TopLine.From
            Crosshair.Drawings.TopOutline.To = Crosshair.Drawings.TopLine.To
            Crosshair.Drawings.TopOutline.Color = Crosshair.Settings.OutlineColor
            Crosshair.Drawings.TopOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.BottomOutline then
            Crosshair.Drawings.BottomOutline.From = Crosshair.Drawings.BottomLine.From
            Crosshair.Drawings.BottomOutline.To = Crosshair.Drawings.BottomLine.To
            Crosshair.Drawings.BottomOutline.Color = Crosshair.Settings.OutlineColor
            Crosshair.Drawings.BottomOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.LeftOutline then
            Crosshair.Drawings.LeftOutline.From = Crosshair.Drawings.LeftLine.From
            Crosshair.Drawings.LeftOutline.To = Crosshair.Drawings.LeftLine.To
            Crosshair.Drawings.LeftOutline.Color = Crosshair.Settings.OutlineColor
            Crosshair.Drawings.LeftOutline.Visible = Crosshair.Enabled
        end
        
        if Crosshair.Drawings.RightOutline then
            Crosshair.Drawings.RightOutline.From = Crosshair.Drawings.RightLine.From
            Crosshair.Drawings.RightOutline.To = Crosshair.Drawings.RightLine.To
            Crosshair.Drawings.RightOutline.Color = Crosshair.Settings.OutlineColor
            Crosshair.Drawings.RightOutline.Visible = Crosshair.Enabled
        end
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

function Crosshair:SetGap(value)
    self.Settings.Gap = value
    CreateCrosshair()
end

function Crosshair:SetColor(color)
    self.Settings.Color = color
    self.Settings.RainbowMode = false
end

function Crosshair:SetDot(value)
    self.Settings.Dot = value
    CreateCrosshair()
end

function Crosshair:SetDotSize(value)
    self.Settings.DotSize = value
    CreateCrosshair()
end

function Crosshair:SetDotColor(color)
    self.Settings.DotColor = color
end

function Crosshair:SetOutline(value)
    self.Settings.Outline = value
    CreateCrosshair()
end

function Crosshair:SetOutlineThickness(value)
    self.Settings.OutlineThickness = value
    CreateCrosshair()
end

function Crosshair:SetOutlineColor(color)
    self.Settings.OutlineColor = color
end

function Crosshair:SetFilled(value)
    self.Settings.Filled = value
    CreateCrosshair()
end

function Crosshair:SetTransparency(value)
    self.Settings.Transparency = value
    CreateCrosshair()
end

function Crosshair:SetStyle(style)
    self.Settings.Style = style
    CreateCrosshair()
end

function Crosshair:SetRainbow(value)
    self.Settings.RainbowMode = value
end

function Crosshair:Create()
    CreateCrosshair()
end

return Crosshair
