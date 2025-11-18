-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ContextActionService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("SoundService")
local v_u_6 = require(script.Parent)
local v_u_7 = setmetatable({}, v_u_6)
v_u_7.__index = v_u_7
local v_u_8 = require(v_u_2.Modules.Configs.Settings.InputMap)
local v_u_9 = require(v_u_2.Modules.Controllers.CrosshairController)
local v_u_10 = require(v_u_2.Modules.Controllers.Effects)
local v_u_11 = require(v_u_2.Modules.Shared.Buffer)
local v_u_12 = require(v_u_2.Modules.Shared.Maid)
local v_u_13 = require(v_u_2.Modules.Controllers.CharacterController)
local v_u_14 = require(v_u_2.Modules.Controllers.CharacterController.WalkspeedHandler)
local v_u_15 = require(v_u_2.Modules.Shared.ProjectileService)
local v_u_16 = require(v_u_2.Modules.Controllers.MatchController)
local v_u_17 = require(v_u_2.Modules.Misc.GlassBreak)
local v_u_18 = require(v_u_2.Modules.Controllers.UIController)
local v_u_19 = require(v_u_2.Modules.Controllers.CameraController)
local v_u_20 = require(v_u_2.Modules.Configs.Settings.SettingsMain)
local v_u_21 = require(v_u_2.Modules.Controllers.EnvironmentalSound)
local v_u_22 = require(v_u_2.Modules.Main.ClientData)
local v_u_23 = v_u_2.Remotes.Weapons.Inspect
local v_u_24 = v_u_2.Variables.Client.ClEditingMobileHUD
local v_u_25 = { "Equip", "Inspect", "SimpleInspect" }
local v_u_26 = game:GetService("Players").LocalPlayer
function v_u_7.new(p27)
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_26, (copy) v_u_12, (copy) v_u_25, (copy) v_u_2, (copy) v_u_21, (copy) v_u_5, (copy) v_u_23, (copy) v_u_13, (copy) v_u_9
	local v28 = v_u_6.new(p27)
	local v29 = v_u_7
	local v_u_30 = setmetatable(v28, v29)
	local v_u_31 = v_u_26.Character
	local v_u_32 = v_u_31.Humanoid
	local v33 = v_u_32.Animator
	v_u_30.MobileButtonsConnectionsMaid = v_u_12.new()
	v_u_30.Animations = {}
	v_u_30.SwingAnimations = {}
	v_u_30.BufferedInputs = {}
	v_u_30.weaponTool:WaitForChild("Animations")
	v_u_30.Animations.EquipAnim = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("Equip"))
	v_u_30.Animations.IdleAnim = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("Idle"))
	v_u_30.Animations.InspectAnim = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("Inspect"))
	v_u_30.Animations.SimpleInspectAnim = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("SimpleInspect"))
	local v34 = v_u_30.Animations
	local v35
	if v_u_30.Config.NoSprintTransition then
		v35 = nil
	else
		v35 = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("SprintIn"))
	end
	v34.SprintInAnim = v35
	v_u_30.Animations.SprintingAnim = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("Sprint"))
	local v36 = v_u_30.Animations
	local v37
	if v_u_30.Config.NoSprintTransition then
		v37 = nil
	else
		v37 = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("SprintOut"))
	end
	v36.SprintOutAnim = v37
	v_u_30.Animations.ReadyThrowAnim = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("ReadyThrow"))
	v_u_30.Animations.ThrowIdleAnim = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("ThrowIdle"))
	v_u_30.Animations.ThrowAnim = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("Throw"))
	for _, v38 in pairs(v_u_30.Animations) do
		if table.find(v_u_25, v38.Name) then
			v38.KeyframeReached:Connect(function(p39)
				-- upvalues: (copy) v_u_30, (ref) v_u_2, (ref) v_u_21, (ref) v_u_5
				if v_u_30.Config.KeyframeFoleySounds[p39] then
					v_u_2.Remotes.Weapons.PlayFoley:FireServer(p39)
					local v40 = v_u_30.weaponTool.ToolHandle.SoundPoint:FindFirstChild(p39)
					if v40 then
						v_u_21:SetSoundGroup(v40, v_u_5.Game.World.Weapons.Firearm.Foley, v_u_30.weaponTool.ToolHandle.CFrame.Position)
						v40:Play()
					end
				end
			end)
		end
	end
	v_u_30.SwingAnimations[1] = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("Swing1"))
	v_u_30.SwingAnimations[2] = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("Swing2"))
	v_u_30.SwingAnimations[3] = v33:LoadAnimation(v_u_30.weaponTool.Animations:WaitForChild("Swing3"))
	v_u_30.ConnectionsMaid = v_u_12.new()
	v_u_30.EquipAnimCnt = 0
	v_u_30.TimeSwingCooldownEnded = 0
	v_u_30.MB1SwingRequestCnt = 0
	v_u_30.SprintAnimInitiatedCnt = 0
	v_u_30.CurrentSwing = 1
	v_u_30.MB1Swinging = false
	v_u_30.KnifeInHand = true
	v_u_30.ReadyingThrow = false
	v_u_30.CanThrow = false
	v_u_30.Throwing = false
	local function v41()
		-- upvalues: (ref) v_u_23, (ref) v_u_13, (ref) v_u_9, (copy) v_u_30
		v_u_23:FireServer(false)
		if v_u_13.CurrentCharacterActive and (v_u_13.CurrentCharacterActive.Character and not v_u_13.CurrentCharacterActive.Dead) then
			v_u_13.CurrentCharacterActive.Character.Humanoid:SetAttribute("Inspecting", false)
			if v_u_13.CurrentCharacterActive.Sliding then
				v_u_9:Visible(true)
			elseif v_u_13.CurrentCharacterActive.MovingSprinting then
				v_u_9:MakeTransparent(true)
			else
				v_u_9:Visible(true)
			end
		end
		if v_u_30.CurVM and v_u_13.CurrentCharacterActive then
			task.spawn(v_u_30.CurVM.SetBobbingEnabled, v_u_30.CurVM, not v_u_13.CurrentCharacterActive.Sprinting)
		end
	end
	v_u_30.Animations.InspectAnim.Ended:Connect(v41)
	v_u_30.Animations.SimpleInspectAnim.Ended:Connect(v41)
	v_u_30.Animations.ThrowAnim.KeyframeReached:Connect(function(p42)
		-- upvalues: (copy) v_u_30
		if p42 == "throw" then
			v_u_30:ActualThrow()
		end
	end)
	p27.Destroying:Connect(function()
		-- upvalues: (copy) v_u_30
		v_u_30:Destroy()
	end)
	v_u_30.ConnectionsMaid:GiveTask(v_u_32:GetAttributeChangedSignal("Sprinting"):Connect(function()
		-- upvalues: (copy) v_u_30, (copy) v_u_31, (copy) v_u_32
		if v_u_30.weaponTool.Parent == v_u_31 then
			if v_u_32:GetAttribute("Sprinting") then
				if v_u_30.ReadyingThrow or v_u_30.CanThrow then
					v_u_30:ReadyThrow(false, true)
				end
				v_u_30:SprintAnimation(true, false)
			elseif not (v_u_30.ReadyingThrow or v_u_30.CanThrow) then
				v_u_30:SprintAnimation(false, false)
			end
		else
			return
		end
	end))
	v_u_30.ConnectionsMaid:GiveTask(v_u_32:GetAttributeChangedSignal("Sliding"):Connect(function()
		-- upvalues: (copy) v_u_30, (copy) v_u_31, (ref) v_u_13, (copy) v_u_32
		if v_u_30.weaponTool.Parent == v_u_31 then
			if v_u_13.CurrentCharacterActive and v_u_13.CurrentCharacterActive.Character then
				if v_u_32:GetAttribute("Sliding") then
					v_u_30:SprintAnimation(false, true)
				elseif v_u_13.CurrentCharacterActive.MovingSprinting then
					v_u_30:SprintAnimation(true, true)
				end
			else
				return
			end
		else
			return
		end
	end))
	return v_u_30
