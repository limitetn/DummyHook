--[[
    DummyHook UI Library
    Skeet & Aimware Inspired Design
]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Theme Configuration (Skeet-style dark theme)
Library.Theme = {
    Background = Color3.fromRGB(15, 15, 18),
    Secondary = Color3.fromRGB(22, 22, 26),
    Tertiary = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(130, 195, 65),
    AccentDark = Color3.fromRGB(100, 165, 45),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(180, 180, 180),
    Border = Color3.fromRGB(45, 45, 50),
    Success = Color3.fromRGB(100, 255, 100),
    Error = Color3.fromRGB(255, 100, 100),
}

-- Store references to all themeable elements for dynamic updates
Library.ThemeElements = {}

-- Utility function to register themeable elements
function Library:RegisterThemeElement(element, property, themeKey)
    if not self.ThemeElements[themeKey] then
        self.ThemeElements[themeKey] = {}
    end
    table.insert(self.ThemeElements[themeKey], {Element = element, Property = property})
end

-- Function to update all theme elements
function Library:UpdateTheme(newTheme)
    if newTheme then
        self.Theme = newTheme
    end
    
    -- Update all registered elements
    for themeKey, elements in pairs(self.ThemeElements) do
        local color = self.Theme[themeKey]
        if color then
            for _, elementData in pairs(elements) do
                elementData.Element[elementData.Property] = color
            end
        end
    end
    
    -- Update main window elements
    if self.MainFrame then
        self.MainFrame.BackgroundColor3 = self.Theme.Background
    end
    
    if self.TopBar then
        self.TopBar.BackgroundColor3 = self.Theme.Accent
    end
    
    if self.Header then
        self.Header.BackgroundColor3 = self.Theme.Secondary
    end
    
    if self.TabContainer then
        self.TabContainer.BackgroundColor3 = self.Theme.Tertiary
    end
    
    if self.ScrollLeftButton then
        self.ScrollLeftButton.BackgroundColor3 = self.Theme.Secondary
    end
    
    if self.ScrollRightButton then
        self.ScrollRightButton.BackgroundColor3 = self.Theme.Secondary
    end
end

-- Utility Functions
local function CreateElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

local function Tween(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Create Window
function Library:CreateWindow(config)
    local Window = {
        Title = config.Title or "DummyHook",
        Theme = config.Theme or "Skeet",
        Size = config.Size or UDim2.new(0, 580, 0, 460),
        KeyBind = config.KeyBind or Enum.KeyCode.RightShift,
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Main ScreenGui
    local ScreenGui = CreateElement("ScreenGui", {
        Name = "DummyHook_UI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    })
    
    -- Watermark
    local Watermark = CreateElement("TextLabel", {
        Name = "Watermark",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "DummyHook",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextTransparency = 0.8,
        TextSize = 48,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = ScreenGui
    })
    
    -- Animate watermark
    spawn(function()
        local transparency = 0.7
        local direction = 0.005
        
        while wait(0.05) do
            if Watermark and Watermark.Parent then
                transparency = transparency + direction
                
                if transparency >= 0.9 then
                    direction = -0.005
                elseif transparency <= 0.7 then
                    direction = 0.005
                end
                
                Watermark.TextTransparency = transparency
            end
        end
    end)
    
    -- Enhanced Professional Intro Animation with more beautiful and lively effects
    local IntroOverlay = CreateElement("Frame", {
        Name = "IntroOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(5, 5, 10),
        BorderSizePixel = 0,
        ZIndex = 1000,
        Parent = ScreenGui
    })
    
    -- Animated background gradient with multiple colors
    local BackgroundGradient = CreateElement("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 20)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(25, 15, 35)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(15, 25, 40)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(30, 15, 45)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(20, 10, 30)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
        },
        Rotation = 0,
        Parent = IntroOverlay
    })
    
    -- Animate gradient rotation for dynamic effect
    spawn(function()
        local rotation = 0
        while IntroOverlay and IntroOverlay.Parent do
            rotation = (rotation + 0.5) % 360
            BackgroundGradient.Rotation = rotation
            wait(0.02)
        end
    end)
    
    -- Enhanced animated particles with multiple colors and sizes
    local Particles = {}
    for i = 1, 30 do
        local colors = {
            Color3.fromRGB(130, 195, 65),  -- Green
            Color3.fromRGB(90, 180, 220),  -- Blue
            Color3.fromRGB(180, 90, 220),  -- Purple
            Color3.fromRGB(220, 90, 90),   -- Red
            Color3.fromRGB(220, 180, 90)   -- Yellow
        }
        
        local particle = CreateElement("Frame", {
            Name = "Particle" .. i,
            Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8)),
            Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0),
            BackgroundColor3 = colors[math.random(1, #colors)],
            BorderSizePixel = 0,
            BackgroundTransparency = 0.6,
            Parent = IntroOverlay
        })
        
        local particleCorner = CreateElement("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = particle
        })
        
        -- Add glow effect to particles
        local particleGlow = CreateElement("Frame", {
            Size = UDim2.new(1, 6, 1, 6),
            Position = UDim2.new(0.5, -3, 0.5, -3),
            BackgroundColor3 = particle.BackgroundColor3,
            BorderSizePixel = 0,
            BackgroundTransparency = 0.8,
            Parent = particle
        })
        
        local glowCorner = CreateElement("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = particleGlow
        })
        
        table.insert(Particles, {Main = particle, Glow = particleGlow, SpeedX = (math.random(-10, 10) / 200), SpeedY = (math.random(-10, 10) / 200)})
    end
    
    -- Animate particles with more complex movement
    spawn(function()
        while IntroOverlay and IntroOverlay.Parent do
            for _, particleData in pairs(Particles) do
                local particle = particleData.Main
                local glow = particleData.Glow
                if particle and particle.Parent and glow and glow.Parent then
                    local newX = particle.Position.X.Scale + particleData.SpeedX
                    local newY = particle.Position.Y.Scale + particleData.SpeedY
                    
                    -- Bounce off edges
                    if newX <= 0 or newX >= 1 then
                        particleData.SpeedX = -particleData.SpeedX
                        newX = math.clamp(newX, 0, 1)
                    end
                    
                    if newY <= 0 or newY >= 1 then
                        particleData.SpeedY = -particleData.SpeedY
                        newY = math.clamp(newY, 0, 1)
                    end
                    
                    particle.Position = UDim2.new(newX, particle.Position.X.Offset, newY, particle.Position.Y.Offset)
                    
                    -- Pulsing effect with color cycling
                    local pulse = math.sin(tick() * 3 + particleData.SpeedX * 10) * 0.1
                    particle.BackgroundTransparency = 0.5 + pulse
                    glow.BackgroundTransparency = 0.7 + pulse
                    
                    -- Rotate particles
                    particle.Rotation = (particle.Rotation + 1) % 360
                end
            end
            wait(0.03)
        end
    end)
    
    -- Main logo container with enhanced glow effect
    local LogoContainer = CreateElement("Frame", {
        Name = "LogoContainer",
        Size = UDim2.new(0, 350, 0, 120),
        Position = UDim2.new(0.5, -175, 0.35, -60),
        BackgroundTransparency = 1,
        Parent = IntroOverlay
    })
    
    -- Enhanced glow effect with multiple layers
    local LogoGlow1 = CreateElement("Frame", {
        Name = "LogoGlow1",
        Size = UDim2.new(1, 40, 1, 40),
        Position = UDim2.new(0.5, -195, 0.5, -80),
        BackgroundColor3 = Color3.fromRGB(130, 195, 65),
        BorderSizePixel = 0,
        BackgroundTransparency = 0.92,
        Parent = LogoContainer
    })
    
    local GlowCorner1 = CreateElement("UICorner", {
        CornerRadius = UDim.new(0, 30),
        Parent = LogoGlow1
    })
    
    local LogoGlow2 = CreateElement("Frame", {
        Name = "LogoGlow2",
        Size = UDim2.new(1, 60, 1, 60),
        Position = UDim2.new(0.5, -205, 0.5, -90),
        BackgroundColor3 = Color3.fromRGB(90, 180, 220),
        BorderSizePixel = 0,
        BackgroundTransparency = 0.95,
        Parent = LogoContainer
    })
    
    local GlowCorner2 = CreateElement("UICorner", {
        CornerRadius = UDim.new(0, 40),
        Parent = LogoGlow2
    })
    
    -- Animate glow pulsing with multiple layers
    spawn(function()
        while (LogoGlow1 and LogoGlow1.Parent) or (LogoGlow2 and LogoGlow2.Parent) do
            local pulse = math.sin(tick() * 4) * 0.03
            
            if LogoGlow1 and LogoGlow1.Parent then
                LogoGlow1.BackgroundTransparency = 0.89 + pulse
                LogoGlow1.Size = UDim2.new(1, 40 + math.sin(tick() * 3) * 10, 1, 40 + math.sin(tick() * 3) * 10)
                LogoGlow1.Position = UDim2.new(0.5, -195 - math.sin(tick() * 3) * 5, 0.5, -80 - math.sin(tick() * 3) * 5)
            end
            
            if LogoGlow2 and LogoGlow2.Parent then
                LogoGlow2.BackgroundTransparency = 0.92 + pulse
                LogoGlow2.Size = UDim2.new(1, 60 + math.sin(tick() * 2) * 15, 1, 60 + math.sin(tick() * 2) * 15)
                LogoGlow2.Position = UDim2.new(0.5, -205 - math.sin(tick() * 2) * 7.5, 0.5, -90 - math.sin(tick() * 2) * 7.5)
            end
            
            wait(0.03)
        end
    end)
    
    -- Main logo text with enhanced styling
    local Logo = CreateElement("TextLabel", {
        Name = "Logo",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "DUMMYHOOK",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 48,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = LogoContainer
    })
    
    -- Add a subtle shadow to the logo
    local LogoShadow = CreateElement("TextLabel", {
        Name = "LogoShadow",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 2, 0, 2),
        BackgroundTransparency = 1,
        Text = "DUMMYHOOK",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextTransparency = 0.7,
        TextSize = 48,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = LogoContainer
    })
    
    -- Enhanced version text with animation
    local Version = CreateElement("TextLabel", {
        Name = "Version",
        Size = UDim2.new(0, 150, 0, 25),
        Position = UDim2.new(0.5, -75, 0.35, 70),
        BackgroundTransparency = 1,
        Text = "PREMIUM EDITION v2.5",
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextSize = 18,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = IntroOverlay
    })
    
    -- Loading bar container with enhanced styling
    local LoadingContainer = CreateElement("Frame", {
        Name = "LoadingContainer",
        Size = UDim2.new(0, 250, 0, 6),
        Position = UDim2.new(0.5, -125, 0.55, 0),
        BackgroundColor3 = Color3.fromRGB(25, 25, 30),
        BorderSizePixel = 0,
        Parent = IntroOverlay
    })
    
    local LoadingCorner = CreateElement("UICorner", {
        CornerRadius = UDim.new(0, 3),
        Parent = LoadingContainer
    })
    
    -- Loading bar with gradient
    local LoadingBar = CreateElement("Frame", {
        Name = "LoadingBar",
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(130, 195, 65),
        BorderSizePixel = 0,
        Parent = LoadingContainer
    })
    
    local BarCorner = CreateElement("UICorner", {
        CornerRadius = UDim.new(0, 3),
        Parent = LoadingBar
    })
    
    -- Add gradient to loading bar
    local BarGradient = CreateElement("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 195, 65)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(90, 180, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 90, 220))
        },
        Rotation = 0,
        Parent = LoadingBar
    })
    
    -- Loading text with enhanced styling
    local LoadingText = CreateElement("TextLabel", {
        Name = "LoadingText",
        Size = UDim2.new(0, 250, 0, 25),
        Position = UDim2.new(0.5, -125, 0.55, 15),
        BackgroundTransparency = 1,
        Text = "Initializing security protocols...",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 15,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = IntroOverlay
    })
    
    -- Enhanced loading messages with more detailed steps
    local loadingMessages = {
        "Initializing security protocols...",
        "Connecting to premium servers...",
        "Loading advanced modules...",
        "Verifying authentication...",
        "Establishing secure connection...",
        "Loading UI components...",
        "Initializing cheat modules...",
        "Applying premium features...",
        "Finalizing setup...",
        "Access granted. Welcome to DummyHook Premium!"
    }
    
    -- Animate intro sequence with enhanced effects
    spawn(function()
        -- Animate logo entrance with scaling effect
        Logo.TextTransparency = 1
        LogoShadow.TextTransparency = 0.7
        Version.TextTransparency = 1
        LoadingText.TextTransparency = 1
        
        -- Scale in logo
        Logo.Size = UDim2.new(1.2, 0, 1.2, 0)
        Logo.Position = UDim2.new(0.5, -210, 0.35, -72)
        LogoShadow.Size = UDim2.new(1.2, 0, 1.2, 0)
        LogoShadow.Position = UDim2.new(0.5, -208, 0.35, -70)
        
        -- Fade in and scale to normal
        for i = 100, 0, -3 do
            if Logo and Logo.Parent then
                Logo.TextTransparency = i / 100
                Logo.Size = UDim2.new(1 + (i / 100) * 0.2, 0, 1 + (i / 100) * 0.2, 0)
                Logo.Position = UDim2.new(0.5, -175 - (i / 100) * 35, 0.35, -60 - (i / 100) * 12)
            end
            if LogoShadow and LogoShadow.Parent then
                LogoShadow.TextTransparency = 0.7 + (i / 100) * 0.3
                LogoShadow.Size = UDim2.new(1 + (i / 100) * 0.2, 0, 1 + (i / 100) * 0.2, 0)
                LogoShadow.Position = UDim2.new(0.5, -173 - (i / 100) * 35, 0.35, -58 - (i / 100) * 12)
            end
            if Version and Version.Parent then
                Version.TextTransparency = i / 100
            end
            if LoadingText and LoadingText.Parent then
                LoadingText.TextTransparency = i / 100
            end
            wait(0.01)
        end
        
        -- Animate loading bar with bouncing effect
        local currentMessage = 1
        for i = 0, 100, 1 do
            if LoadingBar and LoadingBar.Parent then
                LoadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
                
                -- Add bouncing effect to loading bar
                local bounce = math.sin(tick() * 10 + i / 10) * 0.1
                LoadingBar.Size = UDim2.new(i / 100, 0, 1 + bounce, 0)
            end
            
            -- Update loading message with smoother transitions
            if i % 10 == 0 and currentMessage <= #loadingMessages then
                if LoadingText and LoadingText.Parent then
                    -- Fade out
                    for j = 0, 100, 10 do
                        LoadingText.TextTransparency = j / 100
                        wait(0.005)
                    end
                    
                    LoadingText.Text = loadingMessages[currentMessage]
                    
                    -- Fade in
                    for j = 100, 0, -10 do
                        LoadingText.TextTransparency = j / 100
                        wait(0.005)
                    end
                end
                currentMessage = currentMessage + 1
            end
            
            wait(0.04)
        end
        
        -- Final message with enhanced effect
        if LoadingText and LoadingText.Parent then
            -- Fade out
            for j = 0, 100, 5 do
                LoadingText.TextTransparency = j / 100
                wait(0.01)
            end
            
            LoadingText.Text = "Access granted. Welcome to DummyHook Premium!"
            LoadingText.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            -- Fade in
            for j = 100, 0, -5 do
                LoadingText.TextTransparency = j / 100
                wait(0.01)
            end
        end
        
        -- Wait for dramatic effect
        wait(2)
        
        -- Animate exit sequence with enhanced effects
        -- Fade out all elements with scaling
        for i = 0, 100, 2 do
            local progress = i / 100
            
            if IntroOverlay and IntroOverlay.Parent then
                IntroOverlay.BackgroundTransparency = progress
            end
            
            if LogoContainer and LogoContainer.Parent then
                LogoContainer.BackgroundTransparency = progress
                -- Scale down
                local scale = 1 - progress
                LogoContainer.Size = UDim2.new(0, 350 * scale, 0, 120 * scale)
                LogoContainer.Position = UDim2.new(0.5, -175 * scale, 0.35, -60 * scale)
            end
            
            if Logo and Logo.Parent then
                Logo.TextTransparency = progress
            end
            
            if LogoShadow and LogoShadow.Parent then
                LogoShadow.TextTransparency = 0.7 + progress * 0.3
            end
            
            if Version and Version.Parent then
                Version.TextTransparency = progress
            end
            
            if LoadingText and LoadingText.Parent then
                LoadingText.TextTransparency = progress
            end
            
            if LoadingContainer and LoadingContainer.Parent then
                LoadingContainer.BackgroundTransparency = progress
            end
            
            if LoadingBar and LoadingBar.Parent then
                LoadingBar.BackgroundTransparency = progress
            end
            
            -- Fade out and scale down particles
            for _, particleData in pairs(Particles) do
                local particle = particleData.Main
                local glow = particleData.Glow
                if particle and particle.Parent then
                    particle.BackgroundTransparency = progress
                    -- Scale down
                    local scale = 1 - progress
                    particle.Size = UDim2.new(0, particle.Size.X.Offset * scale, 0, particle.Size.Y.Offset * scale)
                end
                if glow and glow.Parent then
                    glow.BackgroundTransparency = 0.7 + progress * 0.3
                end
            end
            
            wait(0.015)
        end
        
        -- Destroy intro overlay
        if IntroOverlay and IntroOverlay.Parent then
            IntroOverlay:Destroy()
        end
        
        -- Notify that intro is complete
        if Window and Window.OnIntroComplete then
            Window:OnIntroComplete()
        end
    end)
    
    -- Main Frame
    local MainFrame = CreateElement("Frame", {
        Name = "MainFrame",
        Size = Window.Size,
        Position = UDim2.new(0.5, -Window.Size.X.Offset/2, 0.5, -Window.Size.Y.Offset/2),
        BackgroundColor3 = Library.Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = ScreenGui
    })
    Window.MainFrame = MainFrame -- Store reference for theme updates
    Library:RegisterThemeElement(MainFrame, "BackgroundColor3", "Background")
    
    -- Top Accent Bar (Rainbow Gradient - Skeet style)
    local TopBar = CreateElement("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Library.Theme.Accent,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    Window.TopBar = TopBar -- Store reference for theme updates
    Library:RegisterThemeElement(TopBar, "BackgroundColor3", "Accent")
    
    local Gradient = CreateElement("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 195, 65)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(90, 180, 220)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(180, 90, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 90, 90))
        },
        Parent = TopBar
    })
    
    -- Animate gradient
    spawn(function()
        while wait() do
            for i = 0, 360, 1 do
                Gradient.Rotation = i
                wait(0.01)
            end
        end
    end)
    
    -- Header
    local Header = CreateElement("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 45),
        Position = UDim2.new(0, 0, 0, 2),
        BackgroundColor3 = Library.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    Window.Header = Header -- Store reference for theme updates
    Library:RegisterThemeElement(Header, "BackgroundColor3", "Secondary")
    
    local Title = CreateElement("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = Window.Title,
        TextColor3 = Library.Theme.Text,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header
    })
    Library:RegisterThemeElement(Title, "TextColor3", "Text")
    
    local VersionLabel = CreateElement("TextLabel", {
        Name = "Version",
        Size = UDim2.new(0, 100, 1, 0),
        Position = UDim2.new(1, -110, 0, 0),
        BackgroundTransparency = 1,
        Text = "v1.0.0",
        TextColor3 = Library.Theme.TextDark,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = Header
    })
    Library:RegisterThemeElement(VersionLabel, "TextColor3", "TextDark")
    
    -- Tab Container with Scrolling Support
    local TabContainer = CreateElement("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(1, 0, 0, 35),
        Position = UDim2.new(0, 0, 0, 47),
        BackgroundColor3 = Library.Theme.Tertiary,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    Window.TabContainer = TabContainer -- Store reference for theme updates
    Library:RegisterThemeElement(TabContainer, "BackgroundColor3", "Tertiary")
    
    -- Scroll buttons for tabs
    local ScrollLeftButton = CreateElement("TextButton", {
        Name = "ScrollLeft",
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Library.Theme.Secondary,
        BorderSizePixel = 0,
        Text = "<",
        TextColor3 = Library.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = TabContainer
    })
    Window.ScrollLeftButton = ScrollLeftButton -- Store reference for theme updates
    Library:RegisterThemeElement(ScrollLeftButton, "BackgroundColor3", "Secondary")
    Library:RegisterThemeElement(ScrollLeftButton, "TextColor3", "Text")
    
    local ScrollRightButton = CreateElement("TextButton", {
        Name = "ScrollRight",
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -20, 0, 0),
        BackgroundColor3 = Library.Theme.Secondary,
        BorderSizePixel = 0,
        Text = ">",
        TextColor3 = Library.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = TabContainer
    })
    Window.ScrollRightButton = ScrollRightButton -- Store reference for theme updates
    Library:RegisterThemeElement(ScrollRightButton, "BackgroundColor3", "Secondary")
    Library:RegisterThemeElement(ScrollRightButton, "TextColor3", "Text")
    
    local TabScrollFrame = CreateElement("ScrollingFrame", {
        Name = "TabScrollFrame",
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 25, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 1, 0),
        ScrollingDirection = Enum.ScrollingDirection.X,
        Parent = TabContainer
    })
    
    local TabList = CreateElement("Frame", {
        Name = "TabList",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = TabScrollFrame
    })
    
    local TabListLayout = CreateElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        Parent = TabList
    })
    
    -- Update canvas size when tabs are added
    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabScrollFrame.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X + 10, 1, 0)
    end)
    
    -- Scroll button functionality
    ScrollLeftButton.MouseButton1Click:Connect(function()
        Tween(TabScrollFrame, {CanvasPosition = Vector2.new(math.max(0, TabScrollFrame.CanvasPosition.X - 100), 0)}, 0.3)
    end)
    
    ScrollRightButton.MouseButton1Click:Connect(function()
        local maxScroll = math.max(0, TabScrollFrame.CanvasSize.X.Offset - TabScrollFrame.AbsoluteSize.X)
        Tween(TabScrollFrame, {CanvasPosition = Vector2.new(math.min(maxScroll, TabScrollFrame.CanvasPosition.X + 100), 0)}, 0.3)
    end)
    
    -- Hover effects for scroll buttons
    ScrollLeftButton.MouseEnter:Connect(function()
        Tween(ScrollLeftButton, {BackgroundColor3 = Library.Theme.Accent}, 0.2)
    end)
    
    ScrollLeftButton.MouseLeave:Connect(function()
        Tween(ScrollLeftButton, {BackgroundColor3 = Library.Theme.Secondary}, 0.2)
    end)
    
    ScrollRightButton.MouseEnter:Connect(function()
        Tween(ScrollRightButton, {BackgroundColor3 = Library.Theme.Accent}, 0.2)
    end)
    
    ScrollRightButton.MouseLeave:Connect(function()
        Tween(ScrollRightButton, {BackgroundColor3 = Library.Theme.Secondary}, 0.2)
    end)
    
    -- Content Container
    local ContentContainer = CreateElement("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, -20, 1, -97),
        Position = UDim2.new(0, 10, 0, 87),
        BackgroundTransparency = 1,
        Parent = MainFrame
    })
    
    -- Dragging functionality
    local dragging, dragInput, dragStart, startPos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Toggle UI visibility with animations
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Window.KeyBind then
            if not MainFrame.Visible then
                -- Opening animation
                MainFrame.Visible = true
                MainFrame.BackgroundTransparency = 1
                MainFrame.Size = UDim2.new(0, 0, 0, 0)
                MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                
                -- Fade in and scale up animation
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                local sizeTween = TweenService:Create(MainFrame, tweenInfo, {
                    Size = Window.Size,
                    Position = UDim2.new(0.5, -Window.Size.X.Offset/2, 0.5, -Window.Size.Y.Offset/2),
                    BackgroundTransparency = 0
                })
                sizeTween:Play()
            else
                -- Closing animation
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                local sizeTween = TweenService:Create(MainFrame, tweenInfo, {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BackgroundTransparency = 1
                })
                sizeTween:Play()
                
                -- Hide after animation
                spawn(function()
                    wait(0.3)
                    MainFrame.Visible = false
                end)
            end
        end
    end)
    
    -- Create Tab
    function Window:CreateTab(name)
        local Tab = {
            Name = name,
            Sections = {},
            Active = false
        }
        
        -- Tab Button
        local TabButton = CreateElement("TextButton", {
            Name = name .. "Tab",
            Size = UDim2.new(0, 100, 1, -10),
            BackgroundColor3 = Library.Theme.Secondary,
            BorderSizePixel = 0,
            Text = name:upper(),
            TextColor3 = Library.Theme.TextDark,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false,
            Parent = TabList
        })
        
        local TabCorner = CreateElement("UICorner", {
            CornerRadius = UDim.new(0, 3),
            Parent = TabButton
        })
        
        -- Tab Content
        local TabContent = CreateElement("ScrollingFrame", {
            Name = name .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Library.Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = ContentContainer
        })
        
        local ContentLayout = CreateElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = TabContent
        })
        
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Active = false
                tab.Button.BackgroundColor3 = Library.Theme.Secondary
                tab.Button.TextColor3 = Library.Theme.TextDark
                tab.Content.Visible = false
            end
            
            Tab.Active = true
            TabButton.BackgroundColor3 = Library.Theme.Tertiary
            TabButton.TextColor3 = Library.Theme.Text
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end)
        
        TabButton.MouseEnter:Connect(function()
            if not Tab.Active then
                Tween(TabButton, {BackgroundColor3 = Library.Theme.Tertiary}, 0.15)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if not Tab.Active then
                Tween(TabButton, {BackgroundColor3 = Library.Theme.Secondary}, 0.15)
            end
        end)
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        
        -- Auto-select first tab
        if #Window.Tabs == 0 then
            TabButton.BackgroundColor3 = Library.Theme.Tertiary
            TabButton.TextColor3 = Library.Theme.Text
            TabContent.Visible = true
            Tab.Active = true
            Window.CurrentTab = Tab
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- Create Section
        function Tab:CreateSection(name)
            local Section = {
                Name = name,
                Elements = {}
            }
            
            local SectionFrame = CreateElement("Frame", {
                Name = name .. "Section",
                Size = UDim2.new(1, -10, 0, 0),
                BackgroundColor3 = Library.Theme.Secondary,
                BorderSizePixel = 0,
                Parent = TabContent
            })
            
            local SectionCorner = CreateElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
                Parent = SectionFrame
            })
            
            local SectionTitle = CreateElement("TextLabel", {
                Name = "Title",
                Size = UDim2.new(1, -20, 0, 30),
                Position = UDim2.new(0, 10, 0, 5),
                BackgroundTransparency = 1,
                Text = name:upper(),
                TextColor3 = Library.Theme.Accent,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = SectionFrame
            })
            
            local ElementContainer = CreateElement("Frame", {
                Name = "Elements",
                Size = UDim2.new(1, -20, 1, -40),
                Position = UDim2.new(0, 10, 0, 35),
                BackgroundTransparency = 1,
                Parent = SectionFrame
            })
            
            local ElementLayout = CreateElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
                Parent = ElementContainer
            })
            
            ElementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -10, 0, ElementLayout.AbsoluteContentSize.Y + 45)
            end)
            
            Section.Frame = SectionFrame
            Section.Container = ElementContainer
            
            -- Add Toggle
            function Section:AddToggle(name, default, callback)
                local Toggle = {Value = default}
                
                local ToggleFrame = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 25),
                    BackgroundTransparency = 1,
                    Parent = ElementContainer
                })
                
                local ToggleLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(1, -40, 1, 0),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ToggleFrame
                })
                
                local ToggleBox = CreateElement("TextButton", {
                    Size = UDim2.new(0, 35, 0, 18),
                    Position = UDim2.new(1, -35, 0.5, -9),
                    BackgroundColor3 = default and Library.Theme.Accent or Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false,
                    Parent = ToggleFrame
                })
                
                local BoxCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = ToggleBox
                })
                
                local ToggleIndicator = CreateElement("Frame", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = ToggleBox
                })
                
                local IndicatorCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = ToggleIndicator
                })
                
                -- Hover effects
                ToggleBox.MouseEnter:Connect(function()
                    Tween(ToggleBox, {
                        Size = UDim2.new(0, 37, 0, 20)
                    }, 0.15)
                end)
                
                ToggleBox.MouseLeave:Connect(function()
                    Tween(ToggleBox, {
                        Size = UDim2.new(0, 35, 0, 18)
                    }, 0.15)
                end)
                
                ToggleBox.MouseButton1Click:Connect(function()
                    Toggle.Value = not Toggle.Value
                    
                    -- Scale animation on click
                    Tween(ToggleBox, {Size = UDim2.new(0, 33, 0, 16)}, 0.1)
                    task.wait(0.1)
                    Tween(ToggleBox, {Size = UDim2.new(0, 35, 0, 18)}, 0.1)
                    
                    Tween(ToggleBox, {
                        BackgroundColor3 = Toggle.Value and Library.Theme.Accent or Library.Theme.Tertiary
                    }, 0.2)
                    
                    Tween(ToggleIndicator, {
                        Position = Toggle.Value and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
                    }, 0.2)
                    
                    callback(Toggle.Value)
                end)
                
                return Toggle
            end
            
            -- Add Slider
            function Section:AddSlider(name, min, max, default, callback)
                local Slider = {Value = default}
                
                local SliderFrame = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundTransparency = 1,
                    Parent = ElementContainer
                })
                
                local SliderLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(1, -50, 0, 15),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = SliderFrame
                })
                
                local ValueLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(0, 45, 0, 15),
                    Position = UDim2.new(1, -45, 0, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(default),
                    TextColor3 = Library.Theme.Accent,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = SliderFrame
                })
                
                local SliderBar = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 4),
                    Position = UDim2.new(0, 0, 0, 25),
                    BackgroundColor3 = Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = SliderFrame
                })
                
                local BarCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = SliderBar
                })
                
                local SliderFill = CreateElement("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Library.Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = SliderBar
                })
                
                local FillCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = SliderFill
                })
                
                local SliderButton = CreateElement("TextButton", {
                    Size = UDim2.new(1, 0, 0, 12),
                    Position = UDim2.new(0, 0, 0, 21),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = SliderFrame
                })
                
                local dragging = false
                
                SliderButton.MouseButton1Down:Connect(function()
                    dragging = true
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                SliderButton.MouseMoved:Connect(function(x, y)
                    if dragging then
                        local percentage = math.clamp((x - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        local value = math.floor(min + (max - min) * percentage)
                        
                        Slider.Value = value
                        ValueLabel.Text = tostring(value)
                        
                        -- Smooth fill animation
                        Tween(SliderFill, {
                            Size = UDim2.new(percentage, 0, 1, 0)
                        }, 0.1)
                        
                        callback(value)
                    end
                end)
                
                -- Hover effect on slider
                SliderBar.MouseEnter:Connect(function()
                    Tween(SliderBar, {Size = UDim2.new(1, 0, 0, 6)}, 0.15)
                    Tween(SliderBar, {Position = UDim2.new(0, 0, 0, 24)}, 0.15)
                end)
                
                SliderBar.MouseLeave:Connect(function()
                    if not dragging then
                        Tween(SliderBar, {Size = UDim2.new(1, 0, 0, 4)}, 0.15)
                        Tween(SliderBar, {Position = UDim2.new(0, 0, 0, 25)}, 0.15)
                    end
                end)
                
                return Slider
            end
            
            -- Add Dropdown
            function Section:AddDropdown(name, options, default, callback)
                local Dropdown = {Value = default, Open = false}
                
                local DropdownFrame = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    Parent = ElementContainer,
                    ZIndex = 10
                })
                
                local DropdownLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(0.4, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = DropdownFrame
                })
                
                local DropdownButton = CreateElement("TextButton", {
                    Size = UDim2.new(0.55, 0, 0, 25),
                    Position = UDim2.new(0.45, 0, 0, 2),
                    BackgroundColor3 = Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = default,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false,
                    Parent = DropdownFrame
                })
                
                local ButtonCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(0, 3),
                    Parent = DropdownButton
                })
                
                local OptionsList = CreateElement("Frame", {
                    Size = UDim2.new(0.55, 0, 0, 0),
                    Position = UDim2.new(0.45, 0, 0, 30),
                    BackgroundColor3 = Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 15,
                    Parent = DropdownFrame
                })
                
                local ListCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(0, 3),
                    Parent = OptionsList
                })
                
                local ListLayout = CreateElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 2),
                    Parent = OptionsList
                })
                
                for _, option in pairs(options) do
                    local OptionButton = CreateElement("TextButton", {
                        Size = UDim2.new(1, 0, 0, 22),
                        BackgroundColor3 = Library.Theme.Secondary,
                        BorderSizePixel = 0,
                        Text = option,
                        TextColor3 = Library.Theme.Text,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        AutoButtonColor = false,
                        ZIndex = 16,
                        Parent = OptionsList
                    })
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        Dropdown.Value = option
                        DropdownButton.Text = option
                        OptionsList.Visible = false
                        Dropdown.Open = false
                        callback(option)
                    end)
                    
                    OptionButton.MouseEnter:Connect(function()
                        OptionButton.BackgroundColor3 = Library.Theme.Accent
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        OptionButton.BackgroundColor3 = Library.Theme.Secondary
                    end)
                end
                
                ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    OptionsList.Size = UDim2.new(0.55, 0, 0, math.min(ListLayout.AbsoluteContentSize.Y + 4, 120))
                end)
                
                DropdownButton.MouseButton1Click:Connect(function()
                    Dropdown.Open = not Dropdown.Open
                    OptionsList.Visible = Dropdown.Open
                    
                    if Dropdown.Open then
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 30 + OptionsList.AbsoluteSize.Y + 5)
                    else
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 30)
                    end
                end)
                
                return Dropdown
            end
            
            -- Add Button
            function Section:AddButton(name, callback)
                local ButtonFrame = CreateElement("TextButton", {
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundColor3 = Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false,
                    Parent = ElementContainer
                })
                
                local ButtonCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                    Parent = ButtonFrame
                })
                
                ButtonFrame.MouseButton1Click:Connect(callback)
                
                ButtonFrame.MouseEnter:Connect(function()
                    Tween(ButtonFrame, {BackgroundColor3 = Library.Theme.Accent}, 0.15)
                end)
                
                ButtonFrame.MouseLeave:Connect(function()
                    Tween(ButtonFrame, {BackgroundColor3 = Library.Theme.Tertiary}, 0.15)
                end)
            end
            
            -- Add Color Picker
            function Section:AddColorPicker(name, default, callback)
                local ColorPicker = {Value = default}
                
                local PickerFrame = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 25),
                    BackgroundTransparency = 1,
                    Parent = ElementContainer
                })
                
                local PickerLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(1, -30, 1, 0),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = PickerFrame
                })
                
                local ColorBox = CreateElement("TextButton", {
                    Size = UDim2.new(0, 25, 0, 20),
                    Position = UDim2.new(1, -25, 0.5, -10),
                    BackgroundColor3 = default,
                    BorderSizePixel = 1,
                    BorderColor3 = Library.Theme.Border,
                    Text = "",
                    Parent = PickerFrame
                })
                
                local BoxCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(0, 3),
                    Parent = ColorBox
                })
                
                ColorBox.MouseButton1Click:Connect(function()
                    -- Create color picker popup
                    local Popup = CreateElement("ScreenGui", {
                        Name = "ColorPickerPopup",
                        Parent = game:GetService("CoreGui"),
                        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                    })
                    
                    local PopupFrame = CreateElement("Frame", {
                        Size = UDim2.new(0, 200, 0, 250),
                        Position = UDim2.new(0.5, -100, 0.5, -125),
                        BackgroundColor3 = Library.Theme.Background,
                        BorderSizePixel = 0,
                        Parent = Popup
                    })
                    
                    local PopupCorner = CreateElement("UICorner", {
                        CornerRadius = UDim.new(0, 6),
                        Parent = PopupFrame
                    })
                    
                    local Title = CreateElement("TextLabel", {
                        Size = UDim2.new(1, 0, 0, 30),
                        BackgroundColor3 = Library.Theme.Secondary,
                        Text = name,
                        TextColor3 = Library.Theme.Text,
                        TextSize = 14,
                        Font = Enum.Font.GothamBold,
                        Parent = PopupFrame
                    })
                    
                    local TitleCorner = CreateElement("UICorner", {
                        CornerRadius = UDim.new(0, 6),
                        Parent = Title
                    })
                    
                    -- RGB Sliders
                    local RLabel = CreateElement("TextLabel", {
                        Size = UDim2.new(0.3, 0, 0, 20),
                        Position = UDim2.new(0.05, 0, 0, 40),
                        BackgroundTransparency = 1,
                        Text = "R:",
                        TextColor3 = Library.Theme.Text,
                        TextSize = 12,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = PopupFrame
                    })
                    
                    local RSlider = CreateElement("TextBox", {
                        Size = UDim2.new(0.6, 0, 0, 20),
                        Position = UDim2.new(0.35, 0, 0, 40),
                        BackgroundColor3 = Library.Theme.Tertiary,
                        Text = tostring(math.floor(default.R * 255)),
                        TextColor3 = Library.Theme.Text,
                        TextSize = 12,
                        Font = Enum.Font.Gotham,
                        Parent = PopupFrame
                    })
                    
                    local RCorner = CreateElement("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = RSlider
                    })
                    
                    local GLabel = CreateElement("TextLabel", {
                        Size = UDim2.new(0.3, 0, 0, 20),
                        Position = UDim2.new(0.05, 0, 0, 70),
                        BackgroundTransparency = 1,
                        Text = "G:",
                        TextColor3 = Library.Theme.Text,
                        TextSize = 12,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = PopupFrame
                    })
                    
                    local GSlider = CreateElement("TextBox", {
                        Size = UDim2.new(0.6, 0, 0, 20),
                        Position = UDim2.new(0.35, 0, 0, 70),
                        BackgroundColor3 = Library.Theme.Tertiary,
                        Text = tostring(math.floor(default.G * 255)),
                        TextColor3 = Library.Theme.Text,
                        TextSize = 12,
                        Font = Enum.Font.Gotham,
                        Parent = PopupFrame
                    })
                    
                    local GCorner = CreateElement("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = GSlider
                    })
                    
                    local BLabel = CreateElement("TextLabel", {
                        Size = UDim2.new(0.3, 0, 0, 20),
                        Position = UDim2.new(0.05, 0, 0, 100),
                        BackgroundTransparency = 1,
                        Text = "B:",
                        TextColor3 = Library.Theme.Text,
                        TextSize = 12,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = PopupFrame
                    })
                    
                    local BSlider = CreateElement("TextBox", {
                        Size = UDim2.new(0.6, 0, 0, 20),
                        Position = UDim2.new(0.35, 0, 0, 100),
                        BackgroundColor3 = Library.Theme.Tertiary,
                        Text = tostring(math.floor(default.B * 255)),
                        TextColor3 = Library.Theme.Text,
                        TextSize = 12,
                        Font = Enum.Font.Gotham,
                        Parent = PopupFrame
                    })
                    
                    local BCorner = CreateElement("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = BSlider
                    })
                    
                    -- Preview Box
                    local PreviewBox = CreateElement("Frame", {
                        Size = UDim2.new(0.8, 0, 0, 40),
                        Position = UDim2.new(0.1, 0, 0, 130),
                        BackgroundColor3 = default,
                        Parent = PopupFrame
                    })
                    
                    local PreviewCorner = CreateElement("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = PreviewBox
                    })
                    
                    -- Buttons
                    local ConfirmButton = CreateElement("TextButton", {
                        Size = UDim2.new(0.4, 0, 0, 25),
                        Position = UDim2.new(0.05, 0, 0, 180),
                        BackgroundColor3 = Library.Theme.Accent,
                        Text = "Confirm",
                        TextColor3 = Color3.new(1, 1, 1),
                        TextSize = 12,
                        Font = Enum.Font.GothamBold,
                        Parent = PopupFrame
                    })
                    
                    local ConfirmCorner = CreateElement("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = ConfirmButton
                    })
                    
                    local CancelButton = CreateElement("TextButton", {
                        Size = UDim2.new(0.4, 0, 0, 25),
                        Position = UDim2.new(0.55, 0, 0, 180),
                        BackgroundColor3 = Library.Theme.Secondary,
                        Text = "Cancel",
                        TextColor3 = Library.Theme.Text,
                        TextSize = 12,
                        Font = Enum.Font.GothamBold,
                        Parent = PopupFrame
                    })
                    
                    local CancelCorner = CreateElement("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = CancelButton
                    })
                    
                    -- Update preview when text changes
                    local function updatePreview()
                        local r = tonumber(RSlider.Text) or 0
                        local g = tonumber(GSlider.Text) or 0
                        local b = tonumber(BSlider.Text) or 0
                        
                        r = math.clamp(r, 0, 255)
                        g = math.clamp(g, 0, 255)
                        b = math.clamp(b, 0, 255)
                        
                        PreviewBox.BackgroundColor3 = Color3.fromRGB(r, g, b)
                    end
                    
                    RSlider.FocusLost:Connect(updatePreview)
                    GSlider.FocusLost:Connect(updatePreview)
                    BSlider.FocusLost:Connect(updatePreview)
                    
                    -- Initialize preview
                    updatePreview()
                    
                    ConfirmButton.MouseButton1Click:Connect(function()
                        local r = tonumber(RSlider.Text) or 0
                        local g = tonumber(GSlider.Text) or 0
                        local b = tonumber(BSlider.Text) or 0
                        
                        r = math.clamp(r, 0, 255)
                        g = math.clamp(g, 0, 255)
                        b = math.clamp(b, 0, 255)
                        
                        local newColor = Color3.fromRGB(r, g, b)
                        ColorPicker.Value = newColor
                        ColorBox.BackgroundColor3 = newColor
                        callback(newColor)
                        Popup:Destroy()
                    end)
                    
                    CancelButton.MouseButton1Click:Connect(function()
                        Popup:Destroy()
                    end)
                end)
                
                return ColorPicker
            end
            
            table.insert(Tab.Sections, Section)
            return Section
        end
        
        return Tab
    end
    
    -- Unload function
    function Window:Unload()
        -- Add closing animation
        if MainFrame then
            -- Closing animation
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            local sizeTween = TweenService:Create(MainFrame, tweenInfo, {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundTransparency = 1
            })
            sizeTween:Play()
            
            -- Wait for animation to complete
            wait(0.3)
        end
        
        ScreenGui:Destroy()
    end
    
    -- Config functions
    function Window:SaveConfig(name)
        print("[DummyHook] Config saved: " .. name)
    end
    
    function Window:LoadConfig(name)
        print("[DummyHook] Config loaded: " .. name)
    end
    
    return Window
end

return Library
