--[[
    DummyHook Theme Manager
    Advanced theming system with presets, RGB effects, and customization
]]

local ThemeManager = {
    CurrentTheme = "Skeet",
    CustomTheme = nil,
    RGBEnabled = false,
    RGBSpeed = 1,
    Themes = {}
}

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Predefined Theme Presets
ThemeManager.Themes = {
    ["Skeet"] = {
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
    },
    
    ["Aimware"] = {
        Background = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(28, 28, 32),
        Tertiary = Color3.fromRGB(35, 35, 40),
        Accent = Color3.fromRGB(255, 100, 100),
        AccentDark = Color3.fromRGB(220, 70, 70),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(170, 170, 170),
        Border = Color3.fromRGB(50, 50, 55),
        Success = Color3.fromRGB(100, 255, 100),
        Error = Color3.fromRGB(255, 60, 60),
    },
    
    ["Synapse"] = {
        Background = Color3.fromRGB(25, 25, 30),
        Secondary = Color3.fromRGB(32, 32, 37),
        Tertiary = Color3.fromRGB(40, 40, 45),
        Accent = Color3.fromRGB(90, 180, 255),
        AccentDark = Color3.fromRGB(60, 150, 230),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 185),
        Border = Color3.fromRGB(55, 55, 60),
        Success = Color3.fromRGB(80, 255, 120),
        Error = Color3.fromRGB(255, 80, 100),
    },
    
    ["Midnight"] = {
        Background = Color3.fromRGB(10, 10, 15),
        Secondary = Color3.fromRGB(15, 15, 20),
        Tertiary = Color3.fromRGB(20, 20, 28),
        Accent = Color3.fromRGB(120, 80, 255),
        AccentDark = Color3.fromRGB(90, 60, 220),
        Text = Color3.fromRGB(240, 240, 250),
        TextDark = Color3.fromRGB(160, 160, 180),
        Border = Color3.fromRGB(40, 35, 50),
        Success = Color3.fromRGB(120, 255, 180),
        Error = Color3.fromRGB(255, 100, 120),
    },
    
    ["Ocean"] = {
        Background = Color3.fromRGB(15, 25, 35),
        Secondary = Color3.fromRGB(20, 35, 45),
        Tertiary = Color3.fromRGB(25, 45, 55),
        Accent = Color3.fromRGB(50, 200, 255),
        AccentDark = Color3.fromRGB(30, 170, 230),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 200, 210),
        Border = Color3.fromRGB(40, 70, 90),
        Success = Color3.fromRGB(100, 255, 200),
        Error = Color3.fromRGB(255, 100, 130),
    },
    
    ["Neon Pink"] = {
        Background = Color3.fromRGB(20, 10, 20),
        Secondary = Color3.fromRGB(30, 15, 30),
        Tertiary = Color3.fromRGB(40, 20, 40),
        Accent = Color3.fromRGB(255, 50, 200),
        AccentDark = Color3.fromRGB(220, 30, 170),
        Text = Color3.fromRGB(255, 240, 255),
        TextDark = Color3.fromRGB(200, 180, 200),
        Border = Color3.fromRGB(60, 40, 60),
        Success = Color3.fromRGB(200, 255, 200),
        Error = Color3.fromRGB(255, 80, 80),
    },
    
    ["Hacker Green"] = {
        Background = Color3.fromRGB(5, 15, 5),
        Secondary = Color3.fromRGB(10, 20, 10),
        Tertiary = Color3.fromRGB(15, 28, 15),
        Accent = Color3.fromRGB(0, 255, 100),
        AccentDark = Color3.fromRGB(0, 220, 80),
        Text = Color3.fromRGB(200, 255, 200),
        TextDark = Color3.fromRGB(150, 200, 150),
        Border = Color3.fromRGB(30, 50, 30),
        Success = Color3.fromRGB(100, 255, 150),
        Error = Color3.fromRGB(255, 100, 100),
    },
    
    ["Crimson"] = {
        Background = Color3.fromRGB(20, 5, 5),
        Secondary = Color3.fromRGB(30, 10, 10),
        Tertiary = Color3.fromRGB(40, 15, 15),
        Accent = Color3.fromRGB(255, 50, 50),
        AccentDark = Color3.fromRGB(220, 30, 30),
        Text = Color3.fromRGB(255, 240, 240),
        TextDark = Color3.fromRGB(200, 180, 180),
        Border = Color3.fromRGB(60, 30, 30),
        Success = Color3.fromRGB(150, 255, 150),
        Error = Color3.fromRGB(255, 80, 80),
    },
    
    ["Gold"] = {
        Background = Color3.fromRGB(20, 18, 10),
        Secondary = Color3.fromRGB(28, 25, 15),
        Tertiary = Color3.fromRGB(35, 32, 20),
        Accent = Color3.fromRGB(255, 215, 0),
        AccentDark = Color3.fromRGB(220, 180, 0),
        Text = Color3.fromRGB(255, 250, 230),
        TextDark = Color3.fromRGB(200, 190, 170),
        Border = Color3.fromRGB(60, 55, 40),
        Success = Color3.fromRGB(150, 255, 100),
        Error = Color3.fromRGB(255, 100, 100),
    },
    
    ["Cyberpunk"] = {
        Background = Color3.fromRGB(15, 15, 25),
        Secondary = Color3.fromRGB(20, 20, 35),
        Tertiary = Color3.fromRGB(28, 28, 45),
        Accent = Color3.fromRGB(255, 0, 150),
        AccentDark = Color3.fromRGB(220, 0, 130),
        Text = Color3.fromRGB(0, 255, 255),
        TextDark = Color3.fromRGB(150, 200, 200),
        Border = Color3.fromRGB(100, 0, 150),
        Success = Color3.fromRGB(0, 255, 200),
        Error = Color3.fromRGB(255, 50, 100),
    }
}