end
function v_u_7.EquipAnim(p_u_43)
	-- upvalues: (copy) v_u_9, (copy) v_u_26, (copy) v_u_13
	p_u_43.EquipAnimCnt = p_u_43.EquipAnimCnt + 1
	p_u_43.CurrentSwing = 1
	local v_u_44 = p_u_43.EquipAnimCnt
	p_u_43:Visible(true)
	p_u_43.Animations.EquipAnim:Play()
	p_u_43:EquipViewmodel()
	v_u_9:Activate("Melee")
	task.delay(p_u_43.Animations.EquipAnim.Length - 0.1, function()
		-- upvalues: (copy) v_u_44, (copy) p_u_43, (ref) v_u_26, (ref) v_u_13
		if v_u_44 == p_u_43.EquipAnimCnt and p_u_43.weaponTool.Parent == v_u_26.Character then
			if v_u_13.CurrentCharacterActive and (v_u_13.CurrentCharacterActive.Character and not v_u_13.CurrentCharacterActive.Dead) then
				p_u_43.Animations.IdleAnim:Play()
				if v_u_13.CurrentCharacterActive.MovingSprinting then
					p_u_43:SprintAnimation(true, true)
				end
			end
		else
			return
		end
	end)
end
function v_u_7.CheckAndInitiateBufferedInputs(p45)
	if #p45.BufferedInputs == 0 then
		return
	elseif p45.BufferedInputs[#p45.BufferedInputs] == "Swing" then
		if not p45.MB1Swinging then
			p45:StartSwinging()
		end
	else
		if p45.BufferedInputs[#p45.BufferedInputs] == "StartThrow" then
			p45:ReadyThrow(true)
		end
		return
	end
end
function v_u_7.Equip(p_u_46)
	-- upvalues: (copy) v_u_20, (copy) v_u_13, (copy) v_u_1, (copy) v_u_26, (copy) v_u_8, (copy) v_u_18, (copy) v_u_24, (copy) v_u_14
	p_u_46.Equipping = true
	if v_u_20.Settings.AutoSprint and (v_u_13.CurrentCharacterActive and not (v_u_13.CurrentCharacterActive.Dead or v_u_13.CurrentCharacterActive.Sprinting)) then
		v_u_13.CurrentCharacterActive:Sprint(true)
	end
	local v47 = v_u_1
	local function v49(_, p48)
		-- upvalues: (copy) p_u_46, (ref) v_u_26
		if p_u_46.weaponTool.Parent == v_u_26.Character then
			if p48 == Enum.UserInputState.Begin then
				if p_u_46.MB1Swinging then
					return
				elseif p_u_46.Equipping or (not p_u_46.KnifeInHand or (p_u_46.ReadyingThrow or (p_u_46.Throwing or p_u_46.CanThrow))) then
					p_u_46:AddToBufferedInputs("Swing")
				else
					p_u_46:StartSwinging()
				end
			else
				if p48 == Enum.UserInputState.End then
					p_u_46:CheckAndRemoveFromBufferedInputs("Swing")
					p_u_46.MB1Swinging = false
				end
				return
			end
		else
			return
		end
	end
	local v50 = v_u_8.Fire
	v47:BindAction("SwingMelee", v49, false, table.unpack(v50))
	p_u_46.MobileButtonsConnectionsMaid:GiveTask(v_u_18.MobileControls.Knife.Swing.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_24, (copy) p_u_46
		if v_u_24.Value then
			return
		elseif not p_u_46.MB1Swinging then
			p_u_46:Swing()
		end
	end))
	local v51 = v_u_1
	local function v53(_, p52)
		-- upvalues: (copy) p_u_46, (ref) v_u_26
		if p52 == Enum.UserInputState.Begin and (p_u_46.KnifeInHand and not (p_u_46.ReadyingThrow or p_u_46.Throwing)) then
			if p_u_46.weaponTool.Parent ~= v_u_26.Character then
				return
			end
			p_u_46:Inspect()
		end
	end
	local v54 = v_u_8.Inspect
	v51:BindAction("InspectMelee", v53, false, table.unpack(v54))
	p_u_46.MobileButtonsConnectionsMaid:GiveTask(v_u_18.MobileControls.Knife.Inspect.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_24, (copy) p_u_46, (ref) v_u_26
		if not v_u_24.Value then
			if p_u_46.KnifeInHand and not (p_u_46.ReadyingThrow or p_u_46.Throwing) then
				if p_u_46.weaponTool.Parent ~= v_u_26.Character then
					return
				end
				p_u_46:Inspect()
			end
		end
	end))
	v_u_14:ChangeWS(p_u_46.Config.WalkspeedModifier)
	if p_u_46.KnifeInHand then
		p_u_46:EquipAnim()
	end
	if not v_u_24.Value then
		v_u_18.MobileControls.Knife.Visible = true
	end
	local v55 = p_u_46.EquipAnimCnt
	task.wait(p_u_46.Config.EquipTime)
	if v55 == p_u_46.EquipAnimCnt and p_u_46.weaponTool.Parent == v_u_26.Character then
		p_u_46.Equipping = false
		p_u_46:CheckAndInitiateBufferedInputs()
	end
