-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = require(script.Parent)
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ContextActionService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("SoundService")
local v_u_6 = game:GetService("UserInputService")
local v_u_7 = game:GetService("Players").LocalPlayer
v_u_7:GetMouse()
require(v_u_2.Modules.Configs.WeaponConfigs.Gun._GunConfigType)
local v_u_8 = require(v_u_2.Modules.Configs.Settings.InputMap)
local v_u_9 = require(v_u_2.Modules.Configs.Settings.SettingsMain)
local v_u_10 = require(v_u_2.Modules.Controllers.Effects)
require(v_u_2.Modules.Controllers.CameraController)
local v_u_11 = require(v_u_2.Modules.Shared.Maid)
local v_u_12 = require(v_u_2.Modules.Controllers.UIController)
local v_u_13 = require(v_u_2.Modules.Controllers.CharacterController)
local v_u_14 = require(v_u_2.Modules.Controllers.CameraController)
local v_u_15 = require(v_u_2.Modules.Controllers.CharacterController.WalkspeedHandler)
local v_u_16 = require(v_u_2.Modules.Controllers.ToolController.UIToolbar)
local v_u_17 = require(v_u_2.Modules.Controllers.MatchController)
local v_u_18 = require(v_u_2.Modules.Misc.MultiRaycast)
local v_u_19 = require(v_u_2.Modules.Misc.GlassBreak)
local v_u_20 = require(v_u_2.Modules.Misc.CalculateSpread)
require(v_u_2.Modules.Controllers.EnvironmentalSound)
local v_u_21 = require(v_u_2.Modules.Controllers.MiscRemoteListener)
local v_u_22 = require(v_u_2.Modules.Main.ClientData)
local v_u_23 = v_u_2.Remotes.Character.CharacterStateReplication.Aiming
local v_u_24 = v_u_2.Remotes.Weapons.Inspect
local v_u_25 = v_u_2.Variables.Client.ClEditingMobileHUD
local v_u_26 = require(v_u_2.Modules.Controllers:WaitForChild("CrosshairController"))
local v_u_27 = setmetatable({}, v_u_1)
v_u_27.__index = v_u_27
function v_u_27.new(p_u_28)
	-- upvalues: (copy) v_u_1, (copy) v_u_27, (copy) v_u_11, (copy) v_u_7, (copy) v_u_2, (copy) v_u_21, (copy) v_u_10, (copy) v_u_16, (copy) v_u_13, (copy) v_u_26, (copy) v_u_24, (copy) v_u_6, (copy) v_u_4
	local v29 = v_u_1.new(p_u_28)
	local v30 = v_u_27
	local v_u_31 = setmetatable(v29, v30)
	local v32 = p_u_28:FindFirstChild("Animations")
	v_u_31.MobileControlButtonConnections = v_u_11.new()
	v_u_31.Animations = {}
	local v_u_33 = v_u_7.Character
	local v_u_34 = v_u_33.Humanoid
	local v35 = v_u_34:FindFirstChild("Animator")
	if not v35 then
		v35 = Instance.new("Animator")
		v35.Parent = v_u_33.Humanoid
	end
	v_u_31.Animations.EquipAnim = v35:LoadAnimation(v32:WaitForChild("Equip"))
	v_u_31.Animations.InitialEquipAnim = v35:LoadAnimation(v32:WaitForChild("InitialEquip"))
	v_u_31.Animations.IdleAnim = v35:LoadAnimation(v32:WaitForChild("Idle"))
	v_u_31.Animations.InspectAnim = v35:LoadAnimation(v32:WaitForChild("Inspect"))
	v_u_31.Animations.SimpleInspectAnim = v35:LoadAnimation(v32:WaitForChild("SimpleInspect"))
	v_u_31.Animations.EmptyInspectAnim = v35:LoadAnimation(v32:WaitForChild("EmptyInspect"))
	v_u_31.Animations.ReloadAnim = v35:LoadAnimation(v32:WaitForChild("Reload"))
	v_u_31.Animations.SprintInAnim = v35:LoadAnimation(v32:WaitForChild("SprintIn"))
	v_u_31.Animations.SprintingAnim = v35:LoadAnimation(v32:WaitForChild("Sprinting"))
	v_u_31.Animations.SprintOutAnim = v35:LoadAnimation(v32:WaitForChild("SprintOut"))
	v_u_31.Animations.FireAnim = v35:LoadAnimation(v32:WaitForChild("Fire"))
	v_u_31.Animations.FireAimedAnim = v35:LoadAnimation(v32:WaitForChild("FireAimed"))
	v_u_31.Animations.AimAnim = v35:LoadAnimation(v32:WaitForChild("Aim"))
	for _, v_u_36 in pairs(v_u_31.Animations) do
		v_u_36.KeyframeReached:Connect(function(p37)
			-- upvalues: (copy) v_u_31, (ref) v_u_2, (ref) v_u_21, (copy) v_u_36, (ref) v_u_10, (copy) p_u_28
			if v_u_31.Config.KeyframeFoleySounds[p37] then
				v_u_2.Remotes.Weapons.PlayFoley:FireServer(p37)
				local v38 = v_u_31.weaponTool.ToolHandle.SoundPoint:FindFirstChild(p37)
				if v38 then
					v_u_21.PlaySnd(v38)
					return
				end
			else
				if p37 == "shell_out" then
					local v39
					if v_u_36.Name == "Reload" then
						if v_u_31.CurAmmo <= 0 then
							return
						end
						v39 = true
					else
						v39 = false
					end
					v_u_2.Remotes.Effects.Gun.ShellEject:FireServer(v39)
					v_u_10:ShellEject(v_u_31.weaponTool, v_u_31.Config.ShellType, v39)
					return
				end
				if p37 == "regen_mag_bullets" then
					v_u_10:UpdateGunMagazineBullets(p_u_28, (1 / 0))
				end
			end
		end)
	end
	v_u_31.LastAim = 0
	v_u_31.CurSpread = 0
	v_u_31.EquipCnt = 0
	v_u_31.Aiming = false
	v_u_31.FullyAimedIn = false
	v_u_31.LastFire = 0
	v_u_31.FiringMode = v_u_31.Config.Modes[1]
	v_u_31.SprintAnimInitiatedCnt = 0
	v_u_31.Maid = v_u_11.new()
	p_u_28:WaitForChild("a").OnClientEvent:Connect(function(p40)
		-- upvalues: (copy) v_u_31, (ref) v_u_16, (ref) v_u_13, (copy) p_u_28, (ref) v_u_26, (ref) v_u_10
		v_u_31.CurAmmo = p40
		v_u_16.currentToolbar:SetAmmoForGunSpecificTool(v_u_31.weaponTool, p40, v_u_31.Config.Ammo)
		local v41 = v_u_13.CurrentCharacterActive
		local v42 = v41.Character
		if v41 and (not v41.Dead and (v42 and p_u_28.Parent == v42)) then
			v_u_26:InstructReload(p40 <= 2, p40 <= 1, p40 <= 0)
			v_u_10:UpdateGunMagazineBullets(p_u_28, p40)
		end
	end)
	v_u_31.CurAmmo = v_u_31.Config.Ammo
	p_u_28.Destroying:Connect(function()
		-- upvalues: (copy) v_u_31
		v_u_31:Destroy()
	end)
	local function v43()
		-- upvalues: (copy) v_u_31, (ref) v_u_13, (ref) v_u_24, (ref) v_u_26
		if v_u_31.CurVM and v_u_13.CurrentCharacterActive then
			task.spawn(v_u_31.CurVM.SetBobbingEnabled, v_u_31.CurVM, not v_u_13.CurrentCharacterActive.Sprinting)
		end
		v_u_24:FireServer(false)
		if v_u_31.Aiming then
			return
		elseif not v_u_31.Reloading then
			if v_u_13.CurrentCharacterActive and not v_u_13.CurrentCharacterActive.Dead then
				v_u_13.CurrentCharacterActive.Character.Humanoid:SetAttribute("Inspecting", false)
				local _ = v_u_13.CurrentCharacterActive.MovingSprinting
				local _ = v_u_13.CurrentCharacterActive.Sliding
			end
			v_u_26:Visible(true, 0.25)
		end
	end
	v_u_31.Animations.InspectAnim.Ended:Connect(v43)
	v_u_31.Animations.EmptyInspectAnim.Ended:Connect(v43)
	v_u_31.Animations.SimpleInspectAnim.Ended:Connect(v43)
	v_u_31.Maid:GiveTask(v_u_34:GetAttributeChangedSignal("Sprinting"):Connect(function()
		-- upvalues: (copy) v_u_31, (copy) v_u_33, (copy) v_u_34
		if v_u_31.weaponTool.Parent == v_u_33 then
			if v_u_31.Reloading then
				return
			elseif v_u_34:GetAttribute("Sprinting") and not (v_u_31.Aiming or v_u_31.Reloading) then
				v_u_31:SprintAnimation(true)
			else
				v_u_31:SprintAnimation(false)
			end
		else
			return
		end
	end))
	v_u_31.Maid:GiveTask(v_u_34:GetAttributeChangedSignal("Sliding"):Connect(function()
		-- upvalues: (copy) v_u_31, (copy) v_u_33, (ref) v_u_13, (copy) v_u_34, (ref) v_u_26
		if v_u_31.weaponTool.Parent == v_u_33 then
			if v_u_13.CurrentCharacterActive and (not v_u_13.CurrentCharacterActive.Dead and v_u_13.CurrentCharacterActive.Character.Humanoid:GetAttribute("Inspecting")) then
				return
			elseif v_u_34:GetAttribute("Sliding") then
				v_u_26:MakeTransparent(false)
				v_u_31:SprintAnimation(false, true)
			elseif v_u_13.CurrentCharacterActive and (v_u_13.CurrentCharacterActive.MovingSprinting and not v_u_31.Reloading) then
				v_u_31:SprintAnimation(true)
			end
		else
			return
		end
	end))
	v_u_31.Maid:GiveTask(v_u_31.MobileControlButtonConnections)
	if v_u_31.Config.GUN_DEBUG_MODE then
		v_u_31.DebugUI = v_u_2.Assets.UI.GunDebugMode:Clone()
		v_u_31.DebugUI.Parent = v_u_7.PlayerGui
		local v_u_44 = nil
		v_u_31.Maid:GiveTask(v_u_6.InputBegan:Connect(function(p45, p46)
			-- upvalues: (ref) v_u_6, (ref) v_u_44, (copy) v_u_31, (ref) v_u_4
			if not p46 then
				if p45.KeyCode == Enum.KeyCode.B and v_u_6:IsKeyDown(Enum.KeyCode.LeftControl) then
					if v_u_44 and v_u_44.Connected then
						v_u_44:Disconnect()
					end
					if v_u_31.DebugUI.SnapshotSheet.Visible then
						v_u_6.MouseIconEnabled = false
						v_u_31.DebugUI.SnapshotSheet.Visible = false
						for _, v47 in pairs(v_u_31.DebugUI.SnapshotSheet:GetChildren()) do
							if v47:IsA("Frame") and v47.Name ~= "EntryTemplate" then
								v47:Destroy()
							end
						end
						return
					end
					v_u_44 = v_u_4.RenderStepped:Connect(function()
						-- upvalues: (ref) v_u_6
						v_u_6.MouseBehavior = Enum.MouseBehavior.Default
					end)
					v_u_6.MouseIconEnabled = true
					local v48 = v_u_31.CurVM:GetCurrentAimOffset()
					local v49 = v_u_31.CurVM:GetCurrentSwayPivotOffset()
					local function v54(p50, p51, p52)
						-- upvalues: (ref) v_u_31
						local v53 = v_u_31.DebugUI.SnapshotSheet.EntryTemplate:Clone()
						v53.Name = p50
						v53.Label.Text = p50
						v53.ToCopy.Text = table.concat({ p51:GetComponents() }, ", ")
						v53.LayoutOrder = p52
						v53.Visible = true
						v53.Parent = v_u_31.DebugUI.SnapshotSheet
					end
					v54("AimOffset", v48, 0)
					v54("SwayPivotOffset", v49, 1)
					v_u_31.DebugUI.SnapshotSheet.Visible = true
				end
			end
		end))
		v_u_31.Maid:GiveTask(v_u_31.DebugUI)
	end
	return v_u_31
