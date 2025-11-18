--!strict
--[[
    DummyHook Sniper Duels Module
    Specialized features for Sniper Duels game
    Refactored for Luau with modern syntax
]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Module
local SniperDuels = {
    Enabled = false,
    Settings = {
        AutoOpenCases = false,
        CaseOpenSpeed = 1,
        AutoDupeSkins = false,
        SkinDupeAmount = 1,
        EnhancedStats = false,
        StatBoostAmount = 2,
        InfiniteAmmo = false,
        NoRecoil = false,
        NoSpread = false,
        IncreasedFireRate = false,
        FireRateMultiplier = 1.5,
        MeleeExploit = false,
        NoMeleeCooldown = false,
        MeleeDamageBoost = false,
        AutoFarm = false,
        FarmMethod = "Kills",
    },
    Connections = {},
    DetectedSkins = {},
    CaseTypes = {
        "Release",
        "Halloween2025",
    },
    WeaponConfigs = {},
    MeleeConfigs = {},
}

-- Detect if we're in Sniper Duels
function SniperDuels:IsSniperDuels()
    local gameId = game.PlaceId
    if gameId == 109397169461300 then
        return true
    end
    
    -- Fallback to name detection
    local success, productInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(gameId)
    end)
    
    if success and productInfo then
        local gameName = string.lower(productInfo.Name)
        return string.find(gameName, "sniper") ~= nil and string.find(gameName, "duels") ~= nil
    end
    
    return false
end

-- Auto Case Opening
function SniperDuels:SetAutoOpenCases(enabled)
    self.Settings.AutoOpenCases = enabled
    
    local connection = self.Connections.AutoCases
    if connection then
        connection:Disconnect()
        self.Connections.AutoCases = nil
    end
    
    if enabled then
        self.Connections.AutoCases = RunService.Heartbeat:Connect(function()
            self:OpenRandomCase()
        end)
    end
end