end
function v_u_7.ReadyThrow(p56, p57, p58)
	-- upvalues: (copy) v_u_13, (copy) v_u_20, (copy) v_u_3, (copy) v_u_4, (copy) v_u_19
	if p56.Config.CanThrow then
		if p56.ReadyingThrow == p57 and not p58 then
			return
		elseif p56:CheckCanFire() then
			if p56.Throwing then
				return
			elseif not p57 or p56.KnifeInHand then
				if v_u_13.CurrentCharacterActive and not v_u_13.CurrentCharacterActive.Dead then
					if p57 and v_u_13.CurrentCharacterActive.Sprinting then
						v_u_13.CurrentCharacterActive:Sprint(false)
					elseif not p57 and (v_u_20.Settings.AutoSprint and not (v_u_13.CurrentCharacterActive.Sprinting or v_u_13.CurrentCharacterActive.Sliding)) then
						v_u_13.CurrentCharacterActive:Sprint(true)
					end
				end
				p56.ReadyingThrow = p57
				if p56.ReadyingThrow then
					p56.CanThrow = false
					p56:SprintAnimation(false, true)
					p56.Animations.InspectAnim:Stop(0)
					p56.Animations.SimpleInspectAnim:Stop(0)
					p56.Animations.EquipAnim:Stop(0)
					p56.Animations.ReadyThrowAnim:Play(0)
					local v59 = 0
					while v59 < p56.Config.ReadyThrowTime and p56.ReadyingThrow do
						v59 = v59 + v_u_3.Heartbeat:Wait()
					end
					if not p56.ReadyingThrow then
						return
					end
					p56.CanThrow = true
					p56.ReadyingThrow = false
					p56.Animations.ThrowIdleAnim:Play()
					if (not v_u_4.MouseEnabled or v_u_4.GamepadEnabled) and v_u_20.Settings.AimAssist then
						v_u_19:ToggleAimAssist(true, 500)
						return
					end
				else
					v_u_19:ToggleAimAssist(false)
					p56.CanThrow = false
					p56.Animations.ThrowIdleAnim:Stop()
					p56.Animations.ReadyThrowAnim:Stop(0)
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u_7.Visible(p60, p61)
	for _, v62 in pairs(p60.weaponTool.Knife:GetChildren()) do
		if v62:IsA("BasePart") then
			if p61 then
				v62.Transparency = v62:GetAttribute("cl_ogt") or v62.Transparency
			else
				v62:SetAttribute("cl_ogt", v62.Transparency)
				v62.Transparency = 1
			end
		end
	end
