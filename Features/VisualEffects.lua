--[[
    DummyHook Visual Effects Manager
    RGB particles, glow effects, trails, and visual customization
]]

local VisualEffects = {
    Enabled = false,
    Settings = {
        RGBTrail = false,
        GlowEffect = false,
        Particles = false,
        ParticleType = "Stars",
        TrailColor = Color3.fromRGB(130, 195, 65),
        GlowColor = Color3.fromRGB(130, 195, 65),
        ParticleColor = Color3.fromRGB(255, 255, 255),
        RGBSpeed = 1,
        EffectIntensity = 1,
    },
    Connections = {},
    EffectObjects = {}
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoidRootPart()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- RGB Trail Effect
function VisualEffects:CreateRGBTrail()
    local hrp = GetHumanoidRootPart()
    if not hrp then return end
    
    -- Remove existing trail
    if self.EffectObjects.Trail then
        self.EffectObjects.Trail:Destroy()
    end
    
    -- Create attachment points
    local att0 = Instance.new("Attachment")
    att0.Name = "TrailAttachment0"
    att0.Parent = hrp
    
    local att1 = Instance.new("Attachment")
    att1.Name = "TrailAttachment1"
    att1.Parent = hrp
    att1.Position = Vector3.new(0, -2, 0)
    
    -- Create trail
    local trail = Instance.new("Trail")
    trail.Name = "DummyHookTrail"
    trail.Attachment0 = att0
    trail.Attachment1 = att1
    trail.Lifetime = 1
    trail.MinLength = 0
    trail.FaceCamera = true
    trail.WidthScale = NumberSequence.new(1, 0)
    trail.Transparency = NumberSequence.new(0, 1)
    trail.Color = ColorSequence.new(self.Settings.TrailColor)
    trail.Parent = hrp
    
    self.EffectObjects.Trail = trail
    self.EffectObjects.TrailAtt0 = att0
    self.EffectObjects.TrailAtt1 = att1
    
    -- RGB animation
    if self.Settings.RGBTrail then
        self.Connections.TrailRGB = RunService.Heartbeat:Connect(function()
            local hue = (tick() * self.Settings.RGBSpeed * 50) % 360
            local color = Color3.fromHSV(hue / 360, 1, 1)
            trail.Color = ColorSequence.new(color)
        end)
    end
end

-- Glow Effect (Highlight-based)
function VisualEffects:CreateGlowEffect()
    local char = GetCharacter()
    if not char then return end
    
    -- Remove existing glow
    if self.EffectObjects.Glow then
        self.EffectObjects.Glow:Destroy()
    end
    
    -- Create highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "DummyHookGlow"
    highlight.Adornee = char
    highlight.FillColor = self.Settings.GlowColor
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = self.Settings.GlowColor
    highlight.OutlineTransparency = 0
    highlight.Parent = char
    
    self.EffectObjects.Glow = highlight
    
    -- RGB animation
    if self.Settings.RGBTrail then
        self.Connections.GlowRGB = RunService.Heartbeat:Connect(function()
            local hue = (tick() * self.Settings.RGBSpeed * 50) % 360
            local color = Color3.fromHSV(hue / 360, 1, 1)
            highlight.FillColor = color
            highlight.OutlineColor = color
        end)
    end
end

-- Particle Effects
function VisualEffects:CreateParticles()
    local hrp = GetHumanoidRootPart()
    if not hrp then return end
    
    -- Remove existing particles
    if self.EffectObjects.Particles then
        self.EffectObjects.Particles:Destroy()
    end
    
    -- Create particle emitter
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "DummyHookParticles"
    
    -- Configure based on type
    if self.Settings.ParticleType == "Stars" then
        particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particles.Rate = 50
        particles.Lifetime = NumberRange.new(1, 2)
        particles.Speed = NumberRange.new(2, 5)
        particles.SpreadAngle = Vector2.new(180, 180)
        particles.Size = NumberSequence.new(0.5, 0)
        particles.Transparency = NumberSequence.new(0, 1)
        particles.LightEmission = 1
        
    elseif self.Settings.ParticleType == "Sparkles" then
        particles.Texture = "rbxasset://textures/particles/smoke_main.dds"
        particles.Rate = 100
        particles.Lifetime = NumberRange.new(0.5, 1)
        particles.Speed = NumberRange.new(1, 3)
        particles.SpreadAngle = Vector2.new(360, 360)
        particles.Size = NumberSequence.new(0.3, 0)
        particles.Transparency = NumberSequence.new(0, 1)
        particles.LightEmission = 1
        
    elseif self.Settings.ParticleType == "Fire" then
        particles.Texture = "rbxasset://textures/particles/fire_main.dds"
        particles.Rate = 75
        particles.Lifetime = NumberRange.new(1, 1.5)
        particles.Speed = NumberRange.new(0, 2)
        particles.SpreadAngle = Vector2.new(25, 25)
        particles.Size = NumberSequence.new(1, 0)
        particles.Transparency = NumberSequence.new(0, 1)
        particles.LightEmission = 0.8
        
    elseif self.Settings.ParticleType == "Magic" then
        particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particles.Rate = 80
        particles.Lifetime = NumberRange.new(2, 3)
        particles.Speed = NumberRange.new(1, 4)
        particles.Rotation = NumberRange.new(0, 360)
        particles.RotSpeed = NumberRange.new(-100, 100)
        particles.SpreadAngle = Vector2.new(360, 360)
        particles.Size = NumberSequence.new(0.8, 0)
        particles.Transparency = NumberSequence.new(0, 1)
        particles.LightEmission = 1
    end
    
    particles.Color = ColorSequence.new(self.Settings.ParticleColor)
    particles.Parent = hrp
    
    self.EffectObjects.Particles = particles
    
    -- RGB animation
    if self.Settings.RGBTrail then
        self.Connections.ParticleRGB = RunService.Heartbeat:Connect(function()
            local hue = (tick() * self.Settings.RGBSpeed * 50) % 360
            local color = Color3.fromHSV(hue / 360, 1, 1)
            particles.Color = ColorSequence.new(color)
        end)
    end
end

-- Point Light Effect
function VisualEffects:CreatePointLight()
    local hrp = GetHumanoidRootPart()
    if not hrp then return end
    
    if self.EffectObjects.Light then
        self.EffectObjects.Light:Destroy()
    end
    
    local light = Instance.new("PointLight")
    light.Name = "DummyHookLight"
    light.Brightness = 2 * self.Settings.EffectIntensity
    light.Range = 20 * self.Settings.EffectIntensity
    light.Color = self.Settings.GlowColor
    light.Parent = hrp
    
    self.EffectObjects.Light = light
    
    -- RGB animation
    if self.Settings.RGBTrail then
        self.Connections.LightRGB = RunService.Heartbeat:Connect(function()
            local hue = (tick() * self.Settings.RGBSpeed * 50) % 360
            local color = Color3.fromHSV(hue / 360, 1, 1)
            light.Color = color
        end)
    end
end

-- Enable/Disable Functions
function VisualEffects:SetRGBTrail(value)
    self.Settings.RGBTrail = value
    
    if value then
        self:CreateRGBTrail()
    else
        if self.EffectObjects.Trail then
            self.EffectObjects.Trail:Destroy()
            self.EffectObjects.TrailAtt0:Destroy()
            self.EffectObjects.TrailAtt1:Destroy()
        end
        if self.Connections.TrailRGB then
            self.Connections.TrailRGB:Disconnect()
        end
    end
end

function VisualEffects:SetGlowEffect(value)
    self.Settings.GlowEffect = value
    
    if value then
        self:CreateGlowEffect()
    else
        if self.EffectObjects.Glow then
            self.EffectObjects.Glow:Destroy()
        end
        if self.Connections.GlowRGB then
            self.Connections.GlowRGB:Disconnect()
        end
    end
end

function VisualEffects:SetParticles(value)
    self.Settings.Particles = value
    
    if value then
        self:CreateParticles()
    else
        if self.EffectObjects.Particles then
            self.EffectObjects.Particles:Destroy()
        end
        if self.Connections.ParticleRGB then
            self.Connections.ParticleRGB:Disconnect()
        end
    end
end

function VisualEffects:SetPointLight(value)
    if value then
        self:CreatePointLight()
    else
        if self.EffectObjects.Light then
            self.EffectObjects.Light:Destroy()
        end
        if self.Connections.LightRGB then
            self.Connections.LightRGB:Disconnect()
        end
    end
end

function VisualEffects:SetParticleType(value)
    self.Settings.ParticleType = value
    if self.Settings.Particles then
        self:CreateParticles()
    end
end

function VisualEffects:SetRGBSpeed(value)
    self.Settings.RGBSpeed = value
end

function VisualEffects:SetEffectIntensity(value)
    self.Settings.EffectIntensity = value
end

-- Setter functions for UI elements
function VisualEffects:SetChams(value)
    self.Settings.Chams = value
    if value then
        self:CreateChams()
    else
        self:RemoveChams()
    end
end

function VisualEffects:SetVisibleChams(value)
    self.Settings.VisibleChams = value
    -- Refresh chams if enabled
    if self.Settings.Chams then
        self:CreateChams()
    end
end

function VisualEffects:SetOccludedChams(value)
    self.Settings.OccludedChams = value
    -- Refresh chams if enabled
    if self.Settings.Chams then
        self:CreateChams()
    end
end

function VisualEffects:SetGlow(value)
    self.Settings.Glow = value
    if value then
        self:CreateGlowEffect()
    else
        -- Remove glow effect
        if self.EffectObjects.Glow then
            self.EffectObjects.Glow:Destroy()
            self.EffectObjects.Glow = nil
        end
    end
end

-- Cleanup
function VisualEffects:Cleanup()
    for _, obj in pairs(self.EffectObjects) do
        if obj then
            obj:Destroy()
        end
    end
    
    for _, conn in pairs(self.Connections) do
        if conn then
            conn:Disconnect()
        end
    end
    
    self.EffectObjects = {}
    self.Connections = {}
end

return VisualEffects
