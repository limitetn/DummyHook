-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("StarterGui")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = {}
local v_u_6 = require(script:WaitForChild("UIToolbar"))
local v_u_7 = require(v2.Modules:WaitForChild("Configs"):WaitForChild("Settings"):WaitForChild("InputMap"))
local v_u_8 = require(v2.Modules.Controllers:WaitForChild("MatchController"))
local v_u_9 = require(v2.Modules.Configs.Settings.SettingsMain)
local v_u_10 = require(v2.Modules.Controllers.ViewmodelController)
local v_u_11 = require(v2.Modules.Main.ClientData)
v_u_5.Connections = {}
v_u_5.InitializedTools = {}
v_u_5.CantEquipItems = 0
local v_u_12 = game:GetService("Players").LocalPlayer
local v_u_13 = {
	["Gun"] = v2.Modules.Controllers.WeaponController.Gun,
	["Melee"] = v2.Modules.Controllers.WeaponController.Melee
}
function v_u_5.BackpackAdded(p_u_14, p15)
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	if p_u_14.CurToolbar then
		p_u_14.CurToolbar:CleanUp()
	end
	p_u_14.CantEquipItems = 0
	for _, v16 in pairs(p_u_14.Connections) do
		if v16.Connected then
			v16:Disconnect()
		end
	end
	p_u_14.CurToolbar = v_u_6.new()
	table.clone(p_u_14.Connections)
	local v17 = p_u_14.Connections
	local v18 = p15.ChildAdded
	local function v20(p19)
		-- upvalues: (ref) v_u_5, (copy) p_u_14
		if p19:IsA("Tool") then
			if not table.find(v_u_5.InitializedTools, p19) then
				p_u_14:ToolAdded(p19)
			end
		else
			return
		end
	end
	table.insert(v17, v18:Connect(v20))
	for _, v21 in pairs(p15:GetChildren()) do
		if v21:IsA("Tool") and not table.find(p_u_14.InitializedTools, v21) then
			p_u_14:ToolAdded(v21)
		end
	end
	p_u_14.CurBackpack = p15