end
function v_u_7.ActualThrow(p_u_63)
	-- upvalues: (copy) v_u_26, (copy) v_u_15, (copy) v_u_2, (copy) v_u_10, (copy) v_u_9, (copy) v_u_17
	p_u_63.KnifeInHand = false
	p_u_63.Throwing = false
	p_u_63:Visible(false)
	local v64 = RaycastParams.new()
	v64.FilterType = Enum.RaycastFilterType.Exclude
	v64.CollisionGroup = "BulletsAndProjectiles"
	v64.FilterDescendantsInstances = { workspace.Debris, v_u_26.Character.Parent ~= workspace.Characters and v_u_26.Character.Parent or v_u_26.Character }
	local v_u_65 = v_u_15.new(v_u_2.Assets.Projectiles.MeleeProjectiles[p_u_63.weaponTool:GetAttribute("Projectile")], v64, p_u_63.Config.ProjectileSettings)
	v_u_65.OnHit(function(p66, p67)
		-- upvalues: (copy) p_u_63, (ref) v_u_10, (ref) v_u_9, (ref) v_u_2
		local v68 = p66.Instance.Parent:FindFirstChild("Humanoid")
		if v68 then
			local v69 = v68.RootPart
			if v69 and v69.Parent.Parent ~= workspace.Debris.Ragdolls then
				local v70 = p_u_63.Config.Damage.Throw
				local v71 = v68.Health - v70 <= 0
				v_u_10:VisualizeCharacterHitEffect(v71, p66.Position, "MeleeThrow")
				v_u_9:Hitmarker(p66.Instance.Name == "Head", v71)
				v_u_10:DmgIndicator(p66.Position, p_u_63.Config.Damage.Throw)
				if not v71 then
					v_u_10:DamageHighlight(v68.Parent, false)
				end
				v_u_2.Remotes.Weapons.Melee.ThrowHit:FireServer(v68, v69.CFrame, p66.Instance.Name == "Head")
			end
		end
		task.wait(1)
		p67:Destroy()
	end)
	v_u_65.OnGlassBreak(function(p72)
		-- upvalues: (ref) v_u_17, (copy) v_u_65, (ref) v_u_2
		v_u_17:BreakGlass(p72.Instance, p72.Position, v_u_65.cur_projectile_direction_unit)
		v_u_2.Remotes.Weapons.Melee.ThrowHitGlass:FireServer(p72.Instance.Name, v_u_17:GlassReplicate_NewId({ p72.Instance }))
	end)
	local v73 = workspace.CurrentCamera.CFrame.Position
	local v74 = workspace.CurrentCamera.CFrame.LookVector
	v_u_2.Remotes.Weapons.Melee.Throw:FireServer(workspace:GetServerTimeNow(), v73, v74)
	task.spawn(v_u_65.Shoot, v_u_65, v73, v74)
	task.wait(1)
	p_u_63.KnifeInHand = true
	if p_u_63.weaponTool.Parent == v_u_26.Character then
		p_u_63:EquipAnim()
		p_u_63:CheckAndInitiateBufferedInputs()
	end
