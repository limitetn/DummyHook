-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
game:GetService("CollectionService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = require(v1.Modules.Configs.CaseConfigs)
local v5 = require(v1.Modules.Configs.SkinConfig)
local v_u_6 = nil
local v_u_7 = nil
if v_u_3:IsServer() then
	local v8 = game:GetService("ServerStorage")
	v_u_6 = require(v8.Modules.Misc.SecureRandom)
	local _ = v_u_6.GetNumber
	v_u_7 = require(v8.Modules.Services.GlobalSkinIndexService)
else
	local _ = math.random
end
local v_u_9 = {}
for v10, v11 in v5 do
	v_u_9[v10] = v11
end
local v_u_12 = {}
for v13 in v_u_9.SkinConditionValues do
	table.insert(v_u_12, v13)
end
table.sort(v_u_12, function(p14, p15)
	-- upvalues: (copy) v_u_9
	return v_u_9.SkinConditionValues[p14] < v_u_9.SkinConditionValues[p15]
end)
function v_u_9.GetSkinCondition(_, p16)
	-- upvalues: (copy) v_u_9, (copy) v_u_12, (ref) v_u_6
	local v17 = v_u_9.Skins[p16.Skin]
	local v18 = p16.Float
	local v19 = nil
	for _, v20 in v_u_12 do
		if not (v17.DisallowedConditions and table.find(v17.DisallowedConditions, v20)) and v18 <= v_u_9.SkinConditionValues[v20] then
			v19 = v20
			break
		end
	end
	if not v19 then
		if v_u_6 ~= nil then
			local v21 = v17.FloatRange
			local v22 = v21 == nil and 0 or v21[1]
			local v23 = 1
			for _, v24 in v_u_12 do
				local v25 = v_u_9.SkinConditionValues[v24]
				if v22 < v25 then
					v19 = v24
					v23 = v25
					break
				end
			end
			p16.Float = v_u_6.GetRNG():NextNumber(v22, v23)
			return v19
		end
		v19 = "MintCondition"
	end
	return v19
end
function v_u_9.FindFirstCaseIncludesSkin(_, p26)
	-- upvalues: (copy) v_u_4
	for v27, v28 in pairs(v_u_4) do
		for _, v29 in pairs(v28.Contents) do
			if v29 == p26 then
				return v27
			end
			if typeof(v29) == "table" then
				for v30, _ in pairs(v29) do
					if v30 == p26 then
						return v27
					end
				end
			end
		end
	end
	return nil
end
function v_u_9.ApplySkin(_, p31, p32, p33)
	-- upvalues: (copy) v_u_9
	if p32 then
		p32 = v_u_9.Skins[p32]
	end
	if not p32 then
		error("Skins::ApplySkin skin not found")
	end
	if not p31:HasTag(p32.WeaponType) then
		error("Invalid weapon for skin")
	end
	if p32.ApplyFunc then
		p32.ApplyFunc(p31, p33)
	end
end
function v_u_9.CreateSkin(p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44)
	-- upvalues: (copy) v_u_3, (ref) v_u_7, (copy) v_u_2, (ref) v_u_6
	if v_u_3:IsClient() then
		error("Skins::CreateSkin mustn\'t be called from the client.")
	end
	local v45 = p34.Skins[p35]
	if not v45 then
		error("Skins::CreateSkin failed because skin " .. p35 .. " does not exist.")
	end
	local v46, v47
	if v45.FloatRange then
		v46 = v45.FloatRange[1] or 0
		v47 = v45.FloatRange[2] or 1
	else
		v46 = 0
		v47 = 1
	end
	if p36 ~= "[other]" and not p41 then
		v_u_7:UpdateCount(p35, 1)
	end
	return {
		["CATEGORY"] = "Skin",
		["ObtainedUNIXTime"] = os.time(),
		["Skin"] = p35,
		["UID"] = p42 or v_u_2:GenerateGUID(true),
		["Float"] = p37 or v_u_6.GetRNG():NextNumber(v46, v47),
		["FragTrakr"] = p38 or nil,
		["FragTrakrCount"] = 0,
		["UnusualTracer"] = p39,
		["KillEffect"] = p40,
		["Untradable"] = p41 and true or false,
		["Undeletable"] = p43 and true or nil,
		["UpgradingProhibited"] = p44 and true or nil,
		["Origin"] = p36
	}
end
function v_u_9.GetFullSkinName(_, p48, p49)
	-- upvalues: (copy) v_u_9
	local v50 = v_u_9.Skins[p48.Skin]
	return (v50.Rarity >= 6 and utf8.char(9733) .. " " or "") .. (p48.FragTrakr == nil and "" or "fragtrakr ") .. string.upper(v50.OriginalWeaponName or v50.OriginalTool) .. (p49 and "" or " | " .. string.upper(v50.NiceName))
end
local v_u_51 = {
	"ObtainedUNIXTime",
	"Untradable",
	"Undeletable",
	"Origin"
}
function v_u_9.RemoveUnnecessaryDataForReplication(_, p52)
	-- upvalues: (copy) v_u_51
	local function v_u_57(p53)
		-- upvalues: (ref) v_u_51, (ref) v_u_57
		local v54 = {}
		for v55, v56 in pairs(p53) do
			if not table.find(v_u_51, v55) then
				if typeof(v56) == "table" then
					v54[v55] = v_u_57(v56)
				else
					v54[v55] = v56
				end
			end
		end
		return v54
	end
	return v_u_57(p52)
end
return v_u_9