end
function v_u_27.CalculateSpread(p55)
	-- upvalues: (copy) v_u_13, (copy) v_u_20, (copy) v_u_26
	local v56 = v_u_13.CurrentCharacterActive
	if v56 and not v56.Dead then
		local v57 = v56.Character
		if v57 and v57.Parent then
			local v58 = v_u_20(v57.Humanoid, p55.Aiming, v56.Crouching, v56.Sliding, v56.MovingSprinting, p55.Config.Spread)
			v_u_26:SetSpread(v58)
			p55.CurSpread = v58
			return v58
		end
	end
end
function v_u_27.Inspect(p59)
	-- upvalues: (copy) v_u_24, (copy) v_u_9, (copy) v_u_13, (copy) v_u_26
	if p59.Reloading then
		return
	elseif p59.Animations.InspectAnim.IsPlaying or (p59.Animations.SimpleInspectAnim.IsPlaying or p59.Animations.EmptyInspectAnim.IsPlaying) then
		return
	elseif p59.Firing then
		return
	elseif not p59.Aiming then
		if p59.CurVM then
			task.spawn(p59.CurVM.SetBobbingEnabled, p59.CurVM, true)
		end
		v_u_24:FireServer(true)
		local v60 = p59.Animations
		local _ = v_u_9.Settings.SimpleInspects
		v60[p59.CurAmmo <= 0 and "EmptyInspectAnim" or "InspectAnim"]:Play()
		v_u_13.CurrentCharacterActive.Character.Humanoid:SetAttribute("Inspecting", true)
		v_u_26:Visible(false, 0.5)
	end