end
function v_u_7.Throw(p75)
	-- upvalues: (copy) v_u_20, (copy) v_u_13, (copy) v_u_19
	if p75.CanThrow then
		if p75.KnifeInHand then
			if v_u_20.Settings.AutoSprint and (v_u_13.CurrentCharacterActive and not (v_u_13.CurrentCharacterActive.Dead or v_u_13.CurrentCharacterActive.Sprinting)) then
				v_u_13.CurrentCharacterActive:Sprint(true)
			end
			v_u_19:ToggleAimAssist(false)
			p75.CanThrow = false
			p75.Throwing = true
			for _, v76 in pairs(p75.Animations) do
				v76:Stop(0)
			end
			p75.Animations.ThrowAnim:Play(0)
		end
	else
		return
	end
end
function v_u_7.SwingRaycast(p77)
	-- upvalues: (copy) v_u_26, (copy) v_u_22
	local v78 = RaycastParams.new()
	v78.FilterType = Enum.RaycastFilterType.Exclude
	v78.FilterDescendantsInstances = { workspace.Debris, v_u_26.Character.Parent ~= workspace.Characters and v_u_26.Character.Parent or v_u_26.Character }
	if v_u_22.Cache.InShootingRange then
		for _, v79 in pairs(workspace.Characters:GetChildren()) do
			if v79:FindFirstChild("Humanoid") and (not v79:HasTag("Dummy") and v79 ~= v_u_26.Character) then
				v78:AddToFilter(v79)
			end
		end
	end
	local v80 = workspace.CurrentCamera.CFrame
	local v81 = workspace.CurrentCamera.CFrame.LookVector * p77.Config.Range
	local v82 = workspace:Raycast(v80.Position, v81, v78)
	local v83
	if v82 then
		v83 = false
	else
		v82 = workspace:Blockcast(v80, Vector3.new(4, 4, 1), v81, v78)
		v83 = true
	end
	return v82, v83
