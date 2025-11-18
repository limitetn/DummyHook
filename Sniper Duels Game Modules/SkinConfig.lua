-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = require(v_u_1.Modules.Shared.EliminationRewards)
local v3 = {}
local function v_u_6(p4)
	for _, v5 in pairs(p4:GetChildren()) do
		if v5:IsA("SurfaceAppearance") then
			v5:Destroy()
		end
	end
end
local function v_u_16(p7, p8)
	-- upvalues: (copy) v_u_6
	if not p8 then
		error("applyReskin->No surface appearance directory given")
		return
	end
	if not p7 then
		error("applyReskin->No tool given")
		return
	end
	for _, v9 in pairs(p8:GetChildren()) do
		local v10 = string.split(v9.Name, ",")
		for _, v11 in pairs(v10) do
			local v12 = string.split(v11, "/")
			local v13 = p7.Gun.Object.FirstPerson:FindFirstChild(v12[1])
			if v13 then
				if #v12 > 1 then
					for v14 = 2, #v12 do
						local v15 = v13:FindFirstChild(v12[v14])
						if not v15 then
							warn("Couldn\'t resolve skin pathname " .. v11)
							break
						end
						v13 = v15
					end
				end
				if v13 then
					v_u_6(v13)
					v9:Clone().Parent = v13
				end
			else
				warn("Couldn\'t resolve path for " .. v11)
			end
		end
	end
end
local function v_u_26(p17, p18)
	-- upvalues: (copy) v_u_6
	if not p18 then
		error("applyReskin->No surface appearance directory given")
		return
	end
	if not p17 then
		error("applyReskin->No tool given")
		return
	end
	for _, v19 in pairs(p18:GetChildren()) do
		local v20 = string.split(v19.Name, ",")
		for _, v21 in pairs(v20) do
			local v22 = string.split(v21, "/")
			local v23 = p17.Knife:FindFirstChild(v22[1])
			if v23 then
				if #v22 > 1 then
					for v24 = 2, #v22 do
						local v25 = v23:FindFirstChild(v22[v24])
						if not v25 then
							warn("Couldn\'t resolve skin pathname " .. v21)
							break
						end
						v23 = v25
					end
				end
				if v23 then
					v_u_6(v23)
					v19:Clone().Parent = v23
				end
			else
				warn("Couldn\'t resolve path for " .. v21)
			end
		end
	end
end
local function v_u_31(p27, p28)
	for _, v29 in pairs(p27.Gun.Object:GetDescendants()) do
		if v29:IsA("SurfaceAppearance") then
			v29:Destroy()
		elseif v29:IsA("BasePart") then
			v29.Material = Enum.Material.Neon
		end
	end
	local v30 = Instance.new("Highlight")
	v30.Adornee = p27.Gun.Object.FirstPerson
	v30.DepthMode = Enum.HighlightDepthMode.Occluded
	v30.FillColor = p28 == "white" and Color3.fromRGB(239, 239, 239) or Color3.fromRGB(29, 29, 29)
	v30.FillTransparency = 0
	v30.OutlineColor = p28 == "white" and Color3.fromRGB(29, 29, 29) or Color3.fromRGB(239, 239, 239)
	v30.OutlineTransparency = 0
	v30.Parent = p27.Gun.Object.FirstPerson
	p27:SetAttribute("ShellCustom", p28 == "white" and "TrueWhite" or "TrueBlack")
end
local function v_u_34(p32)
	local v33 = Instance.new("Highlight")
	v33.Adornee = p32.Gun.Object.FirstPerson
	v33.DepthMode = Enum.HighlightDepthMode.Occluded
	v33.FillColor = Color3.fromRGB(120, 120, 120)
	v33.FillTransparency = -1.25
	v33.OutlineColor = Color3.fromRGB(145, 145, 145)
	v33.OutlineTransparency = -10
	v33.Parent = p32.Gun.Object.FirstPerson
