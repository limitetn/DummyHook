--[[
    DummyHook Skin Customizer
    Advanced character skin/appearance customization with rainbow effects
]]

local SkinCustomizer = {
    Enabled = false,
    Settings = {
        RainbowBody = false,
        RainbowSpeed = 1,
        BodyColor = Color3.fromRGB(255, 255, 255),
        HeadScale = 1,
        BodyScale = 1,
        Transparency = 0,
        Material = Enum.Material.SmoothPlastic,
        Reflectance = 0,
        TextureID = "",
        OutfitPreset = "Default",
        AccessoryColor = Color3.fromRGB(255, 255, 255),
        AccessoryRainbow = false,
    },
    OriginalValues = {},
    Connections = {}
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

-- Save original appearance
function SkinCustomizer:SaveOriginalAppearance()
    local char = GetCharacter()
    if not char then return end
    
    self.OriginalValues = {}
    
    -- Save body parts
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            self.OriginalValues[part.Name] = {
                Color = part.Color,
                Material = part.Material,
                Reflectance = part.Reflectance,
                Transparency = part.Transparency
            }
        end
    end
    
    -- Save accessories
    for _, acc in pairs(char:GetDescendants()) do
        if acc:IsA("BasePart") and acc:FindFirstAncestorWhichIsA("Accessory") then
            self.OriginalValues[acc.Name .. "_acc"] = {
                Color = acc.Color,
                Material = acc.Material,
                Reflectance = acc.Reflectance,
                Transparency = acc.Transparency
            }
        end
    end
    
    -- Save scales
    local humanoid = GetHumanoid()
    if humanoid then
        local scales = humanoid:FindFirstChild("BodyScales")
        if scales then
            self.OriginalValues.BodyScales = {
                Head = scales.HeadScale.Value,
                Body = scales.BodyDepthScale.Value,
                Width = scales.BodyWidthScale.Value,
                Height = scales.BodyHeightScale.Value
            }
        end
    end
end

-- Restore original appearance
function SkinCustomizer:RestoreAppearance()
    local char = GetCharacter()
    if not char then return end
    
    -- Restore body parts
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") and self.OriginalValues[part.Name] then
            local orig = self.OriginalValues[part.Name]
            part.Color = orig.Color
            part.Material = orig.Material
            part.Reflectance = orig.Reflectance
            part.Transparency = orig.Transparency
        end
    end
    
    -- Restore accessories
    for _, acc in pairs(char:GetDescendants()) do
        if acc:IsA("BasePart") and acc:FindFirstAncestorWhichIsA("Accessory") then
            local orig = self.OriginalValues[acc.Name .. "_acc"]
            if orig then
                acc.Color = orig.Color
                acc.Material = orig.Material
                acc.Reflectance = orig.Reflectance
                acc.Transparency = orig.Transparency
            end
        end
    end
    
    -- Restore scales
    local humanoid = GetHumanoid()
    if humanoid and self.OriginalValues.BodyScales then
        local scales = humanoid:FindFirstChild("BodyScales")
        if scales then
            scales.HeadScale.Value = self.OriginalValues.BodyScales.Head
            scales.BodyDepthScale.Value = self.OriginalValues.BodyScales.Body
            scales.BodyWidthScale.Value = self.OriginalValues.BodyScales.Width
            scales.BodyHeightScale.Value = self.OriginalValues.BodyScales.Height
        end
    end
    
    -- Disconnect rainbow effects
    if self.Connections.RainbowBody then
        self.Connections.RainbowBody:Disconnect()
        self.Connections.RainbowBody = nil
    end
    
    if self.Connections.RainbowAccessories then
        self.Connections.RainbowAccessories:Disconnect()
        self.Connections.RainbowAccessories = nil
    end
end

-- Set body color
function SkinCustomizer:SetBodyColor(color)
    local char = GetCharacter()
    if not char then return end
    
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Color = color
            part.Material = self.Settings.Material
            part.Reflectance = self.Settings.Reflectance
            part.Transparency = self.Settings.Transparency
        end
    end
end

-- Set rainbow body
function SkinCustomizer:SetRainbowBody(enabled)
    self.Settings.RainbowBody = enabled
    
    if enabled then
        if not self.Connections.RainbowBody then
            self.Connections.RainbowBody = RunService.Heartbeat:Connect(function()
                local hue = (tick() * self.Settings.RainbowSpeed) % 1
                local color = Color3.fromHSV(hue, 1, 1)
                self:SetBodyColor(color)
            end)
        end
    else
        if self.Connections.RainbowBody then
            self.Connections.RainbowBody:Disconnect()
            self.Connections.RainbowBody = nil
        end
    end
end

-- Set rainbow accessories
function SkinCustomizer:SetRainbowAccessories(enabled)
    self.Settings.AccessoryRainbow = enabled
    
    if enabled then
        if not self.Connections.RainbowAccessories then
            self.Connections.RainbowAccessories = RunService.Heartbeat:Connect(function()
                local hue = (tick() * self.Settings.RainbowSpeed) % 1
                local color = Color3.fromHSV(hue, 1, 1)
                
                local char = GetCharacter()
                if char then
                    for _, acc in pairs(char:GetDescendants()) do
                        if acc:IsA("BasePart") and acc:FindFirstAncestorWhichIsA("Accessory") then
                            acc.Color = color
                            acc.Material = self.Settings.Material
                            acc.Reflectance = self.Settings.Reflectance
                        end
                    end
                end
            end)
        end
    else
        if self.Connections.RainbowAccessories then
            self.Connections.RainbowAccessories:Disconnect()
            self.Connections.RainbowAccessories = nil
        end
    end
end

-- Set character scale
function SkinCustomizer:SetCharacterScale(headScale, bodyScale)
    self.Settings.HeadScale = headScale
    self.Settings.BodyScale = bodyScale
    
    local humanoid = GetHumanoid()
    if not humanoid then return end
    
    local scales = humanoid:FindFirstChild("BodyScales")
    if not scales then
        scales = Instance.new("Folder")
        scales.Name = "BodyScales"
        scales.Parent = humanoid
        
        -- Create scale values
        local headScaleValue = Instance.new("NumberValue")
        headScaleValue.Name = "HeadScale"
        headScaleValue.Value = 1
        headScaleValue.Parent = scales
        
        local bodyDepthScale = Instance.new("NumberValue")
        bodyDepthScale.Name = "BodyDepthScale"
        bodyDepthScale.Value = 1
        bodyDepthScale.Parent = scales
        
        local bodyWidthScale = Instance.new("NumberValue")
        bodyWidthScale.Name = "BodyWidthScale"
        bodyWidthScale.Value = 1
        bodyWidthScale.Parent = scales
        
        local bodyHeightScale = Instance.new("NumberValue")
        bodyHeightScale.Name = "BodyHeightScale"
        bodyHeightScale.Value = 1
        bodyHeightScale.Parent = scales
    end
    
    -- Apply scales
    scales.HeadScale.Value = headScale
    scales.BodyDepthScale.Value = bodyScale
    scales.BodyWidthScale.Value = bodyScale
    scales.BodyHeightScale.Value = bodyScale
end

-- Set material
function SkinCustomizer:SetMaterial(material)
    self.Settings.Material = material
    
    local char = GetCharacter()
    if not char then return end
    
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Material = material
        end
    end
end

-- Set reflectance
function SkinCustomizer:SetReflectance(value)
    self.Settings.Reflectance = value
    
    local char = GetCharacter()
    if not char then return end
    
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Reflectance = value
        end
    end
end

-- Set transparency
function SkinCustomizer:SetTransparency(value)
    self.Settings.Transparency = value
    
    local char = GetCharacter()
    if not char then return end
    
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = value
        end
    end
end

-- Apply texture
function SkinCustomizer:SetTexture(textureID)
    self.Settings.TextureID = textureID
    
    local char = GetCharacter()
    if not char then return end
    
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            -- Remove existing textures
            for _, decal in pairs(part:GetChildren()) do
                if decal:IsA("Decal") or decal:IsA("Texture") then
                    decal:Destroy()
                end
            end
            
            -- Apply new texture if ID provided
            if textureID ~= "" then
                local texture = Instance.new("Texture")
                texture.Texture = textureID
                texture.Face = Enum.NormalId.Front
                texture.Parent = part
            end
        end
    end
end

-- Outfit presets
SkinCustomizer.OutfitPresets = {
    ["Default"] = {
        Color = Color3.fromRGB(255, 255, 255),
        Material = Enum.Material.SmoothPlastic,
        Reflectance = 0
    },
    
    ["Neon"] = {
        Color = Color3.fromRGB(255, 255, 255),
        Material = Enum.Material.Neon,
        Reflectance = 0
    },
    
    ["Glass"] = {
        Color = Color3.fromRGB(200, 230, 255),
        Material = Enum.Material.Glass,
        Reflectance = 0.3
    },
    
    ["ForceField"] = {
        Color = Color3.fromRGB(100, 200, 255),
        Material = Enum.Material.ForceField,
        Reflectance = 0.1
    },
    
    ["Wood"] = {
        Color = Color3.fromRGB(150, 100, 50),
        Material = Enum.Material.Wood,
        Reflectance = 0.1
    },
    
    ["Metal"] = {
        Color = Color3.fromRGB(200, 200, 200),
        Material = Enum.Material.Metal,
        Reflectance = 0.4
    },
    
    ["DiamondPlate"] = {
        Color = Color3.fromRGB(220, 220, 220),
        Material = Enum.Material.DiamondPlate,
        Reflectance = 0.2
    }
}

function SkinCustomizer:SetOutfitPreset(presetName)
    self.Settings.OutfitPreset = presetName
    local preset = self.OutfitPresets[presetName]
    
    if preset then
        self.Settings.BodyColor = preset.Color
        self.Settings.Material = preset.Material
        self.Settings.Reflectance = preset.Reflectance
        
        self:SetBodyColor(preset.Color)
        self:SetMaterial(preset.Material)
        self:SetReflectance(preset.Reflectance)
    end
end

-- Cleanup
function SkinCustomizer:Cleanup()
    self:RestoreAppearance()
    self.Connections = {}
end

return SkinCustomizer