end
function v_u_27.CheckModeAndFire(p61)
	if p61.FiringMode == "Semi" then
		p61:SemiFire()
		return
	elseif p61.FiringMode == "Burst" then
		p61:BurstFire()
	elseif p61.FiringMode == "Automatic" then
		p61:AutomaticFire()
	end
end
function v_u_27.CheckAndInitiateBufferedInputs(p62)
	if #p62.BufferedInputs == 0 then
		return
	else
		local v63 = p62.BufferedInputs[#p62.BufferedInputs]
		if v63 == "Fire" then
			p62:CheckModeAndFire()
			return
		elseif v63 == "Aim" then
			p62:Aim(true)
		elseif v63 == "Reload" then
			p62:Reload()
		end
	end
end
function v_u_27.Equip(p_u_64)
	-- upvalues: (copy) v_u_25, (copy) v_u_12, (copy) v_u_9, (copy) v_u_6, (copy) v_u_14, (copy) v_u_13, (copy) v_u_3, (copy) v_u_8, (copy) v_u_10, (copy) v_u_2, (copy) v_u_26, (copy) v_u_7, (copy) v_u_4
	p_u_64.EquipCnt = p_u_64.EquipCnt + 1
	p_u_64.Equipping = true
	if not v_u_25.Value then
		v_u_12.MobileControls.Gun.Visible = true
	end
	if v_u_9.Settings.AimAssist and (not v_u_6.MouseEnabled or v_u_6.GamepadEnabled) then
		v_u_14:ToggleAimAssist(true, 50)
	end
	if v_u_9.Settings.AutoSprint and (v_u_13.CurrentCharacterActive and not (v_u_13.CurrentCharacterActive.Dead or v_u_13.CurrentCharacterActive.Sprinting)) then
		v_u_13.CurrentCharacterActive:Sprint(true)
	end
	local v65 = v_u_3
	local v66 = v_u_8.Fire
	v65:BindAction("FireWeapon", function(_, p67)
		-- upvalues: (copy) p_u_64
		if p67 == Enum.UserInputState.Begin then
			if p_u_64.Equipping then
				p_u_64:AddToBufferedInputs("Fire")
			else
				p_u_64:CheckModeAndFire()
			end
		else
			if p67 == Enum.UserInputState.End then
				p_u_64.Firing = false
				p_u_64:CheckAndRemoveFromBufferedInputs("Fire")
			end
			return
		end
	end, false, table.unpack(v66))
	p_u_64.MobileControlButtonConnections:GiveTask(v_u_12.MobileControls.Gun.Shoot.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_25, (copy) p_u_64
		if v_u_25.Value then
			return
		elseif not p_u_64.Equipping then
			p_u_64:CheckModeAndFire()
		end
	end))
	local v68 = v_u_3
	local function v70(_, p69)
		-- upvalues: (ref) v_u_8, (copy) p_u_64
		if v_u_8.AimToggle then
			if p69 == Enum.UserInputState.Begin then
				p_u_64:Aim(not p_u_64.Aiming)
				return
			end
		else
			if p69 == Enum.UserInputState.Begin then
				if p_u_64.Equipping then
					p_u_64:AddToBufferedInputs("Aim")
				else
					p_u_64:Aim(true)
				end
			end
			if p69 == Enum.UserInputState.End then
				p_u_64:CheckAndRemoveFromBufferedInputs("Aim")
				p_u_64:Aim(false)
			end
		end
	end
	local v71 = v_u_8.AltFire
	v68:BindAction("AimWeapon", v70, false, table.unpack(v71))
	v_u_3:BindAction("Q_AimWeapon", function(_, p72)
		-- upvalues: (copy) p_u_64
		if p72 == Enum.UserInputState.Begin then
			p_u_64:Aim(not p_u_64.Aiming)
		end
	end, false, Enum.KeyCode.Q)
	p_u_64.MobileControlButtonConnections:GiveTask(v_u_12.MobileControls.Gun.Aim.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_25, (copy) p_u_64
		if v_u_25.Value then
			return
		elseif p_u_64.Equipping then
			p_u_64:AddToBufferedInputs("Aim")
		else
			p_u_64:Aim(not p_u_64.Aiming)
		end
	end))
	local v73 = v_u_3
	local v74 = v_u_8.Inspect
	v73:BindAction("InspectWeapon", function(_, p75)
		-- upvalues: (copy) p_u_64
		if p75 == Enum.UserInputState.Begin then
			p_u_64:Inspect()
		end
	end, false, table.unpack(v74))
	p_u_64.MobileControlButtonConnections:GiveTask(v_u_12.MobileControls.Gun.Inspect.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_25, (copy) p_u_64
		if not v_u_25.Value then
			p_u_64:Inspect()
		end
	end))
	local v76 = v_u_3
	local v77 = v_u_8.Reload
	v76:BindAction("ReloadWeapon", function(_, p78)
		-- upvalues: (copy) p_u_64
		if p78 == Enum.UserInputState.Begin then
			if p_u_64.Equipping then
				p_u_64:AddToBufferedInputs("Reload")
			else
				p_u_64:Reload()
			end
		else
			if p78 == Enum.UserInputState.End then
				p_u_64:CheckAndRemoveFromBufferedInputs("Reload")
			end
			return
		end
	end, false, table.unpack(v77))
	p_u_64.MobileControlButtonConnections:GiveTask(v_u_12.MobileControls.Gun.Reload.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_25, (copy) p_u_64
		if v_u_25.Value then
			return
		elseif p_u_64.Equipping then
			p_u_64:AddToBufferedInputs("Reload")
		else
			p_u_64:Reload()
		end
	end))
	if v_u_10:UpdateGunMagazineBullets(p_u_64.weaponTool, p_u_64.CurAmmo) then
		v_u_2.Remotes.Effects.Gun.UpdateMagBullets:FireServer(p_u_64.CurAmmo)
	end
	p_u_64:EquipViewmodel()
	v_u_26:Activate(p_u_64.Config.CrosshairMode)
	v_u_14:SetupRecoil(p_u_64.Config.Recoil, p_u_64.Config.RollRecoil)
	v_u_26:InstructReload(p_u_64.CurAmmo <= 2, p_u_64.CurAmmo <= 1, p_u_64.CurAmmo <= 0)
	if p_u_64.Config.GUN_DEBUG_MODE then
		p_u_64.DebugUI.Enabled = true
	end
	local v_u_79 = p_u_64.EquipCnt
	local v80
	if p_u_64.EquipCnt == 1 then
		v80 = p_u_64.Animations.InitialEquipAnim.Length
		p_u_64.Animations.InitialEquipAnim:Play(0)
	else
		v80 = p_u_64.Animations.EquipAnim.Length
		p_u_64.Animations.EquipAnim:Play(0)
	end
	task.delay(v80 - 0.1, function()
		-- upvalues: (copy) v_u_79, (copy) p_u_64, (ref) v_u_7
		if v_u_79 == p_u_64.EquipCnt and p_u_64.weaponTool.Parent == v_u_7.Character then
			p_u_64.Animations.IdleAnim:Play()
		end
	end)
	task.wait(p_u_64.Config.EquipTime)
	if v_u_79 == p_u_64.EquipCnt and p_u_64.weaponTool.Parent == v_u_7.Character then
		p_u_64.Equipping = false
		p_u_64.Animations.IdleAnim:Play()
		if v_u_13.CurrentCharacterActive and (v_u_13.CurrentCharacterActive.MovingSprinting and not p_u_64.Reloading) then
			p_u_64:SprintAnimation(true)
		end
		v_u_4:BindToRenderStep("GunSpread", Enum.RenderPriority.Input.Value, function()
			-- upvalues: (copy) p_u_64
			p_u_64:CalculateSpread()
		end)
		p_u_64:CheckAndInitiateBufferedInputs()
	end
