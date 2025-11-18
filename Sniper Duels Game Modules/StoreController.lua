-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TextService")
local v_u_4 = game:GetService("MarketplaceService")
local v_u_5 = game:GetService("SoundService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("RunService")
local v_u_8 = require(v_u_2.Modules.Controllers.UIController)
local v_u_9 = require(v_u_2.Modules.Configs.ShopOffers)
local v_u_10 = require(v_u_2.Modules.Configs.CaseConfigs)
local v_u_11 = require(v_u_2.Modules.Main.ClientData)
local v_u_12 = require(v_u_2.Modules.Shared.Skins)
require(v_u_2.Modules.Configs.SkinConfig)
local v_u_13 = game:GetService("Players").LocalPlayer
local v_u_14 = { "Halloween2025", "Release" }
local v_u_15 = {}
local v_u_16 = nil
local function v_u_20(p17)
	local v18 = tostring(p17)
	repeat
		local v19
		v18, v19 = string.gsub(v18, "^(-?%d+)(%d%d%d)", "%1,%2")
	until v19 == 0
	return v18
end
local v_u_21 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 109, 111)), ColorSequenceKeypoint.new(0.27, Color3.fromRGB(234, 31, 49)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 21, 37)) })
local v_u_22 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 198, 234)), ColorSequenceKeypoint.new(0.27, Color3.fromRGB(86, 153, 234)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 83, 138)) })
function v_u_1.CreateRobuxButton(_, p_u_23)
	-- upvalues: (copy) v_u_2, (copy) v_u_20, (copy) v_u_3, (copy) v_u_8, (copy) v_u_5, (copy) v_u_4, (copy) v_u_13
	local v24 = v_u_2.Assets.UI._Templates.Store.RobuxButton:Clone()
	local v25 = v24.Contents.mName.mText
	local v26 = p_u_23.Name
	v25.Text = v26
	local v27 = v25.Parent:FindFirstChild(v25.Name .. "BG")
	if v27 then
		v27.Text = v26
	end
	local v28 = v24.Contents.Price.Robux.Amount.mText
	local v29 = v_u_20(p_u_23.RobuxPrice)
	v28.Text = v29
	local v30 = v28.Parent:FindFirstChild(v28.Name .. "BG")
	if v30 then
		v30.Text = v29
	end
	v24.Contents.ImageLabel.Image = p_u_23.ImageID
	v24.UIGradient.Color = p_u_23.BackgroundColorGradient
	if p_u_23.RedText then
		v24.Contents.Bonus.Text = p_u_23.RedText
		v24.Contents.Bonus.Size = UDim2.fromOffset(5 + v_u_3:GetTextSize(p_u_23.RedText, v24.Contents.Bonus.TextSize, v24.Contents.Bonus.Font, Vector2.new(1000, v24.Contents.Bonus.Size.Y.Offset)).X, v24.Contents.Bonus.Size.Y.Offset)
		v24.Contents.Bonus.Visible = true
	end
	v_u_8:InitializeButton(v24.Gift, function()
		-- upvalues: (ref) v_u_5, (ref) v_u_8, (copy) p_u_23, (ref) v_u_2, (ref) v_u_4, (ref) v_u_13
		v_u_5.Game.Local.Menu.UI.ButtonClickIn:Play()
		v_u_8:CloseAllTabs()
		local v31 = v_u_8
		local v32 = {
			["Title"] = "SEND A GIFT",
			["ModalSpecific"] = {
				["Icon"] = p_u_23.ImageID,
				["Price"] = p_u_23.RobuxPrice,
				["Name"] = p_u_23.Name
			}
		}
		v31:Modal("GIFTPLAYER", v32, function(p33)
			-- upvalues: (ref) v_u_2, (ref) v_u_8, (ref) v_u_4, (ref) v_u_13, (ref) p_u_23
			if p33 then
				if v_u_2.Remotes.Other.SetPlayerToGift:InvokeServer(p33) then
					v_u_4:PromptProductPurchase(v_u_13, p_u_23.ProductID)
				else
					v_u_8:ErrorText("Unknown error.")
				end
			else
				v_u_8:ChangeTab("Store", true)
				return
			end
		end)
	end, true, 1.025)
	v_u_8:InitializeButton(v24, function()
		-- upvalues: (ref) v_u_5, (ref) v_u_2, (ref) v_u_8, (ref) v_u_4, (ref) v_u_13, (copy) p_u_23
		v_u_5.Game.Local.Menu.UI.ButtonClickIn:Play()
		if v_u_2.Remotes.Other.SetPlayerToGift:InvokeServer("Nobody") then
			v_u_4:PromptProductPurchase(v_u_13, p_u_23.ProductID)
		else
			v_u_8:ErrorText("Unknown error.")
		end
	end, true, 1.1, nil, v24.Contents.ImageLabel)
	return v24
