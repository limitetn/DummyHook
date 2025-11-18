-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService")
local v_u_4 = require(v2.Modules.Shared.Skins)
require(v2.Modules.Configs.SkinConfig)
local v_u_5 = require(v2.Modules.Configs.CaseConfigs)
local v_u_6
if v3:IsServer() then
	v_u_6 = require(game:GetService("ServerStorage").Modules.Misc.SecureRandom).GetNumber
else
	v_u_6 = math.random
end
function v_u_1.PickRandomSkinFromAvailableSkins(p7, p8)
	-- upvalues: (ref) v_u_6
	local v9 = p8 * #p7
	local v10 = p7[math.ceil(v9)]
	local v11 = nil
	if typeof(v10) ~= "table" then
		return v10
	end
	local v12 = 0
	local v13 = {}
	local v_u_14 = {}
	for v15, v16 in v10 do
		v12 = v12 + v16
		table.insert(v13, v15)
	end
	for v17, v18 in v10 do
		v_u_14[v17] = v18 / v12
	end
	table.sort(v13, function(p19, p20)
		-- upvalues: (copy) v_u_14
		return v_u_14[p19] > v_u_14[p20]
	end)
	local v21 = v_u_6()
	local v22 = 0
	for _, v23 in v13 do
		local v24 = v_u_14[v23]
		if v24 ~= nil then
			v22 = v22 + v24
			if v21 <= v22 then
				return v23
			end
		end
	end
	return v11
end
local function v_u_34(p25)
	-- upvalues: (copy) v_u_4
	local v26 = {}
	for _, v27 in pairs(p25.Contents) do
		if typeof(v27) == "string" then
			local v28 = v_u_4.Skins[v27].Rarity
			if v26[v28] then
				local v29 = v26[v28]
				table.insert(v29, v27)
			else
				v26[v28] = { v27 }
			end
		else
			local v30 = nil
			for v31, _ in pairs(v27) do
				v30 = v31
				break
			end
			local v32 = v_u_4.Skins[v30].Rarity
			if v26[v32] then
				local v33 = v26[v32]
				table.insert(v33, v27)
			else
				v26[v32] = { v27 }
			end
		end
	end
	return v26
end
local function v_u_42(p35, p36, p37)
	-- upvalues: (copy) v_u_4, (copy) v_u_1
	local v38 = {}
	for _, v39 in pairs(p35.Contents) do
		if typeof(v39) == "string" then
			if v_u_4.Skins[v39].Rarity == p36 and not table.find(v38, v39) then
				table.insert(v38, v39)
			end
		else
			local v40 = nil
			for v41, _ in pairs(v39) do
				v40 = v41
				break
			end
			if v_u_4.Skins[v40].Rarity == p36 and not table.find(v38, v39) then
				table.insert(v38, v39)
			end
		end
	end
	return v_u_1.PickRandomSkinFromAvailableSkins(v38, p37)
end
local function v_u_52(p43, p44, p45)
	local v46 = -1
	local v47 = 101
	local v48 = nil
	local v49 = -1
	for v50, v51 in pairs(p43.Chance) do
		if v51 then
			if v46 < v51 then
				v49 = v50
				v46 = v51
			end
			if p44 <= v51 / 100 and (v51 < v47 and (not p45 or v50 < 6)) then
				v48 = v50
				v47 = v51
			end
		end
	end
	return v48 or v49
end
function v_u_1.GetRandomSkinAttributes(p53, p54, _, _, _)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v55 = v_u_4.Skins[p54].WeaponType
	local v56 = nil
	local v57 = nil
	local v58
	if math.random() < v_u_4.FragTrakrChancePercentage / 100 then
		local v59 = {}
		for _, v60 in pairs(v_u_4.AvailableFragTrakrs[v55 == "Gun" and "Sniper" or "Knife"]) do
			table.insert(v59, v60)
		end
		v58 = v59[math.random(1, #v59)]
	else
		v58 = nil
	end
	if v55 == "Gun" and math.random() < v_u_4.FXChancePercentage / 100 then
		local v61 = v_u_5[p53]
		if v61 then
			if math.random(1, 2) == 1 and #v61.KillEffectsContents ~= 0 then
				v56 = v61.KillEffectsContents[math.random(1, #v61.KillEffectsContents)]
			elseif #v61.FXContents ~= 0 then
				v57 = v61.FXContents[math.random(1, #v61.FXContents)]
			end
		end
	end
	return v58, v57, v56
end
function v_u_1.GetRandomSkinArrayFromCase(p62, p63, _)
	-- upvalues: (copy) v_u_5, (copy) v_u_34, (copy) v_u_52, (ref) v_u_6, (copy) v_u_1
	local v64 = v_u_5[p63]
	local v65 = v_u_34(v64)
	local v66 = {}
	for _ = 1, p62 do
		local v67 = v_u_52(v64, v_u_6(), true)
		local v68 = v_u_1.PickRandomSkinFromAvailableSkins
		local v69 = v65[v67]
		local v70 = v_u_6
		table.insert(v66, v68(v69, v70()))
	end
	return v66
end
function v_u_1.GetRandomSkinFromCase(p71)
	-- upvalues: (copy) v_u_5, (ref) v_u_6, (copy) v_u_52, (copy) v_u_42
	local v72 = v_u_5[p71]
	local v73 = v_u_6()
	local v74 = v_u_6()
	return v_u_42(v72, v_u_52(v72, v73), v74)
end
return v_u_1
