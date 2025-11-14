--[[
    DummyHook Character Customizer
    Change your character's appearance
]]

local CharCustomizer = {
    OriginalAppearance = {},
    Connections = {},
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Save original appearance
local function SaveOriginalAppearance()
    local character = LocalPlayer.Character
    if not character then return end
    
    CharCustomizer.OriginalAppearance = {
        BodyColors = {},
        Clothing = {},
    }
    
    -- Save body colors
    local bodyColors = character:FindFirstChildOfClass("BodyColors")
    if bodyColors then
        CharCustomizer.OriginalAppearance.BodyColors = {
            HeadColor = bodyColors.HeadColor,
            TorsoColor = bodyColors.TorsoColor,
            LeftArmColor = bodyColors.LeftArmColor,
            RightArmColor = bodyColors.RightArmColor,
            LeftLegColor = bodyColors.LeftLegColor,
            RightLegColor = bodyColors.RightLegColor,
        }
    end
end

-- Change body color
function CharCustomizer:SetBodyColor(color)
    local character = LocalPlayer.Character
    if not character then return end
    
    local bodyColors = character:FindFirstChildOfClass("BodyColors")
    if not bodyColors then
        bodyColors = Instance.new("BodyColors")
        bodyColors.Parent = character
    end
    
    bodyColors.HeadColor3 = color
    bodyColors.TorsoColor3 = color
    bodyColors.LeftArmColor3 = color
    bodyColors.RightArmColor3 = color
    bodyColors.LeftLegColor3 = color
    bodyColors.RightLegColor3 = color
    
    print("[CharCustomizer] Body color changed")
end

-- Rainbow body
function CharCustomizer:SetRainbowBody(enabled)
    if self.Connections.Rainbow then
        self.Connections.Rainbow:Disconnect()
        self.Connections.Rainbow = nil
    end
    
    if enabled then
        local RunService = game:GetService("RunService")
        self.Connections.Rainbow = RunService.Heartbeat:Connect(function()
            local hue = (tick() % 5) / 5
            local color = Color3.fromHSV(hue, 1, 1)
            self:SetBodyColor(color)
        end)
    end
end

-- Change shirt
function CharCustomizer:SetShirt(shirtID)
    local character = LocalPlayer.Character
    if not character then return end
    
    local shirt = character:FindFirstChildOfClass("Shirt")
    if not shirt then
        shirt = Instance.new("Shirt")
        shirt.Parent = character
    end
    
    shirt.ShirtTemplate = "rbxassetid://" .. tostring(shirtID)
    print("[CharCustomizer] Shirt changed to ID: " .. shirtID)
end

-- Change pants
function CharCustomizer:SetPants(pantsID)
    local character = LocalPlayer.Character
    if not character then return end
    
    local pants = character:FindFirstChildOfClass("Pants")
    if not pants then
        pants = Instance.new("Pants")
        pants.Parent = character
    end
    
    pants.PantsTemplate = "rbxassetid://" .. tostring(pantsID)
    print("[CharCustomizer] Pants changed to ID: " .. pantsID)
end

-- Remove all accessories
function CharCustomizer:RemoveAccessories()
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, accessory in pairs(character:GetChildren()) do
        if accessory:IsA("Accessory") then
            accessory:Destroy()
        end
    end
    
    print("[CharCustomizer] All accessories removed")
end

-- Naked (remove all clothing)
function CharCustomizer:SetNaked()
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
            item:Destroy()
        end
    end
    
    print("[CharCustomizer] Clothing removed")
end

-- Set character scale
function CharCustomizer:SetScale(scale)
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    -- Modern way: Use HumanoidDescription
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        pcall(function()
            if humanoid:FindFirstChild("BodyDepthScale") then
                humanoid.BodyDepthScale.Value = scale
                humanoid.BodyHeightScale.Value = scale
                humanoid.BodyWidthScale.Value = scale
                humanoid.HeadScale.Value = scale
            end
        end)
    end
    
    print("[CharCustomizer] Character scaled to: " .. scale)
end

-- Big head mode
function CharCustomizer:SetBigHead(enabled)
    local character = LocalPlayer.Character
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    if enabled then
        head.Size = Vector3.new(5, 5, 5)
        local mesh = head:FindFirstChildOfClass("SpecialMesh")
        if mesh then
            mesh.Scale = Vector3.new(2, 2, 2)
        end
    else
        head.Size = Vector3.new(2, 1, 1)
        local mesh = head:FindFirstChildOfClass("SpecialMesh")
        if mesh then
            mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
        end
    end
    
    print("[CharCustomizer] Big head: " .. tostring(enabled))
end

-- Invisible character
function CharCustomizer:SetInvisible(enabled)
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            if part.Name ~= "HumanoidRootPart" then
                part.Transparency = enabled and 1 or 0
            end
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = enabled and 1 or 0
        end
    end
    
    print("[CharCustomizer] Invisible: " .. tostring(enabled))
end

-- Restore original appearance
function CharCustomizer:RestoreAppearance()
    if not CharCustomizer.OriginalAppearance.BodyColors then
        SaveOriginalAppearance()
        return
    end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    -- Restore body colors
    local bodyColors = character:FindFirstChildOfClass("BodyColors")
    if bodyColors and CharCustomizer.OriginalAppearance.BodyColors then
        local orig = CharCustomizer.OriginalAppearance.BodyColors
        bodyColors.HeadColor = orig.HeadColor
        bodyColors.TorsoColor = orig.TorsoColor
        bodyColors.LeftArmColor = orig.LeftArmColor
        bodyColors.RightArmColor = orig.RightArmColor
        bodyColors.LeftLegColor = orig.LeftLegColor
        bodyColors.RightLegColor = orig.RightLegColor
    end
    
    print("[CharCustomizer] Original appearance restored")
end

-- Initialize
SaveOriginalAppearance()

-- Cleanup
function CharCustomizer:Cleanup()
    for _, connection in pairs(self.Connections) do
        connection:Disconnect()
    end
    self.Connections = {}
end

return CharCustomizer