end
function v_u_5.ToolAdded(p_u_22, p_u_23)
	-- upvalues: (copy) v_u_5, (copy) v_u_1, (copy) v_u_13, (copy) v_u_8, (copy) v_u_11, (copy) v_u_12, (copy) v_u_10
	p_u_23.AncestryChanged:Connect(function()
		-- upvalues: (copy) p_u_23, (copy) p_u_22, (ref) v_u_5
		if not p_u_23.Parent then
			p_u_22.CurToolbar:ToolDestroyed(p_u_23)
			local v24 = table.find(v_u_5.InitializedTools, p_u_23)
			if v24 then
				table.remove(v_u_5.InitializedTools, v24)
			end
		end
	end)
	p_u_22.CurToolbar:ToolAdded(p_u_23)
	local v_u_25 = nil
	for _, v26 in pairs(v_u_1:GetTags(p_u_23)) do
		if v_u_13[v26] then
			v_u_25 = require(v_u_13[v26]).new(p_u_23)
			break
		end
	end
	p_u_23.Equipped:Connect(function()
		-- upvalues: (copy) p_u_22, (copy) p_u_23, (ref) v_u_25
		p_u_22.CurToolbar:ToolEquipped(p_u_23)
		v_u_25:Equip()
	end)
	p_u_23.Unequipped:Connect(function()
		-- upvalues: (copy) p_u_22, (copy) p_u_23, (ref) v_u_25
		p_u_22.CurToolbar:ToolUnequipped(p_u_23)
		v_u_25:Unequip()
	end)
	p_u_23.Destroying:Connect(function()
		-- upvalues: (copy) p_u_22, (copy) p_u_23
		p_u_22:ToolRemoving(p_u_23)
	end)
	local v27 = Instance.new("Highlight")
	v27.FillTransparency = 1
	v27.OutlineTransparency = 1
	v27.Name = "PreventSelfTeamHighlight"
	v27.Parent = p_u_23
	local v28 = v_u_5.InitializedTools
	table.insert(v28, p_u_23)
	local v29 = (v_u_8.CurrentMatch and v_u_8.CurrentMatch.Arena or v_u_11.Cache.InShootingRange) and (#v_u_5.InitializedTools == 1 and v_u_12.Character:FindFirstChild("Humanoid"))
	if v29 then
		if v_u_10.activeViewmodel then
			v_u_10.activeViewmodel:Destroy()
			v_u_10.activeViewmodel = nil
		end
		v29:EquipTool(p_u_23)
	end
end
function v_u_5.ToolRemoving(p30, p31)
	p30.CurToolbar:ToolDestroyed(p31)
end
function v_u_5.Init(p_u_32)
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_4, (copy) v_u_7, (copy) v_u_9
	v_u_12.ChildAdded:Connect(function(p33)
		-- upvalues: (copy) p_u_32
		if p33:IsA("Backpack") then
			p_u_32:BackpackAdded(p33)
		end
	end)
	local v34 = v_u_12:FindFirstChild("Backpack")
	if v34 and not p_u_32.CurBackpack then
		p_u_32:BackpackAdded(v34)
	end
	v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	local function v_u_36(p35)
		-- upvalues: (copy) p_u_32
		if p35 == 1 or p35 == -1 then
			if p_u_32.CurToolbar.CurrentIndexSelected == -1 then
				p_u_32.CurToolbar:AttemptEquipIndex(p35 == 1 and p35 and p35 or #p_u_32.CurToolbar.ToolsInOrder)
				return
			elseif p_u_32.CurToolbar.CurrentIndexSelected == 1 and p35 == -1 then
				p_u_32.CurToolbar:AttemptEquipIndex(#p_u_32.CurToolbar.ToolsInOrder)
				return
			elseif p_u_32.CurToolbar.CurrentIndexSelected == #p_u_32.CurToolbar.ToolsInOrder and p35 == 1 then
				p_u_32.CurToolbar:AttemptEquipIndex(1)
			else
				p_u_32.CurToolbar:AttemptEquipIndex(p_u_32.CurToolbar.CurrentIndexSelected + p35)
			end
		else
			return
		end
	end
	v_u_4.InputBegan:Connect(function(p37, p38)
		-- upvalues: (copy) p_u_32, (ref) v_u_7, (copy) v_u_36
		if p38 then
			return
		elseif p_u_32.CantEquipItems > 0 then
			return
		elseif p37.KeyCode.Value >= 48 and p37.KeyCode.Value <= 57 then
			if p37.KeyCode.Value == 48 then
				p_u_32.CurToolbar:AttemptEquipIndex(10)
			else
				p_u_32.CurToolbar:AttemptEquipIndex(9 - (57 - p37.KeyCode.Value))
			end
		elseif p37.KeyCode == v_u_7.GamepadSwapWeapons then
			if p_u_32.CurToolbar.CurrentIndexSelected == -1 or p_u_32.CurToolbar.CurrentIndexSelected == 1 then
				p_u_32.CurToolbar:AttemptEquipIndex(2)
			else
				p_u_32.CurToolbar:AttemptEquipIndex(1)
			end
		else
			if p37.KeyCode == v_u_7.GamepadNextWeapon or p37.KeyCode == v_u_7.GamepadPreviousWeapon then
				v_u_36(p37.KeyCode == v_u_7.GamepadNextWeapon and 1 or -1)
			end
			return
		end
	end)
	v_u_4.InputChanged:Connect(function(p39, p40)
		-- upvalues: (copy) p_u_32, (ref) v_u_9, (ref) v_u_12, (copy) v_u_36
		if p40 then
			return
		elseif p_u_32.CantEquipItems > 0 then
			return
		elseif p39.UserInputType == Enum.UserInputType.MouseWheel then
			if v_u_9.Settings.WeaponScrolling then
				if v_u_12.CameraMode == Enum.CameraMode.LockFirstPerson then
					v_u_36(p39.Position.Z >= 0 and 1 or -1)
				end
			else
				return
			end
		else
			return
		end
	end)
end
return v_u_5
