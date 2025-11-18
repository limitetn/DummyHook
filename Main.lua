-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/UI/Library.lua"))()

-- Create Window
local Window = Library:CreateWindow({
    Title = "DummyHook - Sniper Duels Edition",
    Theme = "Skeet",
    Size = UDim2.new(0, 580, 0, 460),
    KeyBind = Enum.KeyCode.RightShift
})

-- Create Sniper Duels Tab
local SniperDuelsTab = Window:CreateTab("Sniper Duels")

-- Create specialized section for Sniper Duels
local SniperDuelsSpecializedSection = SniperDuelsTab:CreateSection("Sniper Duels Specialized")

-- Add Sniper Duels specific buttons
SniperDuelsSpecializedSection:AddButton("Dupe All Skins (x1)", function()
    if SniperDuels then
        local skins = SniperDuels:GetDetectedSkins()
        for _, skinName in ipairs(skins) do
            SniperDuels:DupeSkin(skinName, 1)
            wait(0.1)
        end
        Notifications:Success("Sniper Duels", "Duped all skins!", 3)
    end
end)

-- Free Currency Generation
SniperDuelsSpecializedSection:AddButton("Generate Free Currency", function()
    if SniperDuels then
        SniperDuels:GenerateFreeCurrency(1000000)
        Notifications:Success("Sniper Duels", "Generated 1,000,000 free currency!", 3)
    end
end)

-- Case Opening Section
local CaseOpeningSection = SniperDuelsTab:CreateSection("Case Opening")
CaseOpeningSection:AddToggle("Auto Open Cases", false, function(state)
    if SniperDuels then
        SniperDuels.Settings.AutoOpenCases = state
        SniperDuels:SetAutoOpenCases(state)
    end
end)

CaseOpeningSection:AddSlider("Case Open Speed", 1, 1, 10, 1, function(value)
    if SniperDuels then
        SniperDuels.Settings.CaseOpenSpeed = value
    end
end)

-- Updated case names to match Sniper Duels actual case identifiers
local caseNames = {
    "Release",           -- Release Case
    "Halloween2025",     -- Hallows Basket
    "Beta",
    "Alpha", 
    "Omega"
}

CaseOpeningSection:AddDropdown("Open Specific Case", caseNames, function(caseName)
    if SniperDuels then
        SniperDuels:OpenCase(caseName)
        Notifications:Success("Sniper Duels", "Opening " .. caseName .. " case!", 3)
    end
end)

-- Config Tab