end
function v_u_7.StartSwinging(p84)
	p84.MB1SwingRequestCnt = p84.MB1SwingRequestCnt + 1
	local v85 = p84.MB1SwingRequestCnt
	p84.MB1Swinging = true
	while p84.MB1Swinging and (p84.MB1SwingRequestCnt == v85 and (not p84.CanThrow and (not p84.ReadyingThrow and (p84.KnifeInHand and (not p84.Throwing and p84:CheckCanFire()))))) do
		task.wait(p84:Swing())
	end
end
function v_u_7.Swing(p_u_86)
	-- upvalues: (copy) v_u_21, (copy) v_u_5, (copy) v_u_26, (copy) v_u_16, (copy) v_u_10, (copy) v_u_9, (copy) v_u_2, (copy) v_u_17, (copy) v_u_11
	if os.clock() - p_u_86.TimeSwingCooldownEnded < 0 then
		return p_u_86.TimeSwingCooldownEnded - os.clock()
	end
	if p_u_86.ReadyingThrow or (p_u_86.Throwing or (p_u_86.CanThrow or not p_u_86.KnifeInHand)) then
		return 0
	end
	p_u_86.Animations.ReadyThrowAnim:Stop(0)
	p_u_86.Animations.ThrowIdleAnim:Stop(0)
	p_u_86.Animations.ThrowAnim:Stop(0)
	p_u_86.Animations.InspectAnim:Stop(0)
	p_u_86.Animations.SimpleInspectAnim:Stop(0)
	local v87 = p_u_86.SwingAnimations[p_u_86.CurrentSwing]
	local v88 = p_u_86.CurrentSwing
	local v89 = p_u_86.CurrentSwing == p_u_86.Config.Swings
	local v90 = v89 and p_u_86.Config.SwingLungeCooldown or p_u_86.Config.SwingCooldown
	p_u_86.CurrentSwing = p_u_86.CurrentSwing + 1 > p_u_86.Config.Swings and 1 or p_u_86.CurrentSwing + 1
	p_u_86.TimeSwingCooldownEnded = os.clock() + v90
	local v_u_91 = p_u_86.TimeSwingCooldownEnded
	for _, v92 in pairs(p_u_86.SwingAnimations) do
		v92:Stop(0)
	end
	v87:Play(0)
	local v93 = p_u_86.weaponTool.ToolHandle.SoundPoint:FindFirstChild(string.format("Swing%03i", v88))
	if v93 then
		v_u_21:SetSoundGroup(v93, v_u_5.Game.World.Weapons.Melee.Swing, p_u_86.weaponTool.ToolHandle.SoundPoint.CFrame.Position)
		v93:Play()
	end
	local v94 = buffer.create(1)
	buffer.writeu8(v94, 0, v88)
	local v95 = false
	local v96, v97 = p_u_86:SwingRaycast()
	if v96 then
		local v98 = v96.Instance.Parent:FindFirstChild("Humanoid")
		if v98 then
			if (v98.Parent.Parent ~= v_u_26.Character.Parent or not (v_u_16.CurrentMatch and v_u_16.CurrentMatch.Arena)) and v98.Parent.Parent ~= workspace.Debris.Ragdolls then
				local v99
				if v89 then
					v99 = p_u_86.Config.Damage.Lunge
				else
					v99 = p_u_86.Config.Damage.Default
				end
				local v100 = v98.Health - v99 <= 0
				v_u_10:VisualizeCharacterHitEffect(v100, v96.Position, "Melee")
				v_u_9:Hitmarker(v89, v100, v100 and 0.6 or 1)
				v_u_10:DmgIndicator(v96.Position, v89 and p_u_86.Config.Damage.Lunge or p_u_86.Config.Damage.Default)
				if not v100 then
					v_u_10:DamageHighlight(v98.Parent, false)
				end
				v_u_2.Remotes.Weapons.Melee.Swing:FireServer(workspace:GetServerTimeNow(), v98, v94)
				v95 = true
			end
		elseif not v97 then
			local v101
			if v96.Instance:HasTag("Glass") and not v96.Instance:GetAttribute("broken") then
				v101 = v_u_17:GlassReplicate_NewId({ v96.Instance })
				v_u_17:BreakGlass(v96.Instance, v96.Position, workspace.CurrentCamera.CFrame.LookVector)
			else
				v101 = nil
			end
			v_u_2.Remotes.Weapons.Melee.Swing:FireServer(workspace:GetServerTimeNow(), v96.Position, v_u_11.writeSmallUnitVector3(v96.Normal), v94, v101 and {
				["i"] = v101,
				["d"] = workspace.CurrentCamera.CFrame.LookVector,
				["n"] = v96.Instance.Name
			} or nil)
			v95 = true
		end
	end
	if not v95 then
		v_u_2.Remotes.Weapons.Melee.Swing:FireServer(workspace:GetServerTimeNow(), v94)
	end
	task.delay(v90 + p_u_86.Config.TimeBeforeSwingReset, function()
		-- upvalues: (copy) v_u_91, (copy) p_u_86
		if v_u_91 == p_u_86.TimeSwingCooldownEnded then
			p_u_86.CurrentSwing = 1
		end
	end)
	return v90