end
local v_u_38 = {
	["Color"] = function(p34, p35)
		p34.UIStroke.Color = p35 and Color3.fromRGB(235, 237, 244) or Color3.fromRGB(36, 36, 36)
		p34.UIStroke.Thickness = p35 and 3 or 2
	end,
	["Default"] = function(p36, p37)
		p36.SelectedStroke.Enabled = p37
	end
}
local v_u_51 = {
	["ColorTween"] = function(p39, p40)
		-- upvalues: (copy) v_u_8, (copy) v_u_6
		local v41 = v_u_8.MenuUI.Store.Bottom.Premium[p39]
		local v42 = v41.Variants[p40]
		v_u_6:Create(v41, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			["ImageColor3"] = v42:GetAttribute("BG_Color") or Color3.new(1, 1, 1)
		}):Play()
	end,
	["FadeImages"] = function(p43, p44)
		-- upvalues: (copy) v_u_8, (copy) v_u_6
		local v45 = v_u_8.MenuUI.Store.Bottom.Premium[p43]
		local v46 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		for _, v47 in pairs(v45:GetChildren()) do
			if v47:IsA("ImageLabel") then
				local v48 = v47.Name
				if string.sub(v48, 1, 3) == "BG_" then
					local v49 = v47.Name
					local v50 = string.sub(v49, 4, -1) == p44
					v_u_6:Create(v47, v46, {
						["ImageTransparency"] = v50 and (v47:GetAttribute("ImageTransparency") or 0) or 1,
						["BackgroundTransparency"] = v50 and 0 or 1
					}):Play()
				end
			end
		end
	end
}
function v_u_1.Init()
	-- upvalues: (copy) v_u_8, (ref) v_u_16, (copy) v_u_9, (copy) v_u_10, (copy) v_u_2, (ref) v_u_15, (copy) v_u_20, (copy) v_u_11, (copy) v_u_14, (copy) v_u_1, (copy) v_u_21, (copy) v_u_22, (copy) v_u_5, (copy) v_u_38, (copy) v_u_51, (copy) v_u_4, (copy) v_u_13, (copy) v_u_12, (copy) v_u_7
	local v_u_52 = nil
	local v53 = v_u_8.MenuUI.Store.Bottom
	local v54 = v53.Premium
	local v_u_55 = v53.Store
	local v_u_56 = v53.ViewCase
	v_u_16 = v_u_8:BindCategories({ v_u_8.MenuUI.Store.Top.Buttons.Store, v_u_8.MenuUI.Store.Top.Buttons.Premium }, { v_u_55, v54 }, function(p57)
		-- upvalues: (copy) v_u_56, (ref) v_u_52
		v_u_56.Visible = false
		if v_u_52 then
			task.cancel(v_u_52)
			v_u_52 = nil
		end
		local _ = p57 == "Premium"
	end)
	for _, v_u_58 in pairs(v_u_9.CaseOffers) do
		local v59 = v_u_10[v_u_58]
		if v59 then
			local v60
			if v59.IsLimitedTimeUntil and v59.IsLimitedTimeUntil ~= -1 then
				if v59.IsLimitedTimeUntil - os.time() >= 0 then
					v60 = true
					goto l6
				end
			else
				v60 = false
				::l6::
				local v61 = v_u_2.Assets.UI._Templates.Store.Case:Clone()
				if v60 then
					v61.CaseContents.Limited.Visible = true
					local v62 = v_u_15
					table.insert(v62, v61)
				end
				v61.CaseContents.New.Visible = v59.IsNew
				local v63 = v61.CaseContents.mName.mText
				local v64 = v59.NiceName
				v63.Text = v64
				local v65 = v63.Parent:FindFirstChild(v63.Name .. "BG")
				if v65 then
					v65.Text = v64
				end
				v61.CaseContents.Icon.Image = v59.ImageID
				if v59.BGColor then
					v61.BackgroundColor3 = v59.BGColor
				end
				if v59.CanBeBoughtWithFreeCurrency then
					v61.CaseContents.Price.Coins.Visible = true
					v61.CaseContents.Price.Coins.Amount.Text = v_u_20(v59.FreeCurrencyPrice)
				else
					v61.CaseContents.Price.Coins.Visible = false
				end
				if v59.CanBeBoughtWithPremiumCurrency and (not v_u_11.PolicyInfo.ArePaidRandomItemsRestricted and v_u_11.PolicyInfo.IsPaidItemTradingAllowed) then
					v61.CaseContents.Price.Premium.Visible = true
					v61.CaseContents.Price.Premium.Amount.Text = v_u_20(v59.PremiumCurrencyPrice)
				else
					v61.CaseContents.Price.Premium.Visible = false
				end
				v61.LayoutOrder = table.find(v_u_14, v_u_58) or 0
				v_u_8:InitializeButton(v61, function()
					-- upvalues: (ref) v_u_1, (copy) v_u_58, (ref) v_u_8
					v_u_1.SelectedCaseName = v_u_58
					v_u_8:ViewCase(v_u_8.MenuUI.Store.Bottom.ViewCase, v_u_58)
					v_u_8.MenuUI.Store.Bottom.Store.Visible = false
				end, true, 1.1, nil, v61.CaseContents.Icon)
				v61.Name = v_u_58
				v61.Parent = v_u_55.ContentsHolder.Contents
			end
		else
			warn("CRITICAL: StoreController::Couldn\'t find case config for case " .. v_u_58)
		end
	end
	if v_u_11.PolicyInfo.ArePaidRandomItemsRestricted or not v_u_11.PolicyInfo.IsPaidItemTradingAllowed then
		v54.PremiumCurrencyHolder.Policy.Visible = true
		v54.PremiumCurrencyHolder.PremiumCurrencyHolder.Visible = false
	else
		for _, v66 in pairs(v_u_9.RobuxOffers.PremiumCurrencyOffers) do
			local v67 = v_u_1
			local v68 = {
				["ProductID"] = v66.ProductID,
				["BackgroundColorGradient"] = v_u_21
			}
			local v69 = v66.Amount
			v68.Name = tostring(v69) .. " PREMIUM"
			v68.RobuxPrice = v66.RobuxPrice
			v68.ImageID = v66.ImageID
			v68.RedText = v66.RedText
			v67:CreateRobuxButton(v68).Parent = v54.PremiumCurrencyHolder.PremiumCurrencyHolder
		end
	end
	for _, v70 in pairs(v_u_9.RobuxOffers.XPBoostOffers) do
		local v71 = v_u_1
		local v72 = {
			["ProductID"] = v70.ProductID,
			["BackgroundColorGradient"] = v_u_22
		}
		local v73 = v70.Multiplier
		local v74 = tostring(v73)
		local v75 = "x XP - "
		local v76 = string.upper
		local v77 = v70.TimeSeconds
		local v78
		if v77 < 60 then
			v78 = tostring(v77) .. " second" .. (v77 > 1 and "s" or "")
		else
			local v79 = v77 / 60
			local v80 = math.floor(v79)
			if v80 > 59 then
				local v81 = v80 / 60
				local v82 = math.floor(v81)
				v78 = v82 .. " hour" .. (v82 > 1 and "s" or "")
			else
				v78 = v80 .. " minute" .. (v80 > 1 and "s" or "")
			end
		end
		v72.Name = v74 .. v75 .. v76(v78)
		v72.RobuxPrice = v70.RobuxPrice
		v72.ImageID = v70.ImageID
		v72.RedText = v70.RedText
		v71:CreateRobuxButton(v72).Parent = v54.LuckIncreaseHolder
	end
	local function v_u_85(p83)
		-- upvalues: (ref) v_u_5, (ref) v_u_8
		v_u_5.Game.Local.Menu.UI.Purchase:Play()
		v_u_8:Modal("PURCHASE_SUCCESSFUL", {
			["Title"] = "ITEM PURCHASED",
			["Description"] = ("You have successfuly purchased %*. You can view it in your ITEMS."):format(p83.NiceName),
			["Icon"] = p83.ImageID
		}, function(p84)
			-- upvalues: (ref) v_u_8
			if p84 then
				v_u_8:ChangeTab("Inventory", true)
			end
		end)
	end
	local function v_u_90(p86, p87)
		-- upvalues: (ref) v_u_2, (ref) v_u_1, (copy) v_u_85, (ref) v_u_8
		local v88, v89 = v_u_2.Remotes.PlayerData.Store.Purchase:InvokeServer(p86, "Case", v_u_1.SelectedCaseName)
		if v88 then
			v_u_85(p87)
		elseif v89 then
			v_u_8:Modal("OK", {
				["Title"] = "ERROR",
				["Description"] = v89
			})
		end
	end
	v_u_8:InitializeButton(v_u_56.Buttons.PurchaseCoins, function()
		-- upvalues: (ref) v_u_1, (ref) v_u_8, (ref) v_u_10, (ref) v_u_11, (ref) v_u_16, (copy) v_u_90
		if v_u_1.SelectedCaseName then
			local v91 = v_u_10[v_u_1.SelectedCaseName]
			if v91 then
				if v91.CanBeBoughtWithFreeCurrency then
					if v_u_11.Data.Currency < v91.FreeCurrencyPrice then
						v_u_16(2)
					else
						v_u_90("Free", v91)
					end
				else
					v_u_8:Modal("OK", {
						["Title"] = "ERROR",
						["Description"] = "This purchase method is not allowed."
					})
					return
				end
			else
				v_u_8:Modal("OK", {
					["Title"] = "ERROR",
					["Description"] = "No case to purchase found. 0x2"
				})
				return
			end
		else
			v_u_8:Modal("OK", {
				["Title"] = "ERROR",
				["Description"] = "No case to purchase found. 0x1"
			})
			return
		end
	end, false, 5)
	v_u_8:InitializeButton(v_u_56.Buttons.PurchasePremium, function()
		-- upvalues: (ref) v_u_1, (ref) v_u_8, (ref) v_u_10, (ref) v_u_11, (ref) v_u_16, (copy) v_u_90
		if v_u_1.SelectedCaseName then
			local v92 = v_u_10[v_u_1.SelectedCaseName]
			if v92 then
				if v92.CanBeBoughtWithPremiumCurrency then
					if v_u_11.Data.PremiumCurrency < v92.PremiumCurrencyPrice then
						v_u_16(2)
					else
						v_u_90("Premium", v92)
					end
				else
					v_u_8:Modal("OK", {
						["Title"] = "ERROR",
						["Description"] = "This purchase method is not allowed."
					})
					return
				end
			else
				v_u_8:Modal("OK", {
					["Title"] = "ERROR",
					["Description"] = "No case to purchase found. 0x2"
				})
				return
			end
		else
			v_u_8:Modal("OK", {
				["Title"] = "ERROR",
				["Description"] = "No case to purchase found. 0x1"
			})
			return
		end
	end, false, 5)
	v_u_8:InitializeButton(v_u_8.MenuUI.Store.Top.CurrencyHolder.Buy, function()
		-- upvalues: (ref) v_u_16
		v_u_16(2)
	end, false)
	if v_u_2.Variables.SvExclusiveItemSold.Value then
		for v_u_93, v_u_94 in pairs(v_u_9.ExclusiveOffers) do
			local v_u_95 = v54:FindFirstChild(v_u_93)
			if v_u_95 then
				local v_u_96 = v_u_94.Variants[1]
				local v_u_97 = v_u_38[v_u_94.VariantsButtonStyle]
				local v_u_98 = v_u_51[v_u_94.BackgroundStyle]
				local v_u_99 = {}
				for v100, v_u_101 in pairs(v_u_94.Items) do
					local v102 = v_u_95.Items:FindFirstChild(v100)
					if v102 then
						v_u_8:InitializeButton(v102, function()
							-- upvalues: (copy) v_u_101, (ref) v_u_96, (ref) v_u_8, (ref) v_u_4, (ref) v_u_13
							local v103 = v_u_101.Variants[v_u_96]
							if not v103 then
								v_u_8:ErrorText("Variant not available.")
							end
							v_u_4:PromptProductPurchase(v_u_13, v103.ProductID)
						end, true, 1.1, nil, v102.Icon)
						table.insert(v_u_99, v102)
					end
				end
				for _, v_u_104 in pairs(v_u_94.Variants) do
					local v_u_105 = v_u_95.Variants:FindFirstChild(v_u_104)
					if v_u_105 then
						if v_u_104 == v_u_96 then
							v_u_97(v_u_105, true)
						end
						v_u_8:InitializeButton(v_u_105, function()
							-- upvalues: (copy) v_u_97, (copy) v_u_95, (ref) v_u_96, (copy) v_u_105, (copy) v_u_99, (copy) v_u_94, (copy) v_u_104, (copy) v_u_98, (copy) v_u_93
							v_u_97(v_u_95.Variants[v_u_96], false)
							v_u_97(v_u_105, true)
							for _, v106 in pairs(v_u_99) do
								local v107 = v_u_94.Items[v106.Name].Variants[v_u_104].ImageID
								v106.Icon.Image = v107
							end
							v_u_98(v_u_93, v_u_104)
							v_u_96 = v_u_104
						end, true, 1.05)
					end
				end
			end
		end
	else
		for v108, _ in pairs(v_u_9.ExclusiveOffers) do
			local v109 = v54:FindFirstChild(v108)
			if v109 then
				v109.Visible = false
			end
		end
	end
	for _, v110 in pairs(v_u_8.LobbyUI.BottomLeft:GetChildren()) do
		if v110:GetAttribute("JumpToCases") then
			local v111 = v110:FindFirstChildWhichIsA("GuiButton")
			if v111 then
				v_u_8:InitializeButton(v111, function()
					-- upvalues: (ref) v_u_8, (ref) v_u_16
					v_u_8:ChangeTab("Store")
					v_u_16(1)
				end, false, 0)
			end
		end
	end
	v_u_8:InitializeButton(v_u_56.LeftSideInfo.Back, function()
		-- upvalues: (copy) v_u_56, (copy) v_u_55
		v_u_56.Visible = false
		v_u_55.Visible = true
	end, false, 5)
	v_u_4.PromptProductPurchaseFinished:Connect(function(_, p112, p113)
		-- upvalues: (ref) v_u_9, (ref) v_u_12, (ref) v_u_5, (ref) v_u_8
		if not p113 then
			return
		end
		local v114 = false
		local v115 = nil
		for _, v116 in pairs(v_u_9.ExclusiveOffers) do
			for _, v117 in pairs(v116.Items) do
				for _, v118 in pairs(v117.Variants) do
					if v118.ProductID == p112 then
						v115 = v118.Skin
						v114 = true
						break
					end
				end
				if v114 then
					break
				end
			end
			if v114 then
				break
			end
		end
		local v119 = v115 and v_u_12.Skins[v115]
		if v119 then
			v_u_5.Game.Local.Menu.UI.Purchase:Play()
			v_u_8:Modal("PURCHASE_SUCCESSFUL", {
				["Title"] = "PURCHASE SUCCESSFUL",
				["Description"] = ("Thank you for supporting Sniper Duels! Received %*"):format(v119.NiceName),
				["Icon"] = v119.ImageID
			}, function(p120)
				-- upvalues: (ref) v_u_8
				if p120 then
					v_u_8:ChangeTab("Inventory", true)
				end
			end)
		end
	end)
	if #v_u_15 == 0 then
		v_u_15 = nil
	else
		local v_u_121 = nil
		v_u_8:OnTabOpened("Store", function()
			-- upvalues: (ref) v_u_121, (ref) v_u_15, (ref) v_u_10, (ref) v_u_7
			v_u_121 = task.spawn(function()
				-- upvalues: (ref) v_u_15, (ref) v_u_10, (ref) v_u_7
				local v122 = 1
				while true do
					if v122 >= 1 then
						v122 = v122 - 1
						for v123 = #v_u_15, 1, -1 do
							local v124 = v_u_15[v123]
							local v125 = v_u_10[v124.Name].IsLimitedTimeUntil - os.time()
							local v126 = v125 / 86400
							local v127 = math.floor(v126)
							if v125 > 0 and v127 < 2 then
								local v128 = v125 % 60
								local v129 = v125 / 60
								local v130 = math.floor(v129) % 60
								local v131 = v125 / 3600
								local v132 = math.floor(v131) % 24
								if v127 == 0 then
									v124.CaseContents.Limited.Text = utf8.char(128338) .. string.format(" %02i:%02i:%02i", v132, v130, v128)
								else
									v124.CaseContents.Limited.Text = utf8.char(128338) .. string.format(" %02i:%02i:%02i:%02i", v127, v132, v130, v128)
								end
							elseif v125 > 0 then
								v124.CaseContents.Limited.Text = utf8.char(128338) .. (" %* DAYS LEFT"):format((tostring(v127)))
							else
								v124.CaseContents.Limited.Visible = false
								table.remove(v_u_15, v123)
							end
						end
					end
					v122 = v122 + v_u_7.RenderStepped:Wait()
				end
			end)
		end)
		v_u_8:OnTabClosed("Store", function()
			-- upvalues: (ref) v_u_121
			task.cancel(v_u_121)
		end)
	end
end
function v_u_1.GoToExclusiveItem(_)
	-- upvalues: (copy) v_u_8, (ref) v_u_16
	v_u_8:ChangeTab("Store")
	v_u_16(2)
end
return v_u_1