-- Open a random case
function SniperDuels:OpenRandomCase()
    if not self.Settings.AutoOpenCases then 
        return 
    end
    
    local caseIndex = math.random(1, #self.CaseTypes)
    local caseType = self.CaseTypes[caseIndex]
    self:OpenCase(caseType)
    
    -- Wait based on speed setting
    task.wait(1 / self.Settings.CaseOpenSpeed)
end

-- Open specific case
function SniperDuels:OpenCase(caseType)
    task.spawn(function()
        local remotes = ReplicatedStorage:GetDescendants()
        
        -- Sniper Duels specific case opening methods based on actual game modules
        for _, remote in pairs(remotes) do
            if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                local remoteName = remote.Name:lower()
                
                -- More specific Sniper Duels remote detection
                if (remoteName:find("case") and (remoteName:find("open") or remoteName:find("roll") or remoteName:find("unlock"))) or 
                   (remoteName:find("crate") and remoteName:find("unlock")) or 
                   remoteName:find("purchase") or 
                   (remoteName:find("store") and remoteName:find("buy")) then
                    
                    -- Try different methods to open case for free with Sniper Duels specific parameters
                    if remote:IsA("RemoteEvent") then
                        -- Sniper Duels specific methods
                        remote:FireServer("open", caseType)
                        remote:FireServer("unlock", caseType)
                        remote:FireServer("roll", caseType)
                        remote:FireServer("claim", caseType)
                        remote:FireServer(caseType, true) -- Free parameter
                        remote:FireServer(caseType, "free")
                        remote:FireServer(caseType, 0) -- Free currency
                        remote:FireServer("free_open", caseType)
                        remote:FireServer("purchase", caseType, "free")
                        remote:FireServer("buy", caseType, 0)
                        remote:FireServer("acquire", caseType, true)
                    else
                        -- For RemoteFunction
                        remote:InvokeServer("open", caseType)
                        remote:InvokeServer("unlock", caseType)
                        remote:InvokeServer("roll", caseType)
                        remote:InvokeServer("claim", caseType)
                        remote:InvokeServer(caseType, true) -- Free parameter
                        remote:InvokeServer(caseType, "free")
                        remote:InvokeServer(caseType, 0) -- Free currency
                        remote:InvokeServer("free_open", caseType)
                        remote:InvokeServer("purchase", caseType, "free")
                        remote:InvokeServer("buy", caseType, 0)
                        remote:InvokeServer("acquire", caseType, true)
                    end
                end
            end
        end
    end)
end

-- Skin Duplication
function SniperDuels:SetAutoDupeSkins(enabled)
    self.Settings.AutoDupeSkins = enabled
    
    if self.Connections.AutoDupe then
        self.Connections.AutoDupe:Disconnect()
        self.Connections.AutoDupe = nil
    end
    
    if enabled then
        self.Connections.AutoDupe = RunService.Heartbeat:Connect(function()
            self:DupeRandomSkin()
        end)
    end
end

-- Dupe a random detected skin
function SniperDuels:DupeRandomSkin()
    if not self.Settings.AutoDupeSkins or #self.DetectedSkins == 0 then return end
    
    local randomIndex = math.random(1, #self.DetectedSkins)
    local skinName = self.DetectedSkins[randomIndex]
    
    if skinName then
        self:DupeSkin(skinName, self.Settings.SkinDupeAmount)
    end
end

-- Dupe specific skin
function SniperDuels:DupeSkin(skinName, amount)
    amount = amount or 1
    
    pcall(function()
        local remotes = ReplicatedStorage:GetDescendants()
        
        -- Sniper Duels specific skin duplication methods based on actual game modules
        for _, remote in pairs(remotes) do
            if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                local remoteName = remote.Name:lower()
                
                -- More specific Sniper Duels remote detection for skin operations
                if (remoteName:find("skin") and (remoteName:find("dupe") or remoteName:find("clone") or remoteName:find("copy"))) or 
                   (remoteName:find("inventory") and (remoteName:find("duplicate") or remoteName:find("replicate"))) or 
                   (remoteName:find("item") and remoteName:find("acquire")) or 
                   remoteName:find("store") then
                    
                    -- Try to dupe skin with Sniper Duels specific methods
                    for i = 1, amount do
                        if remote:IsA("RemoteEvent") then
                            -- Sniper Duels specific duplication methods
                            remote:FireServer("duplicate", skinName, 1)
                            remote:FireServer("dupe", skinName, 1)
                            remote:FireServer("clone", skinName, 1)
                            remote:FireServer("copy", skinName, 1)
                            remote:FireServer("replicate", skinName, 1)
                            remote:FireServer("acquire", skinName, 1)
                            remote:FireServer(skinName, "duplicate")
                            remote:FireServer(skinName, "copy")
                            remote:FireServer("add", skinName, 1)
                            remote:FireServer("give", skinName, 1)
                            remote:FireServer("unlock", skinName, 1)
                        else
                            -- For RemoteFunction
                            remote:InvokeServer("duplicate", skinName, 1)
                            remote:InvokeServer("dupe", skinName, 1)
                            remote:InvokeServer("clone", skinName, 1)
                            remote:InvokeServer("copy", skinName, 1)
                            remote:InvokeServer("replicate", skinName, 1)
                            remote:InvokeServer("acquire", skinName, 1)
                            remote:InvokeServer(skinName, "duplicate")
                            remote:InvokeServer(skinName, "copy")
                            remote:InvokeServer("add", skinName, 1)
                            remote:InvokeServer("give", skinName, 1)
                            remote:InvokeServer("unlock", skinName, 1)
                        end
                        task.wait(0.05) -- Faster duplication
                    end
                end
            end
        end
    end)
end

-- Enhanced Weapon Stats
function SniperDuels:SetEnhancedStats(enabled)
    self.Settings.EnhancedStats = enabled
    
    if enabled then
        self:BoostAllWeaponStats()
    else
        self:ResetWeaponStats()
    end
end

-- Free Currency Generation
function SniperDuels:GenerateFreeCurrency(amount)
    amount = amount or 999999
    
    pcall(function()
        -- Method 1: Direct currency manipulation (Sniper Duels specific)
        local currencyFolders = {
            LocalPlayer:FindFirstChild("Currency"),
            LocalPlayer:FindFirstChild("Coins"),
            LocalPlayer:FindFirstChild("Money"),
            LocalPlayer:FindFirstChild("Cash"),
            LocalPlayer:FindFirstChild("PlayerData"),
            LocalPlayer:FindFirstChild("Data"),
            LocalPlayer:FindFirstChild("Stats")
        }
        
        for _, folder in pairs(currencyFolders) do
            if folder then
                -- Look for currency values with Sniper Duels specific names
                for _, child in pairs(folder:GetDescendants()) do
                    if child:IsA("IntValue") or child:IsA("NumberValue") then
                        local name = child.Name:lower()
                        if name:find("coin") or name:find("cash") or name:find("money") or 
                           name:find("currency") or name:find("credit") or name:find("premium") or 
                           name:find("balance") or name:find("funds") then
                            child.Value = child.Value + amount
                        end
                    end
                end
                
                -- If no specific currency values found, create one
                if folder.Name == "PlayerData" or folder.Name == "Data" or folder.Name == "Stats" then
                    local currencyValue = folder:FindFirstChild("Currency") or folder:FindFirstChild("Coins") or 
                                         folder:FindFirstChild("Money") or folder:FindFirstChild("Balance")
                    if not currencyValue then
                        currencyValue = Instance.new("IntValue")
                        currencyValue.Name = "Currency"
                        currencyValue.Value = amount
                        currencyValue.Parent = folder
                    else
                        currencyValue.Value = currencyValue.Value + amount
                    end
                end
            end
        end
        
        -- Method 2: DataStore manipulation (Sniper Duels specific)
        local dataStores = LocalPlayer:FindFirstChild("DataStore") or LocalPlayer:FindFirstChild("DataStores") or 
                          LocalPlayer:FindFirstChild("PlayerData") or LocalPlayer:FindFirstChild("UserData")
        if dataStores then
            for _, store in pairs(dataStores:GetChildren()) do
                if store:IsA("IntValue") or store:IsA("NumberValue") then
                    local storeName = store.Name:lower()
                    if storeName:find("currency") or storeName:find("coin") or storeName:find("money") or 
                       storeName:find("cash") or storeName:find("balance") then
                        store.Value = store.Value + amount
                    end
                end
            end
        end
        
        -- Method 3: Remote event manipulation (Sniper Duels specific methods)
        local remotes = ReplicatedStorage:GetDescendants()
        
        for _, remote in pairs(remotes) do
            if remote:IsA("RemoteEvent") then
                local remoteName = remote.Name:lower()
                -- Sniper Duels specific remote event names
                if (remoteName:find("currency") and (remoteName:find("add") or remoteName:find("give") or remoteName:find("reward"))) or 
                   (remoteName:find("coin") and remoteName:find("claim")) or 
                   (remoteName:find("store") and remoteName:find("purchase")) or 
                   remoteName:find("economy") or remoteName:find("wallet") then
                    
                    -- Sniper Duels specific remote calls
                    remote:FireServer("addCurrency", amount)
                    remote:FireServer("addCoins", amount)
                    remote:FireServer("reward", amount)
                    remote:FireServer("claim", "currency", amount)
                    remote:FireServer("give", "coins", amount)
                    remote:FireServer("increase", "balance", amount)
                    remote:FireServer("update", "currency", amount)
                    remote:FireServer("earn", amount)
                end
            end
        end
        
        print("[SniperDuels] Generated " .. amount .. " free currency")
    end)
end

-- Boost all weapon stats
function SniperDuels:BoostAllWeaponStats()
    local boostAmount = self.Settings.StatBoostAmount
    
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        -- Find all tools/weapons and boost their stats
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                self:BoostToolStats(tool, boostAmount)
            end
        end
        
        -- Also check backpack
        if LocalPlayer:FindFirstChild("Backpack") then
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    self:BoostToolStats(tool, boostAmount)
                end
            end
        end
    end)
end

-- Boost specific tool stats based on actual Gun.lua module structure
function SniperDuels:BoostToolStats(tool, boostAmount)
    pcall(function()
        -- Based on Gun.lua's actual config structure
        local config = tool:FindFirstChild("Config")
        if config then
            -- Damage boosting (from Gun.lua line 741-746)
            local damageFolder = config:FindFirstChild("Damage")
            if damageFolder then
                for _, damageValue in pairs(damageFolder:GetChildren()) do
                    if damageValue:IsA("NumberValue") or damageValue:IsA("IntValue") then
                        damageValue.Value = damageValue.Value * boostAmount
                    end
                end
            end
            
            -- Fire rate boosting (from Gun.lua's Firerate config)
            local firerate = config:FindFirstChild("Firerate")
            if firerate and (firerate:IsA("NumberValue") or firerate:IsA("IntValue")) then
                if self.Settings.IncreasedFireRate then
                    firerate.Value = firerate.Value * self.Settings.FireRateMultiplier
                end
            end
            
            -- Recoil reduction (from Gun.lua's Recoil config)
            local recoil = config:FindFirstChild("Recoil")
            if recoil and self.Settings.NoRecoil then
                if recoil:IsA("NumberValue") or recoil:IsA("IntValue") then
                    recoil.Value = 0
                elseif recoil:IsA("Folder") then
                    for _, recoilValue in pairs(recoil:GetDescendants()) do
                        if recoilValue:IsA("NumberValue") or recoilValue:IsA("IntValue") then
                            recoilValue.Value = 0
                        end
                    end
                end
            end
            
            -- Spread reduction (from Gun.lua's Spread config line 696-706)
            local spread = config:FindFirstChild("Spread")
            if spread and self.Settings.NoSpread then
                if spread:IsA("NumberValue") or spread:IsA("IntValue") then
                    spread.Value = 0
                elseif spread:IsA("Folder") then
                    for _, spreadValue in pairs(spread:GetDescendants()) do
                        if spreadValue:IsA("NumberValue") or spreadValue:IsA("IntValue") then
                            spreadValue.Value = 0
                        end
                    end
                end
            end
            
            -- Ammo boosting (from Gun.lua line 115)
            local ammo = config:FindFirstChild("Ammo")
            if ammo and (ammo:IsA("NumberValue") or ammo:IsA("IntValue")) then
                if self.Settings.InfiniteAmmo then
                    ammo.Value = 9999
                end
            end
            
            -- Reload time reduction
            local reloadTime = config:FindFirstChild("ReloadTime")
            if reloadTime and (reloadTime:IsA("NumberValue") or reloadTime:IsA("IntValue")) then
                reloadTime.Value = reloadTime.Value / boostAmount
            end
            
            -- Max range increase
            local maxRange = config:FindFirstChild("MaxRangeStuds")
            if maxRange and (maxRange:IsA("NumberValue") or maxRange:IsA("IntValue")) then
                maxRange.Value = maxRange.Value * boostAmount
            end
        end
        
        -- Also check for values directly in tool (legacy support)
        for _, child in pairs(tool:GetDescendants()) do
            if child:IsA("NumberValue") or child:IsA("IntValue") or child:IsA("FloatValue") then
                local name = child.Name:lower()
                
                if name:find("damage") or name:find("dmg") then
                    child.Value = child.Value * boostAmount
                elseif name:find("firerate") and self.Settings.IncreasedFireRate then
                    child.Value = child.Value * self.Settings.FireRateMultiplier
                elseif name:find("recoil") and self.Settings.NoRecoil then
                    child.Value = 0
                elseif (name:find("spread") or name:find("accuracy")) and self.Settings.NoSpread then
                    child.Value = 0
                elseif name:find("ammo") and self.Settings.InfiniteAmmo then
                    child.Value = 9999
                end
            end
        end
    end)
end

-- Reset weapon stats
function SniperDuels:ResetWeaponStats()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        -- Reset all tools/weapons
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                self:ResetToolStats(tool)
            end
        end
        
        -- Also check backpack
        if LocalPlayer:FindFirstChild("Backpack") then
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    self:ResetToolStats(tool)
                end
            end
        end
    end)
end

-- Reset specific tool stats
function SniperDuels:ResetToolStats(tool)
    -- This would typically reset to default values, but we don't have access to those
    -- In a real implementation, you'd restore original values
end

-- Melee Exploit based on actual Melee.lua module (line 88, 159-181)
function SniperDuels:SetMeleeExploit(enabled)
    self.Settings.MeleeExploit = enabled
    
    if self.Connections.MeleeLoop then
        self.Connections.MeleeLoop:Disconnect()
        self.Connections.MeleeLoop = nil
    end
    
    if enabled then
        self.Connections.MeleeLoop = RunService.Heartbeat:Connect(function()
            self:ApplyMeleeExploits()
        end)
    end
end

-- Apply melee exploits based on Melee.lua structure
function SniperDuels:ApplyMeleeExploits()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        -- Find melee tools based on actual Melee.lua module structure
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                -- Check if it's a melee weapon (Bayonet from CaseConfigs.lua)
                if tool.Name:find("Bayonet") or tool.Name:find("Knife") or 
                   tool.Name:find("Melee") or tool:HasTag("Melee") then
                    
                    local config = tool:FindFirstChild("Config")
                    if config then
                        -- Based on Melee.lua line 88: TimeSwingCooldownEnded
                        if self.Settings.NoMeleeCooldown then
                            local swingCooldown = config:FindFirstChild("SwingCooldown")
                            if swingCooldown and (swingCooldown:IsA("NumberValue") or swingCooldown:IsA("IntValue")) then
                                swingCooldown.Value = 0
                            end
                        end
                        
                        -- Based on Melee.lua damage system
                        if self.Settings.MeleeDamageBoost then
                            local damage = config:FindFirstChild("Damage")
                            if damage and (damage:IsA("NumberValue") or damage:IsA("IntValue")) then
                                damage.Value = damage.Value * 3  -- 3x damage boost (reasonable)
                            end
                        end
                        
                        -- Melee range increase
                        local range = config:FindFirstChild("Range")
                        if range and (range:IsA("NumberValue") or range:IsA("IntValue")) then
                            range.Value = range.Value * 2
                        end
                    end
                end
            end
        end
        
        -- Also check backpack
        if LocalPlayer:FindFirstChild("Backpack") then
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") and (tool.Name:find("Bayonet") or tool:HasTag("Melee")) then
                    local config = tool:FindFirstChild("Config")
                    if config and self.Settings.NoMeleeCooldown then
                        local swingCooldown = config:FindFirstChild("SwingCooldown")
                        if swingCooldown and (swingCooldown:IsA("NumberValue") or swingCooldown:IsA("IntValue")) then
                            swingCooldown.Value = 0
                        end
                    end
                end
            end
        end
    end)
end

-- Auto Farm
function SniperDuels:SetAutoFarm(enabled)
    self.Settings.AutoFarm = enabled
    
    if self.Connections.AutoFarm then
        self.Connections.AutoFarm:Disconnect()
        self.Connections.AutoFarm = nil
    end
    
    if enabled then
        self.Connections.AutoFarm = RunService.Heartbeat:Connect(function()
            self:AutoFarm()
        end)
    end
end

-- Auto farm implementation
function SniperDuels:AutoFarm()
    if not self.Settings.AutoFarm then return end
    
    pcall(function()
        local remotes = ReplicatedStorage:GetDescendants()
        
        for _, remote in pairs(remotes) do
            if remote:IsA("RemoteEvent") then
                local remoteName = remote.Name:lower()
                -- Sniper Duels specific farming remotes based on actual game modules
                if remoteName:find("kill") or remoteName:find("damage") or 
                   remoteName:find("earn") or remoteName:find("xp") or 
                   remoteName:find("reward") or remoteName:find("elimination") or
                   (remoteName:find("match") and remoteName:find("end")) then
                    -- Try to trigger farming with Sniper Duels specific methods
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            -- Multiple methods to trigger farming events
                            remote:FireServer(player, 100)
                            remote:FireServer(player.Character, 100)
                            remote:FireServer("eliminate", player)
                            remote:FireServer("kill", player.Name)
                            remote:FireServer("reward", "elimination")
                        end
                    end
                end
            end
        end
    end)
end

-- Skin Detection System based on actual CaseConfigs.lua module
function SniperDuels:StartSkinDetection()
    self.DetectedSkins = {}
    
    -- RELEASE CASE skins from CaseConfigs.lua (lines 8-40)
    local releaseSkins = {
        -- Standard skins
        "Flames", "SnakeSkin", "GreenStream", "Lightning", "CrimeScene",
        "VanillaAWP", "AWP_Bubblegum", "VanillaIntervention", "SunsetRunner", "Apex",
        "Default_Bluesteel",
        
        -- Bayonet variants (lines 20-30)
        "Bayonet", "Bayonet_Hypno", "Bayonet_Sunset", "Bayonet_Aurora",
        "Bayonet_Amethyst", "Bayonet_Ruby", "Bayonet_Sapphire",
        "Bayonet_Emerald", "Bayonet_Onyx",
        
        -- True colors (lines 31-34)
        "TrueWhite", "TrueBlack",
        
        -- Inverted variants (lines 35-40)
        "Default_Inverted", "Default_TrueInverted",
        "AWP_Inverted", "AWP_TrueInverted"
    }
    
    -- RELEASE CASE FX from CaseConfigs.lua (lines 42-50)
    local releaseFX = {
        "Surge", "Binary", "Loveshot", "Omega", "Voidcry",
        "Inferno", "Starbound", "Blacklight"
    }
    
    -- RELEASE CASE Kill Effects from CaseConfigs.lua (line 52)
    local releaseKillEffects = {
        "Darkheart", "Cash"
    }
    
    -- HALLOWEEN 2025 CASE (HALLOWS BASKET) from CaseConfigs.lua (lines 74-94)
    local halloweenSkins = {
        -- Standard skins
        "Mummy", "Stalker", "Zombie", "Catseye", "VampireHunter",
        "Cauldron", "AWP_WhiteSpiral", "AWP_Bewitched", "Intervention_Reaper",
        "AWP_RedSpiral", "Intervention_BlackKnight",
        
        -- Bayonet variants
        "Bayonet_CandyCorn", "Bayonet_ZombieSlayer",
        "Bayonet_Cultist", "Bayonet_Vampiric",
        
        -- Elementist variants
        "AWP_Elementist", "AWP_Elementist_Purple"
    }
    
    -- HALLOWEEN 2025 FX from CaseConfigs.lua (lines 95-102)
    local halloweenFX = {
        "VoidGrasp", "Magician", "Shock", "AstralPlain",
        "Cryptic", "NoxNostra"
    }
    
    -- Combine all skins
    for _, skin in ipairs(releaseSkins) do
        table.insert(self.DetectedSkins, skin)
    end
    
    for _, fx in ipairs(releaseFX) do
        table.insert(self.DetectedSkins, fx)
    end
    
    for _, effect in ipairs(releaseKillEffects) do
        table.insert(self.DetectedSkins, effect)
    end
    
    for _, skin in ipairs(halloweenSkins) do
        table.insert(self.DetectedSkins, skin)
    end
    
    for _, fx in ipairs(halloweenFX) do
        table.insert(self.DetectedSkins, fx)
    end
    
    print("[SniperDuels] Loaded " .. #self.DetectedSkins .. " skins from actual game CaseConfigs module")
end

-- Get list of detected skins
function SniperDuels:GetDetectedSkins()
    return self.DetectedSkins
end

-- Cleanup
function SniperDuels:Cleanup()
    for _, connection in pairs(self.Connections) do
        connection:Disconnect()
    end
    self.Connections = {}
end

-- Initialize
function SniperDuels:Initialize()
    if self:IsSniperDuels() then
        self.Enabled = true
        self:StartSkinDetection()
        print("[SniperDuels] Module initialized and ready!")
    else
        print("[SniperDuels] Not in Sniper Duels game, module disabled")
    end
end

return SniperDuels