end
function v_u_7.Inspect(p102)
	-- upvalues: (copy) v_u_13, (copy) v_u_23, (copy) v_u_9, (copy) v_u_20
	if p102.Animations.InspectAnim.IsPlaying or p102.Animations.SimpleInspectAnim.IsPlaying then
		return
	elseif p102.MB1Swinging then
		return
	elseif v_u_13.CurrentCharacterActive and (v_u_13.CurrentCharacterActive.Character and not v_u_13.CurrentCharacterActive.Dead) then
		v_u_23:FireServer(true)
		if p102.CurVM then
			task.spawn(p102.CurVM.SetBobbingEnabled, p102.CurVM, true)
		end
		v_u_13.CurrentCharacterActive.Character.Humanoid:SetAttribute("Inspecting", true)
		v_u_9:Visible(false)
		p102.Animations[v_u_20.Settings.SimpleInspects and "SimpleInspectAnim" or "InspectAnim"]:Play()
	end
end
function v_u_7.SprintAnimation(p_u_103, p104, p105)
	-- upvalues: (copy) v_u_13
	if p_u_103.CurVM and not (p_u_103.Animations.InspectAnim.IsPlaying or p_u_103.Animations.SimpleInspectAnim.IsPlaying) then
		task.spawn(p_u_103.CurVM.SetBobbingEnabled, p_u_103.CurVM, not p104)
	end
	local v106 = p_u_103.Config.NoSprintTransition and true or p105
	if p104 then
		if p_u_103.Animations.SprintingAnim.IsPlaying or not p_u_103.Config.NoSprintTransition and p_u_103.Animations.SprintInAnim.IsPlaying then
			return
		else
			p_u_103.SprintAnimInitiatedCnt = p_u_103.SprintAnimInitiatedCnt + 1
			local v_u_107 = p_u_103.SprintAnimInitiatedCnt
			if v106 then
				p_u_103.Animations.SprintingAnim:Play(nil, nil, p_u_103.Config.SprintSpeed or 1)
			else
				p_u_103.Animations.SprintInAnim:Play()
				p_u_103.Animations.SprintInAnim:AdjustSpeed(p_u_103.Config.SprintInTransitionTime ^ (-1))
				task.delay(p_u_103.Animations.SprintInAnim.Length * p_u_103.Config.SprintInTransitionTime - 0.1, function()
					-- upvalues: (copy) v_u_107, (copy) p_u_103, (ref) v_u_13
					if v_u_107 == p_u_103.SprintAnimInitiatedCnt and (v_u_13.CurrentCharacterActive and (v_u_13.CurrentCharacterActive.Character and (not v_u_13.CurrentCharacterActive.Dead and p_u_103.weaponTool.Parent == v_u_13.CurrentCharacterActive.Character))) then
						p_u_103.Animations.SprintingAnim:Play(nil, nil, p_u_103.Config.SprintSpeed or 1)
					end
				end)
			end
		end
	elseif p_u_103.Config.NoSprintTransition or (p_u_103.Animations.SprintingAnim.IsPlaying or p_u_103.Animations.SprintInAnim.IsPlaying) then
		p_u_103.SprintAnimInitiatedCnt = p_u_103.SprintAnimInitiatedCnt + 1
		local v108 = not v106
		if v108 then
			v108 = p_u_103.Animations.SprintingAnim.IsPlaying
		end
		if p_u_103.Animations.SprintInAnim then
			p_u_103.Animations.SprintInAnim:Stop()
			p_u_103.Animations.SprintingAnim:Stop(p_u_103.Config.SprintOutTransitionTime)
		end
		if v108 then
			p_u_103.Animations.SprintOutAnim:Play()
			p_u_103.Animations.SprintOutAnim:AdjustSpeed(p_u_103.Config.SprintOutTransitionTime ^ (-1))
		end
	end
end
function v_u_7.Unequip(p109)
	-- upvalues: (copy) v_u_19, (copy) v_u_24, (copy) v_u_18, (copy) v_u_14, (copy) v_u_9, (copy) v_u_1
	p109.Equipping = false
	p109.MB1Swinging = false
	p109.ReadyingThrow = false
	p109.CanThrow = false
	p109.Throwing = false
	table.clear(p109.BufferedInputs)
	v_u_19:ToggleAimAssist(false)
	if not v_u_24.Value then
		v_u_18.MobileControls.Knife.Visible = false
	end
	p109.MobileButtonsConnectionsMaid:CleanUp()
	v_u_14:ChangeWS(-p109.Config.WalkspeedModifier)
	v_u_9:Deactivate()
	v_u_1:UnbindAction("SwingMelee")
	v_u_1:UnbindAction("InspectMelee")
	p109:UnequipViewmodel()
	for _, v110 in pairs(p109.Animations) do
		v110:Stop()
	end
	for _, v111 in pairs(p109.SwingAnimations) do
		v111:Stop()
	end
end
function v_u_7.Destroy(p112)
	p112.ConnectionsMaid:CleanUp()
	p112:Unequip()
end
return v_u_7