end
local function v_u_39(p35)
	p35.Gun.Object.FirstPerson.Magazine.Bullet_1:Destroy()
	p35.Gun.Object.FirstPerson.Magazine.Bullet_2:Destroy()
	for _, v36 in pairs(p35.Gun.Object:GetDescendants()) do
		if v36:IsA("BasePart") then
			v36.Transparency = 0.999
		end
	end
	local v37 = Instance.new("Highlight")
	v37.Adornee = p35.Gun.Object.FirstPerson
	v37.DepthMode = Enum.HighlightDepthMode.Occluded
	v37.FillColor = Color3.fromRGB(122, 122, 122)
	v37.FillTransparency = -1.5
	v37.OutlineColor = Color3.fromRGB(117, 117, 117)
	v37.OutlineTransparency = -1000000
	v37.Parent = p35.Gun.Object.FirstPerson
	local v38 = Instance.new("Humanoid")
	v38.Name = "Effect"
	v38.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	v38.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
	v38.MaxHealth = 0
	v38.Health = 0
	v38.BreakJointsOnDeath = false
	v38.EvaluateStateMachine = false
	v38.RequiresNeck = false
	v38.Parent = p35.Gun.Object.FirstPerson
end
local function v_u_42(p40)
	for _, v41 in pairs(p40.Gun.Object:GetDescendants()) do
		if v41:IsA("SurfaceAppearance") then
			v41:Destroy()
		elseif v41:IsA("BasePart") then
			v41.Material = Enum.Material.SmoothPlastic
			v41.Reflectance = 1
		end
	end
	p40:SetAttribute("ShellCustom", "Reflectance")
end
local function v_u_46(p43, p44)
	for _, v45 in pairs(p43.Gun.Object:GetDescendants()) do
		if (v45:IsA("BasePart") or v45:IsA("UnionOperation")) and v45:HasTag("ApplyPartColor") then
			v45.Color = p44
		end
	end