-- RGB Rainbow effect
function ThemeManager:StartRGBMode()
    if self.RGBConnection then return end
    
    self.RGBEnabled = true
    self.RGBConnection = RunService.Heartbeat:Connect(function()
        local hue = (tick() * self.RGBSpeed * 50) % 360
        local color = Color3.fromHSV(hue / 360, 1, 1)
        
        -- Update accent color with rainbow
        if self.OnThemeUpdate then
            self.OnThemeUpdate("Accent", color)
        end
    end)
end

function ThemeManager:StopRGBMode()
    if self.RGBConnection then
        self.RGBConnection:Disconnect()
        self.RGBConnection = nil
    end
    self.RGBEnabled = false
end

function ThemeManager:SetRGBSpeed(speed)
    self.RGBSpeed = speed
end

-- Apply theme
function ThemeManager:ApplyTheme(themeName)
    if not self.Themes[themeName] then
        warn("[ThemeManager] Theme not found: " .. themeName)
        return false
    end
    
    self.CurrentTheme = themeName
    local theme = self.Themes[themeName]
    
    -- Trigger theme update callback
    if self.OnThemeChange then
        self.OnThemeChange(theme)
    end
    
    return true
end

-- Create custom theme
function ThemeManager:CreateCustomTheme(name, colors)
    self.Themes[name] = colors
    return true
end

-- Get current theme
function ThemeManager:GetCurrentTheme()
    return self.Themes[self.CurrentTheme]
end

-- Get all theme names
function ThemeManager:GetThemeNames()
    local names = {}
    for name, _ in pairs(self.Themes) do
        table.insert(names, name)
    end
    return names
end

-- Export theme to string
function ThemeManager:ExportTheme(themeName)
    local theme = self.Themes[themeName]
    if not theme then return nil end
    
    local export = "{"
    for key, color in pairs(theme) do
        export = export .. string.format('["%s"]=Color3.fromRGB(%d,%d,%d),', 
            key, color.R * 255, color.G * 255, color.B * 255)
    end
    export = export .. "}"
    
    return export
end

-- Import theme from string
function ThemeManager:ImportTheme(name, themeString)
    local success, theme = pcall(function()
        -- Use load instead of loadstring for Lua 5.4 compatibility
        return load("return " .. themeString)()
    end)
    
    if success and theme then
        self.Themes[name] = theme
        return true
    end
    
    return false
end

return ThemeManager