end
function v_u_27.Aim(p81, p82)
	-- upvalues: (copy) v_u_15, (copy) v_u_23, (copy) v_u_7, (copy) v_u_13, (copy) v_u_9, (copy) v_u_6, (copy) v_u_14, (copy) v_u_26, (copy) v_u_5, (copy) v_u_4, (copy) v_u_12
	if p81.Aiming == p82 then
		return
	end
	if p82 and p81.Reloading then
		return
	end
	p81.Animations.InspectAnim:Stop(0.1)
	p81.Animations.SimpleInspectAnim:Stop(0.1)
	p81.Animations.EmptyInspectAnim:Stop(0.1)
	v_u_15:ChangeWS(p81.Config.AimWalkspeedDecrease * (p82 and -1 or 1))
	v_u_23:FireServer(p82)
	p81.Aiming = p82
	p81.CurVM:Aim(p81.Aiming)
	p81:CalculateSpread()
	if v_u_7.Character and v_u_7.Character:FindFirstChild("Humanoid") then
		v_u_7.Character.Humanoid:SetAttribute("Aiming", p81.Aiming)
	end
	if v_u_13.CurrentCharacterActive and not v_u_13.CurrentCharacterActive.Dead then
		if p82 and (v_u_13.CurrentCharacterActive.Sprinting and not v_u_13.CurrentCharacterActive.Sliding) then
			v_u_13.CurrentCharacterActive:Sprint(false)
		elseif not p82 and (v_u_9.Settings.AutoSprint and not (v_u_13.CurrentCharacterActive.Sprinting or v_u_13.CurrentCharacterActive.Sliding)) then
			v_u_13.CurrentCharacterActive:Sprint(true)
		end
	end
	if p81.Aiming then
		if (not v_u_6.MouseEnabled or v_u_6.GamepadEnabled) and v_u_9.Settings.AimAssist then
			v_u_14:ToggleAimAssist(true, 500)
		end
		p81.LastAim = os.clock()
		p81.CurAimFOV = v_u_9.Settings.AimFOV
		p81.CurBaseFOV = v_u_9.Settings.FOV
		if p81.Reloading then
			p81:CancelReload()
		end
		local v83 = p81.Config.AimIn and (p81.Config.AimIn.Time or 0.25) or 0.25
		p81:SprintAnimation(false, 1, true)
		p81.Animations.AimAnim:Play(v83)
		if p81.Config.UsesScope then
			v_u_26:Visible(false, v83)
		end
		local v84
		if p81.Config.AimIn then
			local v85 = TweenInfo.new
			local v86 = p81.Config.AimIn.Easing
			v84 = v85(v83, table.unpack(v86))
		else
			v84 = TweenInfo.new(v83, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		end
		v_u_5.Game.Local.Notifications.Scoped:Play()
		v_u_14:ChangeFOV(-(p81.CurBaseFOV - p81.CurAimFOV), v84)
		local v87 = 0
		while true do
			if true then
				if v_u_9.Settings.SensitivityAimFOVRatio then
					local v88 = workspace.CurrentCamera.FieldOfView / 70 * v_u_9.Settings.AimSens / 0.5
					v_u_6.MouseDeltaSensitivity = math.max(v88, 0.001)
				else
					local v89 = v_u_9.Settings.AimSens / 0.5
					v_u_6.MouseDeltaSensitivity = math.max(v89, 0.001)
				end
			end
			v87 = v87 + v_u_4.Heartbeat:Wait()
			if v83 <= v87 or not p81.Aiming then
				if not p81.Aiming then
					return
				end
				if v_u_9.Settings.SensitivityAimFOVRatio then
					local v90 = p81.CurAimFOV / 70 * v_u_9.Settings.AimSens / 0.5
					v_u_6.MouseDeltaSensitivity = math.max(v90, 0.001)
				else
					local v91 = v_u_9.Settings.AimSens / 0.5
					v_u_6.MouseDeltaSensitivity = math.max(v91, 0.001)
				end
				p81.FullyAimedIn = true
				if p81.Config.UsesScope then
					v_u_12:Scope(true)
					local v92 = p81.CurVM
					v92.offset = v92.offset * CFrame.new(0, 0, 10)
					return
				end
				::l52::
				return
			end
		end
	else
		if v_u_7.Character and (not v_u_6.MouseEnabled or v_u_6.GamepadEnabled) and p81.weaponTool.Parent == v_u_7.Character then
			v_u_14:ToggleAimAssist(true, 50)
		else
			v_u_14:ToggleAimAssist(false)
		end
		v_u_6.MouseDeltaSensitivity = 1
		p81.Animations.AimAnim:Stop()
		v_u_26:Visible(true)
		if v_u_13.CurrentCharacterActive and v_u_13.CurrentCharacterActive.MovingSprinting then
			p81:SprintAnimation(true)
		end
		if p81.Config.UsesScope then
			v_u_12:Scope(false)
			if p81.FullyAimedIn then
				local v93 = p81.CurVM
				v93.offset = v93.offset * CFrame.new(0, 0, -10)
			end
		end
		p81.FullyAimedIn = false
		if p81.CurBaseFOV then
			v_u_14:ChangeFOV(p81.CurBaseFOV - (p81.CurAimFOV or v_u_9.Settings.AimFOV), TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
		end
		goto l52
	end
end
function v_u_27.CancelReload(p94, p95)
	-- upvalues: (copy) v_u_26, (copy) v_u_7, (copy) v_u_13, (copy) v_u_9
	p94.Animations.ReloadAnim:Stop(p95 and 0 or 0.2)
	p94.Reloading = false
	v_u_26:ReloadBar(false)
	v_u_26:InstructReload(p94.CurAmmo <= 2, p94.CurAmmo <= 1, p94.CurAmmo <= 0)
	if v_u_7.Character and v_u_7.Character:FindFirstChild("Humanoid") then
		v_u_7.Character.Humanoid:SetAttribute("Reloading", false)
	end
	local v96 = v_u_13.CurrentCharacterActive
	if v96 and (v_u_9.Settings.AutoSprint or v96.SprintRequested) and not (v96.Dead or (v96.Sprinting or v96.Sliding)) then
		v96:Sprint(true)
	end
	if not p94.Aiming and (not v_u_13.CurrentCharacterActive or (not v_u_13.CurrentCharacterActive.MovingSprinting or v_u_13.CurrentCharacterActive.Sliding)) then
		v_u_26:MakeTransparent(false)
	end
end
function v_u_27.Reload(p97)
	-- upvalues: (copy) v_u_7, (copy) v_u_13, (copy) v_u_26, (copy) v_u_2, (copy) v_u_9
	if v_u_7.Character and v_u_7.Character:FindFirstChild("Humanoid") then
		if p97.Firing then
			p97.Firing = false
		end
		if p97.FiringMode == "Automatic" or os.clock() - p97.LastFire > 1 / p97.Config.Firerate then
			if p97.CurAmmo >= p97.Config.Ammo then
				return
			elseif p97.Reloading then
				return
			else
				if p97.Aiming then
					p97:Aim(false)
				end
				if v_u_13.CurrentCharacterActive and v_u_13.CurrentCharacterActive.Sprinting then
					v_u_13.CurrentCharacterActive:Sprint(false)
				end
				v_u_7.Character.Humanoid:SetAttribute("Reloading", true)
				v_u_26:InstructReload(false)
				v_u_26:MakeTransparent(true)
				v_u_26:ReloadBar(true, p97.Config.ReloadTime)
				p97.Animations.FireAnim:Stop(0.1)
				p97.Animations.FireAimedAnim:Stop(0.1)
				p97.Animations.InspectAnim:Stop(0.1)
				p97.Animations.EmptyInspectAnim:Stop(0.1)
				p97.Animations.SimpleInspectAnim:Stop(0.1)
				p97:SprintAnimation(false)
				p97.Reloading = true
				p97.ReloadCnt = (p97.ReloadCnt or 0) + 1
				local v98 = p97.ReloadCnt
				v_u_2.Remotes.Weapons.Gun.StartReload:FireServer()
				p97.Animations.ReloadAnim:Play()
				task.wait(p97.Config.ReloadTime)
				if v98 == p97.ReloadCnt and (p97.Reloading and (v_u_7.Character and v_u_7.Character:FindFirstChild("Humanoid"))) then
					v_u_7.Character.Humanoid:SetAttribute("Reloading", false)
					v_u_2.Remotes.Weapons.Gun.ReloadFinished:FireServer()
					local v99 = v_u_13.CurrentCharacterActive
					if v99 and not v99.Dead then
						if (v_u_9.Settings.AutoSprint or v99.SprintRequested) and not (v99.Sprinting or v99.Sliding) then
							v99:Sprint(true)
						end
						v_u_26:MakeTransparent(false)
						if v99.MovingSprinting and not v99.Sliding then
							p97:SprintAnimation(true)
						end
					end
					p97.Reloading = false
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u_27.Destroy(p100)
	p100:Unequip()
	p100.Maid:CleanUp()
end
function v_u_27.AutomaticFire(p101)
	if p101:CheckCanFire() then
		if p101.CurAmmo > 0 then
		end
	else
		return
	end
end
function v_u_27.SemiFire(p102)
	-- upvalues: (copy) v_u_26
	if p102.CurAmmo <= 0 then
		return
	elseif p102:CheckCanFire() then
		if os.clock() - p102.LastFire >= 1 / p102.Config.Firerate then
			p102.LastFire = os.clock()
			v_u_26:FirerateBar(true, 1 / p102.Config.Firerate)
			p102:Fire()
		end
	else
		return
	end
end
function v_u_27.BurstFire(p103)
	-- upvalues: (copy) v_u_4
	if os.clock() - p103.LastFire < 1 / p103.Config.Firerate then
		return
	elseif p103:CheckCanFire() then
		p103.LastFire = os.clock() + 1 / p103.Config.Firerate * 3
		local v104 = 0
		for _ = 1, 3 do
			if p103.CurAmmo <= 0 then
				return
			end
			p103:Fire()
			repeat
				v104 = v104 + v_u_4.Heartbeat:Wait()
			until 1 / p103.Config.Firerate <= v104
			v104 = v104 - 1 / p103.Config.Firerate
		end
	end
end
function v_u_27.Fire(p_u_105)
	-- upvalues: (copy) v_u_7, (copy) v_u_22, (copy) v_u_26, (copy) v_u_6, (copy) v_u_18, (copy) v_u_17, (copy) v_u_10, (copy) v_u_19, (copy) v_u_2, (copy) v_u_14
	if p_u_105.Aiming then
		p_u_105.Animations.FireAnim:Play()
	else
		p_u_105.Animations.FireAnim:Play()
	end
	if p_u_105.Reloading then
		p_u_105:CancelReload(true)
	end
	p_u_105.Animations.EquipAnim:Stop(0)
	p_u_105.Animations.InitialEquipAnim:Stop(0)
	p_u_105.Animations.InspectAnim:Stop(0)
	p_u_105.Animations.SimpleInspectAnim:Stop(0)
	p_u_105.Animations.EmptyInspectAnim:Stop(0)
	local v106 = RaycastParams.new()
	v106.FilterDescendantsInstances = { workspace.CurrentCamera, workspace.Debris, v_u_7.Character.Parent ~= workspace.Characters and v_u_7.Character.Parent or v_u_7.Character }
	if v_u_22.Cache.InShootingRange then
		for _, v107 in pairs(workspace.Characters:GetChildren()) do
			if v107:FindFirstChild("Humanoid") and (not v107:HasTag("Dummy") and v107 ~= v_u_7.Character) then
				v106:AddToFilter(v107)
			end
		end
	end
	v106.FilterType = Enum.RaycastFilterType.Exclude
	v106.CollisionGroup = "BulletsAndProjectiles"
	local v108 = workspace.CurrentCamera.CFrame
	local v109 = v108.Position
	local v110 = v108.LookVector
	if v_u_26.LerpedSpread > 0 then
		local v111 = v_u_26.LerpedSpread / 10
		if v_u_6.TouchEnabled and not (v_u_6.KeyboardEnabled or v_u_6.MouseEnabled) then
			v111 = v111 * 0.25
		end
		local v112 = CFrame.Angles
		local v113 = Random.new():NextNumber(-v111, v111)
		local v114 = math.rad(v113)
		local v115 = Random.new():NextNumber(-v111, v111)
		local v116 = math.rad(v115)
		local v117 = Random.new():NextNumber(-v111, v111)
		v110 = v112(v114, v116, (math.rad(v117))):VectorToWorldSpace(v110)
	end
	local v118 = v110 * p_u_105.Config.MaxRangeStuds
	local v119 = v109 + v118
	local v120 = nil
	local v121 = false
	local v122 = {}
	local v123 = {}
	local v124 = v_u_18(v109, v118, v106, { "Glass" })
	if #v124 ~= 0 then
		if #v124 > 1 then
			for v125 = 1, #v124 - 1 do
				if not v124[v125].Instance:GetAttribute("broken") then
					local v126 = v124[v125].Instance
					table.insert(v122, v126)
					local v127 = v124[v125].Position
					table.insert(v123, v127)
				end
			end
		end
		local v_u_128 = v124[#v124]
		local v129 = v_u_128.Instance:HasTag("Glass")
		if not v129 then
			v119 = v_u_128.Position
		end
		local v_u_130 = v_u_128.Instance
		if v_u_130.Parent.Name == "Trolled" then
			v_u_130 = v_u_130.Parent.Parent:FindFirstChild(v_u_130.Name)
		end
		if v_u_130.Parent:FindFirstChild("Humanoid") and (v_u_130.Parent.Parent ~= v_u_7.Character.Parent or not (v_u_17.CurrentMatch and v_u_17.CurrentMatch.Arena)) and v_u_130.Parent.Parent ~= workspace.Debris.Ragdolls then
			local v_u_131 = v_u_130
			task.defer(function()
				-- upvalues: (ref) v_u_131, (copy) p_u_105, (ref) v_u_130, (ref) v_u_10, (copy) v_u_128, (ref) v_u_26
				local v132
				if v_u_131.Name == "Head" then
					v132 = p_u_105.Config.Damage.Head
				elseif v_u_131.Name == "Left Leg" or v_u_131.Name == "Right Leg" then
					v132 = p_u_105.Config.Damage.Lower
				else
					v132 = p_u_105.Config.Damage.Upper
				end
				local v133 = v_u_130.Parent.Humanoid.Health - v132 <= 0
				v_u_10:VisualizeCharacterHitEffect(v133, v_u_128.Position, "Gun", v_u_130.Name == "Head")
				if not v133 then
					v_u_10:DamageHighlight(v_u_131.Parent, false)
				end
				v_u_10:DmgIndicator(v_u_128.Position, v132)
				v_u_26:Hitmarker(v_u_131.Name == "Head", v133)
			end)
			v120 = v_u_131
		elseif v129 then
			if not v_u_130:GetAttribute("broken") then
				local v134 = v124[#v124].Instance
				table.insert(v122, v134)
				local v135 = v124[#v124].Position
				table.insert(v123, v135)
			end
		else
			v121 = true
		end
	end
	local v136 = nil
	local v137 = nil
	local v138 = nil
	if p_u_105.Aiming and os.clock() - p_u_105.LastAim < 0.55 then
		v136 = true
	elseif not p_u_105.Aiming then
		v137 = true
	end
	local v139 = v_u_7.Character.Humanoid.FloorMaterial == Enum.Material.Air and true or v138
	if v122 then
		for v140, v141 in pairs(v122) do
			v_u_19:BreakGlass(v141, v123[v140], v118.Unit)
		end
	end
	local v142 = v_u_2.Remotes.Weapons.Gun.Fire
	local v143 = workspace:GetServerTimeNow()
	local v144
	if v122 and #v122 ~= 0 then
		v144 = v_u_19:GlassReplicate_NewId(v122)
	else
		v144 = nil
	end
	v142:FireServer(v143, v109, v119, v120, v144, v136, v137, v139)
	local v145 = p_u_105.weaponTool:GetAttribute("UnusualTracer")
	local v146 = v_u_10
	local v147 = v_u_7.Character
	local v148 = p_u_105.weaponTool.ToolHandle.Muzzle.WorldCFrame.Position
	local v149
	if #v124 == 0 then
		v149 = nil
	else
		v149 = v124[#v124]
	end
	v146:VisualizeBullet(v147, v148, v119, v121, v149, true, v145)
	v_u_14:Recoil()
	v_u_10:Muzzle(p_u_105.weaponTool.ToolHandle.Muzzle, v145)
	v_u_10:GunFiringSound(p_u_105.weaponTool.ToolHandle.SoundPoint, v145)
end
function v_u_27.SprintAnimation(p_u_150, p151, p152)
	-- upvalues: (copy) v_u_13, (copy) v_u_7
	if p_u_150.CurVM then
		local v153 = task.spawn
		local v154 = p_u_150.CurVM.SetBobbingEnabled
		local v155 = p_u_150.CurVM
		local v156 = (p151 and true or false) and (v_u_13.CurrentCharacterActive and not v_u_13.CurrentCharacterActive.Dead)
		if v156 then
			v156 = v_u_13.CurrentCharacterActive.Character.Humanoid:GetAttribute("Inspecting")
		end
		v153(v154, v155, v156)
	end
	if p151 then
		if not (p_u_150.Animations.SprintingAnim.IsPlaying or p_u_150.Animations.SprintInAnim.IsPlaying) then
			p_u_150.SprintAnimInitiatedCnt = p_u_150.SprintAnimInitiatedCnt + 1
			local v_u_157 = p_u_150.SprintAnimInitiatedCnt
			local v_u_158 = p_u_150.EquipCnt
			p_u_150.Animations.SprintInAnim:Play()
			p_u_150.Animations.SprintInAnim:AdjustSpeed(p_u_150.Config.SprintIn ^ (-1))
			task.delay(p_u_150.Animations.SprintInAnim.Length * p_u_150.Config.SprintIn - 0.1, function()
				-- upvalues: (copy) v_u_157, (copy) p_u_150, (ref) v_u_7, (copy) v_u_158
				if v_u_157 == p_u_150.SprintAnimInitiatedCnt then
					if p_u_150.weaponTool and (v_u_7.Character and (p_u_150.weaponTool.Parent == v_u_7.Character and v_u_158 == p_u_150.EquipCnt)) then
						p_u_150.Animations.SprintingAnim:Play()
					end
				else
					return
				end
			end)
		end
	elseif p_u_150.Animations.SprintingAnim.IsPlaying or p_u_150.Animations.SprintInAnim.IsPlaying then
		p_u_150.SprintAnimInitiatedCnt = p_u_150.SprintAnimInitiatedCnt + 1
		local v159 = not p152
		if v159 then
			v159 = p_u_150.Animations.SprintingAnim.IsPlaying
		end
		p_u_150.Animations.SprintInAnim:Stop()
		p_u_150.Animations.SprintingAnim:Stop()
		if v159 then
			p_u_150.Animations.SprintOutAnim:Play()
			p_u_150.Animations.SprintOutAnim:AdjustSpeed(p_u_150.Config.SprintOut ^ (-1))
		end
	end
end
function v_u_27.Unequip(p160)
	-- upvalues: (copy) v_u_25, (copy) v_u_12, (copy) v_u_14, (copy) v_u_3, (copy) v_u_4, (copy) v_u_6, (copy) v_u_26
	p160.Equipping = false
	table.clear(p160.BufferedInputs)
	if not v_u_25.Value then
		v_u_12.MobileControls.Gun.Visible = false
	end
	p160.MobileControlButtonConnections:CleanUp()
	v_u_14:ToggleAimAssist(false)
	v_u_3:UnbindAction("FireWeapon")
	v_u_3:UnbindAction("AimWeapon")
	v_u_3:UnbindAction("Q_AimWeapon")
	v_u_3:UnbindAction("InspectWeapon")
	v_u_3:UnbindAction("ReloadWeapon")
	v_u_4:UnbindFromRenderStep("GunSpread")
	if p160.Aiming then
		p160:Aim(false)
	end
	v_u_6.MouseDeltaSensitivity = 1
	if p160.Reloading then
		p160:CancelReload()
	end
	if p160.Config.GUN_DEBUG_MODE then
		p160.DebugUI.Enabled = false
	end
	v_u_26:Deactivate()
	for _, v161 in pairs(p160.Animations) do
		v161:Stop(0)
	end
	p160:UnequipViewmodel()
end
return v_u_27