end
v3.Rarities = table.freeze({
	"Common",
	"Uncommon",
	"Rare",
	"Legendary",
	"Epic",
	"Knife",
	"Secret",
	"Collectable"
})
v3.SkinConditionValues = table.freeze({
	["MintCondition"] = 0.1,
	["StandardIssue"] = 0.55,
	["WellWorn"] = 1
})
v3.SkinConditionAbbreviations = table.freeze({
	["MintCondition"] = "MC",
	["StandardIssue"] = "SI",
	["WellWorn"] = "WW"
})
v3.SkinConditionNiceNames = table.freeze({
	["MintCondition"] = "Mint Condition",
	["StandardIssue"] = "Standard Issue",
	["WellWorn"] = "Well Worn"
})
v3.FragTrakrTypeNames = table.freeze({
	["Kills"] = "Kills",
	["HeadshotKills"] = "Headshot Kills",
	["NoscopeKills"] = "Noscope Kills",
	["QuickscopeKills"] = "Quickscope Kills",
	["LowerBodyKills"] = "Lower Body Kills"
})
v3.KillEffects = table.freeze({ "Darkheart", "Cash" })
v3.TracerEffects = table.freeze({
	"Surge",
	"Binary",
	"Loveshot",
	"Omega",
	"Voidcry",
	"Inferno",
	"Starbound",
	"Blacklight",
	"Plagueborn",
	"VoidGrasp",
	"Magician",
	"Shock",
	"NoxNostra",
	"AstralPlain",
	"Cryptic",
	"RedMist"
})
v3.AvailableFragTrakrs = {
	["Sniper"] = {
		"Kills",
		"HeadshotKills",
		"NoscopeKills",
		"QuickscopeKills",
		"LowerBodyKills"
	},
	["Knife"] = { "Kills" }
}
v3.FragTrakrIcons = {
	["Kills"] = v2[0].Icon,
	["HeadshotKills"] = v2[1].Icon,
	["NoscopeKills"] = v2[2].Icon,
	["QuickscopeKills"] = v2[3].Icon,
	["LowerBodyKills"] = v2[0].Icon
}
local v47 = {
	["Common"] = {
		["UIBtn_ColorGradient"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(244, 244, 244)),
			ColorSequenceKeypoint.new(0.0917, Color3.fromRGB(223, 223, 223)),
			ColorSequenceKeypoint.new(0.542, Color3.fromRGB(181, 181, 181)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 130, 130))
		}),
		["BaseColor"] = Color3.fromRGB(181, 181, 181)
	},
	["Uncommon"] = {
		["UIBtn_ColorGradient"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(229, 240, 187)),
			ColorSequenceKeypoint.new(0.187, Color3.fromRGB(177, 238, 107)),
			ColorSequenceKeypoint.new(0.429, Color3.fromRGB(162, 218, 98)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 138, 62))
		}),
		["BaseColor"] = Color3.fromRGB(177, 238, 107)
	},
	["Rare"] = {
		["UIBtn_ColorGradient"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(162, 206, 236)),
			ColorSequenceKeypoint.new(0.121, Color3.fromRGB(103, 193, 235)),
			ColorSequenceKeypoint.new(0.486, Color3.fromRGB(100, 189, 229)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 108, 176))
		}),
		["BaseColor"] = Color3.fromRGB(79, 108, 176)
	},
	["Legendary"] = {
		["UIBtn_ColorGradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(216, 167, 232)), ColorSequenceKeypoint.new(0.123, Color3.fromRGB(208, 137, 232)), ColorSequenceKeypoint.new(1, Color3.fromRGB(157, 101, 171)) }),
		["BaseColor"] = Color3.fromRGB(208, 137, 232)
	},
	["Epic"] = {
		["UIBtn_ColorGradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(252, 230, 174)), ColorSequenceKeypoint.new(0.476, Color3.fromRGB(252, 181, 17)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 167, 51)) }),
		["BaseColor"] = Color3.fromRGB(252, 181, 17)
	},
	["Knife"] = {
		["UIBtn_ColorGradient"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(229, 149, 164)),
			ColorSequenceKeypoint.new(0.211, Color3.fromRGB(229, 86, 92)),
			ColorSequenceKeypoint.new(0.647, Color3.fromRGB(229, 46, 46)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(165, 22, 22))
		}),
		["BaseColor"] = Color3.fromRGB(229, 46, 46)
	},
	["Secret"] = {
		["UIBtn_ColorGradient"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(33, 33, 33)),
			ColorSequenceKeypoint.new(0.211, Color3.fromRGB(80, 80, 80)),
			ColorSequenceKeypoint.new(0.647, Color3.fromRGB(53, 53, 53)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 90, 90))
		}),
		["BaseColor"] = Color3.fromRGB(53, 53, 53)
	},
	["Collectable"] = {
		["UIBtn_ColorGradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(171, 162, 240)), ColorSequenceKeypoint.new(0.45, Color3.fromRGB(103, 139, 218)), ColorSequenceKeypoint.new(1, Color3.fromRGB(159, 183, 248)) }),
		["BaseColor"] = Color3.fromRGB(103, 139, 218)
	}
}
v3.RaritiesConfig = v47
local v154 = {
	["DefaultSniper"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Default",
		["ImageID"] = "rbxassetid://115017985373243",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = false,
		["CanHaveFX"] = false,
		["Rarity"] = 1,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, 0 },
		["ApplyFunc"] = nil
	},
	["DefaultKnife"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Default",
		["ImageID"] = "rbxassetid://73300788107858",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = false,
		["CanHaveFX"] = false,
		["Rarity"] = 1,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, 0 },
		["ApplyFunc"] = nil
	},
	["Flames"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Flames",
		["ImageID"] = "rbxassetid://79656420970305",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 2,
		["ApplyFunc"] = function(p48, p49)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p48, v_u_1.Assets.SkinAssets.ReleaseCase.Flames[p49])
		end
	},
	["SnakeSkin"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Snake Skin",
		["ImageID"] = "rbxassetid://97962245541226",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 2,
		["ApplyFunc"] = function(p50, p51)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p50, v_u_1.Assets.SkinAssets.ReleaseCase.SnakeSkin[p51])
		end
	},
	["GreenStream"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Green Stream",
		["ImageID"] = "rbxassetid://120054666051532",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 2,
		["ApplyFunc"] = function(p52, p53)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p52, v_u_1.Assets.SkinAssets.ReleaseCase.GreenStream[p53])
		end
	},
	["Lightning"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Lightning",
		["ImageID"] = "rbxassetid://83551310146503",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 3,
		["ApplyFunc"] = function(p54, p55)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p54, v_u_1.Assets.SkinAssets.ReleaseCase.Lightning[p55])
		end
	},
	["CrimeScene"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Crime Scene",
		["ImageID"] = "rbxassetid://132556039106692",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 3,
		["ApplyFunc"] = function(p56, p57)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p56, v_u_1.Assets.SkinAssets.ReleaseCase.CrimeScene[p57])
		end
	},
	["VanillaAWP"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Vanilla",
		["ImageID"] = "rbxassetid://122466302385690",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 4,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p58, p59)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p58, v_u_1.Assets.SkinAssets.ReleaseCase.VanillaAWP[p59])
		end
	},
	["AWP_Bubblegum"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Bubblegum",
		["ImageID"] = "rbxassetid://99200765919446",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 4,
		["ApplyFunc"] = function(p60, p61)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p60, v_u_1.Assets.SkinAssets.ReleaseCase.Bubblegum[p61])
		end
	},
	["VanillaIntervention"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Vanilla",
		["ImageID"] = "rbxassetid://87094546056084",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Intervention",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 4,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p62, p63)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p62, v_u_1.Assets.SkinAssets.ReleaseCase.VanillaIntervention[p63])
		end
	},
	["Apex"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Apex",
		["ImageID"] = "rbxassetid://96644935130227",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Intervention",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 5,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p64, p65)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p64, v_u_1.Assets.SkinAssets.ReleaseCase.Apex[p65])
		end
	},
	["SunsetRunner"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Sunset Runner",
		["ImageID"] = "rbxassetid://107897322082412",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 5,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p66, p67)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p66, v_u_1.Assets.SkinAssets.ReleaseCase.SunsetRunner[p67])
		end
	},
	["Wood"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Wood",
		["ImageID"] = "rbxassetid://118730281707353",
		["CaseAssociation"] = "Pre-Alpha 2025 Reward",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = false,
		["CanHaveFX"] = false,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p68, _)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p68, v_u_1.Assets.SkinAssets.Etc.Wood.MintCondition)
		end
	},
	["BlackAndYellow"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Black and Yellow",
		["ImageID"] = "rbxassetid://1450802602",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 2,
		["ApplyFunc"] = function(p69, p70)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p69, v_u_1.Assets.SkinAssets.Etc.BlackAndYellow[p70])
		end
	},
	["AWP_RainbowRunner"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Rainbow Runner",
		["ImageID"] = "rbxassetid://80967378021620",
		["CaseAssociation"] = "BOMBLINE Top Elite Reward",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = false,
		["CanHaveFX"] = false,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p71, p72)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p71, v_u_1.Assets.SkinAssets.Etc.AWP_RainbowRunner[p72])
		end
	},
	["Deagle"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Vanilla",
		["ImageID"] = "rbxassetid://73453081572173",
		["OriginalTool"] = "Deagle",
		["OriginalWeaponName"] = "Deagle",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition }
	},
	["AWP_Broly"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Broly Awesome.",
		["ImageID"] = "rbxassetid://129117752210279",
		["CaseAssociation"] = "Dude broly is so cool.",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p73, p74)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p73, v_u_1.Assets.SkinAssets.Etc.Broly[p74])
		end
	},
	["RetroSlop"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Retroslop",
		["ImageID"] = "rbxassetid://73453081572173",
		["CaseAssociation"] = "Release 2025 Collectable",
		["OriginalTool"] = "RetroSlop",
		["OriginalWeaponName"] = "Classic",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition }
	},
	["RetroSlop_Red"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Retroslop",
		["ImageID"] = "rbxassetid://129588734847446",
		["CaseAssociation"] = "Release 2025 Collectable",
		["OriginalTool"] = "RetroSlop",
		["OriginalWeaponName"] = "Classic",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p75, _)
			-- upvalues: (copy) v_u_46
			v_u_46(p75, Color3.fromRGB(208, 50, 50))
		end
	},
	["RetroSlop_Green"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Retroslop",
		["ImageID"] = "rbxassetid://115078866432026",
		["CaseAssociation"] = "Release 2025 Collectable",
		["OriginalTool"] = "RetroSlop",
		["OriginalWeaponName"] = "Classic",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p76, _)
			-- upvalues: (copy) v_u_46
			v_u_46(p76, Color3.fromRGB(54, 189, 39))
		end
	},
	["RetroSlop_Blue"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Retroslop",
		["ImageID"] = "rbxassetid://90538679798319",
		["CaseAssociation"] = "Release 2025 Collectable",
		["OriginalTool"] = "RetroSlop",
		["OriginalWeaponName"] = "Classic",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p77, _)
			-- upvalues: (copy) v_u_46
			v_u_46(p77, Color3.fromRGB(28, 142, 218))
		end
	},
	["RetroSlop_Yellow"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Retroslop",
		["ImageID"] = "rbxassetid://133033212868666",
		["CaseAssociation"] = "Release 2025 Collectable",
		["OriginalTool"] = "RetroSlop",
		["OriginalWeaponName"] = "Classic",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p78, _)
			-- upvalues: (copy) v_u_46
			v_u_46(p78, Color3.fromRGB(218, 182, 39))
		end
	},
	["RetroSlop_Pink"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Retroslop",
		["ImageID"] = "rbxassetid://109424953757009",
		["CaseAssociation"] = "Release 2025 Collectable",
		["OriginalTool"] = "RetroSlop",
		["OriginalWeaponName"] = "Classic",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p79, _)
			-- upvalues: (copy) v_u_46
			v_u_46(p79, Color3.fromRGB(204, 132, 217))
		end
	},
	["AWP_FrankenAWP"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "FrankenAWP",
		["ImageID"] = "rbxassetid://102758354594754",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Halloween 2025 Collectable</font>",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p80, p81)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p80, v_u_1.Assets.SkinAssets.Event.Halloween2025.FrankenAWP.Style1[p81])
		end
	},
	["AWP_FrankenAWP_Style2"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "FrankenAWP",
		["ImageID"] = "rbxassetid://138211467299927",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Halloween 2025 Collectable</font>",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p82, p83)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p82, v_u_1.Assets.SkinAssets.Event.Halloween2025.FrankenAWP.Style2[p83])
		end
	},
	["Intervention_HallowsPunisher"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Hallows Punisher",
		["ImageID"] = "rbxassetid://122501752273549",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Halloween 2025 Collectable</font>",
		["OriginalTool"] = "Intervention",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p84, p85)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p84, v_u_1.Assets.SkinAssets.Event.Halloween2025.HallowsPunisher.Style1[p85])
		end
	},
	["Intervention_HallowsPunisher_Style2"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Hallows Punisher",
		["ImageID"] = "rbxassetid://126506799611384",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Halloween 2025 Collectable</font>",
		["OriginalTool"] = "Intervention",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 8,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p86, p87)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p86, v_u_1.Assets.SkinAssets.Event.Halloween2025.HallowsPunisher.Style2[p87])
		end
	},
	["Mummy"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Mummy",
		["ImageID"] = "rbxassetid://96001791803845",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 2,
		["ApplyFunc"] = function(p88, p89)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p88, v_u_1.Assets.SkinAssets.Event.Halloween2025.Mummy[p89])
		end
	},
	["Stalker"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Stalker",
		["ImageID"] = "rbxassetid://73067911008322",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 2,
		["ApplyFunc"] = function(p90, p91)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p90, v_u_1.Assets.SkinAssets.Event.Halloween2025.Stalker[p91])
		end
	},
	["Zombie"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Zombie",
		["ImageID"] = "rbxassetid://116146368083648",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 2,
		["ApplyFunc"] = function(p92, p93)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p92, v_u_1.Assets.SkinAssets.Event.Halloween2025.Zombie[p93])
		end
	},
	["Catseye"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Crimson Catseye",
		["ImageID"] = "rbxassetid://88493321668140",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 3,
		["ApplyFunc"] = function(p94, p95)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p94, v_u_1.Assets.SkinAssets.Event.Halloween2025.Catseye[p95])
		end
	},
	["VampireHunter"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Vampire Hunter",
		["ImageID"] = "rbxassetid://129676161983011",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 3,
		["ApplyFunc"] = function(p96, p97)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p96, v_u_1.Assets.SkinAssets.Event.Halloween2025.VampireHunter[p97])
		end
	},
	["Cauldron"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Cauldron",
		["ImageID"] = "rbxassetid://71478201523636",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 3,
		["ApplyFunc"] = function(p98, p99)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p98, v_u_1.Assets.SkinAssets.Event.Halloween2025.Cauldron[p99])
		end
	},
	["AWP_WhiteSpiral"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "White Spiral",
		["ImageID"] = "rbxassetid://89484693451229",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 4,
		["ApplyFunc"] = function(p100, p101)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p100, v_u_1.Assets.SkinAssets.Event.Halloween2025.WhiteSpiralAWP[p101])
		end
	},
	["AWP_Bewitched"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Bewitched",
		["ImageID"] = "rbxassetid://117672755746996",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 4,
		["ApplyFunc"] = function(p102, p103)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p102, v_u_1.Assets.SkinAssets.Event.Halloween2025.Bewitched[p103])
		end
	},
	["Intervention_Reaper"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Reaper",
		["ImageID"] = "rbxassetid://96265329396650",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Intervention",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 4,
		["ApplyFunc"] = function(p104, p105)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p104, v_u_1.Assets.SkinAssets.Event.Halloween2025.Reaper[p105])
		end
	},
	["AWP_RedSpiral"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Red Spiral",
		["ImageID"] = "rbxassetid://72032248299113",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 5,
		["ApplyFunc"] = function(p106, p107)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p106, v_u_1.Assets.SkinAssets.Event.Halloween2025.RedSpiralAWP[p107])
		end
	},
	["Intervention_BlackKnight"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Black Knight",
		["ImageID"] = "rbxassetid://120820219008378",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Intervention",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 5,
		["ApplyFunc"] = function(p108, p109)
			-- upvalues: (copy) v_u_16, (copy) v_u_1
			v_u_16(p108, v_u_1.Assets.SkinAssets.Event.Halloween2025.BlackKnight[p109])
		end
	},
	["Bayonet_CandyCorn"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Candy Corn",
		["ImageID"] = "rbxassetid://112046487211551",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["ApplyFunc"] = function(p110, p111)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p110, v_u_1.Assets.SkinAssets.Event.Halloween2025.Knives.CandyCorn[p111])
		end
	},
	["Bayonet_Cultist"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Cultist",
		["ImageID"] = "rbxassetid://92071651102284",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p112, p113)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p112, v_u_1.Assets.SkinAssets.Event.Halloween2025.Knives.Cultist[p113])
		end
	},
	["Bayonet_Vampiric"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Vampiric",
		["ImageID"] = "rbxassetid://74254417900271",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["ApplyFunc"] = function(p114, p115)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p114, v_u_1.Assets.SkinAssets.Event.Halloween2025.Knives.Vampiric[p115])
		end
	},
	["Bayonet_ZombieSlayer"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Zombie Slayer",
		["ImageID"] = "rbxassetid://128675624394663",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["ApplyFunc"] = function(p116, p117)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p116, v_u_1.Assets.SkinAssets.Event.Halloween2025.Knives.ZombieSlayer[p117])
		end
	},
	["AWP_Elementist"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Elementalist",
		["ImageID"] = "rbxassetid://72283834159431",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p118, _)
			-- upvalues: (copy) v_u_1, (copy) v_u_16
			local v119 = v_u_1.Assets.SkinAssets.Event.Halloween2025.ElementistAWP
			v119.EssenceFX.Essence:Clone().Parent = p118.Gun.Object.FirstPerson.Base
			v_u_16(p118, v119.MintCondition)
		end
	},
	["AWP_Elementist_Purple"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Umbr-Elementalist",
		["ImageID"] = "rbxassetid://106505827651276",
		["CaseAssociation"] = "<font color=\"rgb(255, 145, 0)\">Hallows Basket 2025</font>",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p120, _)
			-- upvalues: (copy) v_u_1, (copy) v_u_16
			local v121 = v_u_1.Assets.SkinAssets.Event.Halloween2025.ElementistAWP_Purple
			v121.EssenceFX.Essence:Clone().Parent = p120.Gun.Object.FirstPerson.Base
			v_u_16(p120, v121.MintCondition)
		end
	},
	["TrueWhite"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "True White",
		["ImageID"] = "rbxassetid://99697889064901",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p122, _)
			-- upvalues: (copy) v_u_31
			v_u_31(p122, "white")
		end
	},
	["TrueBlack"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "True Black",
		["ImageID"] = "rbxassetid://115809337698357",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p123, _)
			-- upvalues: (copy) v_u_31
			v_u_31(p123, "black")
		end
	},
	["Default_Reflectance"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Reflectance",
		["ImageID"] = "rbxassetid://97304362855499",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p124, _)
			-- upvalues: (copy) v_u_42
			v_u_42(p124)
		end
	},
	["Default_Inverted"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Inverted",
		["ImageID"] = "rbxassetid://81167011176232",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p125, _)
			-- upvalues: (copy) v_u_34
			v_u_34(p125)
		end
	},
	["Default_TrueInverted"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "True Inverted",
		["ImageID"] = "rbxassetid://97304362855499",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p126, _)
			-- upvalues: (copy) v_u_39
			v_u_39(p126)
		end
	},
	["AWP_Inverted"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "Inverted",
		["ImageID"] = "rbxassetid://92052369782953",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p127, _)
			-- upvalues: (copy) v_u_34
			v_u_34(p127)
		end
	},
	["AWP_TrueInverted"] = {
		["WeaponType"] = "Gun",
		["NiceName"] = "True Inverted",
		["ImageID"] = "rbxassetid://89468317955123",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "AWP",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p128, _)
			-- upvalues: (copy) v_u_39
			v_u_39(p128)
		end
	},
	["Prototype"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Prototype",
		["ImageID"] = "rbxassetid://112190155034157",
		["CaseAssociation"] = "Prototype 2025 Reward",
		["OriginalTool"] = "Prototype",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = false,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = nil
	},
	["Pixel"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Pixel",
		["ImageID"] = "rbxassetid://75765040628987",
		["CaseAssociation"] = "BOMBLINE Transfer",
		["OriginalTool"] = "Pixel",
		["OriginalWeaponName"] = "BOMBLINE",
		["CanHaveFragTrakr"] = false,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = nil
	},
	["Kitchen"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Kitchen",
		["ImageID"] = "rbxassetid://72195157686731",
		["CaseAssociation"] = "BOMBLINE Transfer",
		["OriginalTool"] = "Kitchen",
		["OriginalWeaponName"] = "BOMBLINE",
		["CanHaveFragTrakr"] = false,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = nil
	},
	["Default_Bluesteel"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Bluesteel",
		["ImageID"] = "rbxassetid://107334839041637",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Default",
		["OriginalWeaponName"] = "Default",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["ApplyFunc"] = function(p129, p130)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p129, v_u_1.Assets.SkinAssets.Knives.Default.Default_Bluesteel[p130])
		end
	},
	["Bayonet"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Vanilla",
		["ImageID"] = "rbxassetid://118325419326107",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = nil
	},
	["Bayonet_Hypno"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Hypno",
		["ImageID"] = "rbxassetid://124498662510844",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["ApplyFunc"] = function(p131, p132)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p131, v_u_1.Assets.SkinAssets.Knives.Bayonet.Hypno[p132])
		end
	},
	["Bayonet_Sunset"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Sunset",
		["ImageID"] = "rbxassetid://78009848000890",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p133, p134)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p133, v_u_1.Assets.SkinAssets.Knives.Bayonet.Sunset[p134])
		end
	},
	["Bayonet_Aurora"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Aurora",
		["ImageID"] = "rbxassetid://90599693498198",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p135, p136)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p135, v_u_1.Assets.SkinAssets.Knives.Bayonet.Aurora[p136])
		end
	},
	["Bayonet_Amethyst"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Amethyst",
		["ImageID"] = "rbxassetid://125629459056831",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p137, p138)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p137, v_u_1.Assets.SkinAssets.Knives.Bayonet.Gems.Gem_Amethyst[p138])
		end
	},
	["Bayonet_Emerald"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Emerald",
		["ImageID"] = "rbxassetid://106949969318634",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p139, p140)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p139, v_u_1.Assets.SkinAssets.Knives.Bayonet.Gems.Gem_Emerald[p140])
		end
	},
	["Bayonet_Ruby"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Ruby",
		["ImageID"] = "rbxassetid://96510495447482",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p141, p142)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p141, v_u_1.Assets.SkinAssets.Knives.Bayonet.Gems.Gem_Ruby[p142])
		end
	},
	["Bayonet_Sapphire"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Sapphire",
		["ImageID"] = "rbxassetid://73932046357421",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn" },
		["FloatRange"] = { 0, v3.SkinConditionValues.StandardIssue },
		["ApplyFunc"] = function(p143, p144)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p143, v_u_1.Assets.SkinAssets.Knives.Bayonet.Gems.Gem_Sapphire[p144])
		end
	},
	["Bayonet_Onyx"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Onyx",
		["ImageID"] = "rbxassetid://88508879577932",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Bayonet",
		["OriginalWeaponName"] = "Bayonet",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p145, p146)
			-- upvalues: (copy) v_u_26, (copy) v_u_1
			v_u_26(p145, v_u_1.Assets.SkinAssets.Knives.Bayonet.Gems.Gem_Onyx[p146])
		end
	},
	["Butterfly"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Vanilla",
		["ImageID"] = "rbxassetid://118325419326107",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Butterfly",
		["OriginalWeaponName"] = "Butterfly",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = nil
	},
	["Karambit"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Vanilla",
		["ImageID"] = "rbxassetid://119876060107074",
		["CaseAssociation"] = "Release Case",
		["OriginalTool"] = "Karambit",
		["OriginalWeaponName"] = "Karambit",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = false,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = nil
	},
	["JohnDuels"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "John Duels",
		["ImageID"] = "rbxassetid://71253463711",
		["OriginalTool"] = "JohnDuels",
		["OriginalWeaponName"] = "01100101",
		["CanHaveFragTrakr"] = false,
		["CanHaveFX"] = false,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = nil
	},
	["LinkedSword"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Linked Sword",
		["ImageID"] = "rbxassetid://534533607",
		["OriginalTool"] = "LinkedSword",
		["OriginalWeaponName"] = "Sword",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 6,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p147, _)
			local v148 = Instance.new("Sound")
			v148.Name = "Equip"
			v148.Volume = 0.4
			v148.SoundId = "http://www.roblox.com/asset/?id=12222225"
			v148.SoundGroup = game:GetService("SoundService").Game.World.Weapons.Melee
			v148.RollOffMaxDistance = 35
			v148.RollOffMinDistance = 5
			v148.RollOffMode = Enum.RollOffMode.Linear
			v148.Parent = p147.ToolHandle.SoundPoint
		end
	},
	["ScaryDoug"] = {
		["WeaponType"] = "Knife",
		["NiceName"] = "Scary Doug",
		["ImageID"] = "rbxassetid://132230452211236",
		["OriginalTool"] = "LinkedSword",
		["OriginalWeaponName"] = "Sword",
		["CanHaveFragTrakr"] = true,
		["CanHaveFX"] = true,
		["Rarity"] = 7,
		["DisallowedConditions"] = { "WellWorn", "StandardIssue" },
		["FloatRange"] = { 0, v3.SkinConditionValues.MintCondition },
		["ApplyFunc"] = function(p149, _)
			-- upvalues: (copy) v_u_1
			p149.Name = "ScaryDoug"
			p149.Knife.LinkedSword.Mesh.TextureId = ""
			p149.Knife.LinkedSword.Reflectance = 0
			p149.Knife.LinkedSword.Material = Enum.Material.Neon
			p149.Knife.LinkedSword.Color = Color3.fromRGB(0, 0, 0)
			local v150 = Instance.new("Highlight")
			v150.DepthMode = Enum.HighlightDepthMode.Occluded
			v150.FillColor = Color3.fromRGB(255, 255, 255)
			v150.FillTransparency = 15
			v150.OutlineTransparency = 0.99
			v150.OutlineColor = Color3.fromRGB(255, 255, 255)
			v150.Adornee = p149.Knife.LinkedSword
			v150.Parent = p149.Knife.LinkedSword
			local v151 = v_u_1.Assets.SkinAssets.Etc.ScaryDoug.FX:Clone()
			v151.Parent = p149.Knife
			v151.FX.Part0 = p149.ToolHandle
			local v152 = Instance.new("Sound")
			v152.Name = "Idle"
			v152.Volume = 2
			v152.SoundId = "rbxassetid://123555072756292"
			v152.Looped = true
			v152.SoundGroup = game:GetService("SoundService").Game.World.Weapons.Melee
			v152.RollOffMaxDistance = 85
			v152.RollOffMinDistance = 5
			v152.RollOffMode = Enum.RollOffMode.Linear
			v152.Parent = p149.ToolHandle.SoundPoint
			local v153 = Instance.new("Sound")
			v153.Name = "Equip"
			v153.Volume = 0.4
			v153.SoundId = "rbxassetid://92500328682814"
			v153.SoundGroup = game:GetService("SoundService").Game.World.Weapons.Melee
			v153.RollOffMaxDistance = 35
			v153.RollOffMinDistance = 5
			v153.RollOffMode = Enum.RollOffMode.Linear
			v153.Parent = p149.ToolHandle.SoundPoint
		end
	}
}
v3.Skins = v154
v3.FragTrakrChancePercentage = 10
v3.FXChancePercentage = 1
return v3
