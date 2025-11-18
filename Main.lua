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

    -- Config Tab