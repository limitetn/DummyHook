-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("GuiService")
local v_u_4 = game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("RunService")
local v_u_7 = game:GetService("SoundService")
local v_u_8 = require(v_u_4.Modules.Configs.Settings.InputMap)
local v_u_9 = require(script.Settings)
local v_u_10 = require(v_u_4.Modules.Main.ClientData)
local v_u_11 = game:GetService("Players").LocalPlayer
local v_u_12 = v_u_11:GetMouse()
local v_u_13 = false
local v_u_14 = false
local function v_u_20(p15, p16, p17, p18)
	for _, v19 in pairs(p15:GetDescendants()) do
		if v19:IsA("BasePart") then
			if p18 and not v19:GetAttribute((("og_%*"):format(p16))) then
				v19:SetAttribute(("og_%*"):format(p16), v19[p16])
			end
			v19[p16] = p17
		end
	end
end
local function v_u_24(p21, p22)
	for _, v23 in pairs(p21:GetDescendants()) do
		if v23:IsA("BasePart") then
			v23[p22] = v23:GetAttribute((("og_%*"):format(p22))) or v23[p22]
		end
	end
end
local v_u_25 = {
	["Default"] = { "Compressor_Default" },
	["Calm"] = { "Compressor_Calm", "EQMix_Calm" },
	["Boost"] = { "EQMix_Boost" },
	["Boost High"] = { "EQMix_BoostHigh" },
	["Boost Low"] = { "EQMix_BoostLow" }
}
local v26 = table.freeze
local v37 = {
	["disableShadowsCallback"] = function(p27)
		-- upvalues: (copy) v_u_20, (copy) v_u_24
		local v28 = workspace:FindFirstChild("Arena") or workspace.Lobby
		if p27 then
			v_u_20(v28, "CastShadow", false, true)
			if v28 == workspace.Lobby then
				v_u_20(workspace.ShootingRange, "CastShadow", false, true)
				return
			end
		else
			v_u_24(v28, "CastShadow")
			if v28 == workspace.Lobby then
				v_u_24(workspace.ShootingRange, "CastShadow")
			end
		end
	end,
	["disableMaterialsCallback"] = function(p29)
		-- upvalues: (copy) v_u_20, (copy) v_u_24
		local v30 = workspace:FindFirstChild("Arena") or workspace.Lobby
		if p29 then
			v_u_20(v30, "Material", Enum.Material.Plastic, true)
			if v30 == workspace.Lobby then
				v_u_20(workspace.ShootingRange, "Material", Enum.Material.Plastic, true)
				return
			end
		else
			v_u_24(v30, "Material")
			if v30 == workspace.Lobby then
				v_u_24(workspace.ShootingRange, "Material")
			end
		end
	end,
	["masterVolCallback"] = function(p31)
		-- upvalues: (copy) v_u_7
		v_u_7.Game.Volume = p31
	end,
	["musVolCallback"] = function(p32)
		-- upvalues: (copy) v_u_7
		v_u_7.Game.Local.Music.Volume = p32
	end,
	["pingVolCallback"] = function(p33)
		-- upvalues: (copy) v_u_7
		v_u_7.Game.Local.Notifications.PingLocation.Volume = p33
	end,
	["audioMixCallback"] = function(p34)
		-- upvalues: (copy) v_u_7, (copy) v_u_25
		for _, v35 in pairs(v_u_7.Game:GetChildren()) do
			if v35:IsA("SoundEffect") then
				v35.Enabled = table.find(v_u_25[p34], v35.Name) and true or false
			end
		end
	end,
	["autoSprintCallback"] = function(p36)
		-- upvalues: (copy) v_u_11, (copy) v_u_4
		v_u_11.PlayerGui.MobileControls.Movement.Sprint.Visible = not p36
		v_u_4.Modules.Controllers.CharacterController.Sprint:Fire(p36)
	end,
	["uiscaleCallback"] = function(_)
		-- upvalues: (copy) v_u_4
		v_u_4.Modules.Controllers.UIController.UpdateScaling:Fire()
	end
}
local v_u_38 = "AimToggle"
function v37.toggleAimCallback(p39)
	-- upvalues: (copy) v_u_8, (copy) v_u_38
	v_u_8[v_u_38] = p39
end
local v_u_40 = "CrouchToggle"
function v37.toggleCrouchCallback(p41)
	-- upvalues: (copy) v_u_8, (copy) v_u_40
	v_u_8[v_u_40] = p41
end
local v_u_42 = "SprintToggle"
function v37.toggleSprintCallback(p43)
	-- upvalues: (copy) v_u_8, (copy) v_u_42
	v_u_8[v_u_42] = p43
end
local v_u_44 = v26(v37)
local v_u_45 = v_u_9.SettingsList
local v_u_46 = {
	["General"] = {
		["Visual"] = {
			"ShadowsDisabled",
			"MaterialsDisabled",
			"ShellEjectionDisabled",
			"GlassBreakDisabled",
			"FOV",
			"AimFOV",
			"AimVMFadesOut",
			"TeamCharacters",
			"EnemyCharacters",
			"CameraAnimationDisabled"
		},
		["HUD"] = {
			"HUDDisabled",
			"ActionProgressBarsDisabled",
			"UIScale",
			"TeammateIconsDisabled",
			"DeathIconsDisabled",
			"DmgIndicatorsDisabled",
			"ScopeTiltDisabled"
		},
		["Audio"] = {
			"MasterVol",
			"MusVol",
			"PingVol",
			"AudioMixing"
		},
		["Controls"] = {
			"AimAssist",
			"ToggleAim",
			"ToggleCrouch",
			"ToggleSprint",
			"AutoSprint",
			"WeaponScrolling",
			"AimSens",
			"SensitivityAimFOVRatio"
		},
		["Other"] = { "TradeNotifications", "1v1Notifications", "InventoryView" }
	}
}
local v_u_47 = {
	["General"] = {
		"Visual",
		"HUD",
		"Audio",
		"Controls",
		"Other"
	}
}
local v_u_48 = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local v_u_49 = v_u_4.Assets.UI._Templates.Settings
v_u_1.Settings = {}
v_u_1.SettingCallbacks = v_u_44
v_u_1.Utils = {}
v_u_1.Utils.bulkSetPartProperiesForMap = v_u_20
v_u_1.Utils.bulkRestorePartPropertiesForMap = v_u_24
local v_u_50 = {}
v_u_1.DEFAULT_SETTINGS = v_u_45
local v_u_51 = {}
local function v_u_55(p52, p53)
	-- upvalues: (ref) v_u_14, (ref) v_u_13, (copy) v_u_4, (copy) v_u_1
	if v_u_14 or v_u_13 then
		local v54 = p53 or v_u_1.Settings[p52]
		v_u_4.Remotes.PlayerData.Settings.UpdateSettings:FireServer({
			[p52] = v54
		})
	else
		v_u_14 = true
		v_u_4.Remotes.PlayerData.Settings.UpdateSettings:FireServer(v_u_1.Settings)
	end
end
local function v_u_61(p56, p57, p58)
	-- upvalues: (copy) v_u_5, (copy) v_u_48
	local v59 = p57 and Color3.fromRGB(85, 221, 78) or Color3.fromRGB(235, 237, 244)
	local v60 = p57 and UDim2.new(0.75, 0, 0.5, 0) or UDim2.new(0.25, 0, 0.5, 0)
	if p58 then
		v_u_5:Create(p56.Buttons.ToggleBtn, v_u_48, {
			["BackgroundColor3"] = v59
		}):Play()
		v_u_5:Create(p56.Buttons.ToggleBtn.Visual, v_u_48, {
			["Position"] = v60
		}):Play()
	else
		p56.Buttons.ToggleBtn.BackgroundColor3 = v59
		p56.Buttons.ToggleBtn.Visual.Position = v60
	end
end
local function v_u_67(p62, p63, p64)
	-- upvalues: (copy) v_u_50
	local v65 = v_u_50[p62]
	if v65 then
		for _, v66 in pairs(v65) do
			task.spawn(v66, p63, p64)
		end
	end
end
local function v_u_75(p68, p69, p70, p71, p72, p73)
	-- upvalues: (copy) v_u_1, (copy) v_u_44, (copy) v_u_61, (copy) v_u_55, (copy) v_u_67
	local v74 = v_u_1.Settings[p68]
	v_u_1.Settings[p68] = p71
	if p69.Callback and v_u_44[p69.Callback] then
		v_u_44[p69.Callback](v_u_1.Settings[p68])
	end
	v_u_61(p70, p71, p72)
	p70.Buttons.Reset.Visible = v_u_1.Settings[p68] ~= p69.Setting.Value
	if not p73 then
		v_u_55(p68)
	end
	v_u_67(p68, v74, v_u_1.Settings[p68])
end
local function v_u_91(p76, p77, p78, p79, p80, p81, p82)
	-- upvalues: (copy) v_u_1, (copy) v_u_44, (copy) v_u_55, (copy) v_u_67
	local v83 = v_u_1.Settings[p76]
	local v84 = nil
	local v85
	if p80 then
		v85 = v_u_1.Settings[p76] + p80
	else
		v85 = p81 or v84
	end
	if not v85 or (p77.Setting.Max < v85 or (v85 < p77.Setting.Min or (v85 ~= v85 or v85 == (1 / 0)))) then
		return false
	end
	local v86 = string.format(p78, v85)
	v_u_1.Settings[p76] = tonumber(v86)
	if p77.Callback and v_u_44[p77.Callback] then
		v_u_44[p77.Callback](v_u_1.Settings[p76])
	end
	p79.Buttons.Input.Text = v86
	local v87 = p79.BarHolder.Bar.Slider
	local v88 = UDim2.fromScale
	local v89 = p77.Setting.Min
	local v90 = p77.Setting.Max
	v87.Position = v88((v_u_1.Settings[p76] - v89) / (v90 - v89), 0.5)
	p79.Buttons.Reset.Visible = v_u_1.Settings[p76] ~= p77.Setting.Value
	if not p82 then
		v_u_55(p76)
	end
	v_u_67(p76, v83, v_u_1.Settings[p76])
	return true
end
local function v_u_98(p92, p93, p94, p95, p96)
	-- upvalues: (copy) v_u_1, (copy) v_u_55, (copy) v_u_67
	local v97 = v_u_1.Settings[p92]
	v_u_1.Settings[p92] = p93.Setting.Options[p94]
	p95.Buttons.Multiple.mText.Text = v_u_1.Settings[p92]
	p95.Buttons.Multiple.mTextBG.Text = v_u_1.Settings[p92]
	p95.Buttons.Reset.Visible = v_u_1.Settings[p92] ~= p93.Setting.Options[1]
	if not p96 then
		v_u_55(p92)
	end
	v_u_67(p92, v97, v_u_1.Settings[p92])
end
local function v_u_108(p99)
	-- upvalues: (ref) v_u_14, (copy) v_u_10, (ref) v_u_13, (copy) v_u_1, (copy) v_u_51, (copy) v_u_9, (copy) v_u_75, (copy) v_u_91, (copy) v_u_98
	if v_u_14 then
		return false
	end
	if not v_u_10.Data.Settings or v_u_13 then
		return false
	end
	v_u_13 = true
	v_u_1.Settings = v_u_10.Data.Settings
	if not p99 then
		return true
	end
	for _, v100 in pairs(v_u_51) do
		for _, v101 in pairs(v100) do
			local v102 = v101[1]
			if v_u_1.Settings[v102] == nil then
				warn("Failed to synchronize setting " .. v102)
			else
				local v103 = v101[2]
				local v104 = v101[3]
				local v105 = v_u_1.Settings[v102]
				if v101[2].SettingType == v_u_9.SETTING_TYPE.Toggle then
					v_u_75(v102, v103, v104, v105, false, true)
				elseif v101[2].SettingType == v_u_9.SETTING_TYPE.Slider then
					local v106 = v103.Setting.Decimals
					v_u_91(v102, v103, ("%%.%*f"):format((tostring(v106))), v104, nil, v105, true)
				elseif v101[2].SettingType == v_u_9.SETTING_TYPE.Shifter then
					local v107 = table.find(v103.Setting.Options, v105)
					if v107 then
						v_u_98(v102, v103, v107, v104, true)
					end
				end
			end
		end
	end
	return true
end
function v_u_1.Init()
	-- upvalues: (copy) v_u_11, (copy) v_u_2, (copy) v_u_1, (copy) v_u_12, (copy) v_u_55, (copy) v_u_44, (copy) v_u_67, (copy) v_u_6, (copy) v_u_4, (copy) v_u_7, (copy) v_u_9, (copy) v_u_75, (copy) v_u_91, (copy) v_u_98, (copy) v_u_49, (copy) v_u_61, (copy) v_u_45, (copy) v_u_47, (copy) v_u_46, (copy) v_u_51, (copy) v_u_108
	local v109 = v_u_11:WaitForChild("PlayerGui"):WaitForChild("Menu")
	local v_u_110 = v109:WaitForChild("_RESOLUTION")
	local v_u_111 = v109:WaitForChild("Settings")
	local v_u_112 = nil
	local v_u_113 = nil
	local v_u_114 = nil
	local v_u_115 = 0
	local function v_u_134()
		-- upvalues: (ref) v_u_115, (ref) v_u_112, (ref) v_u_113, (ref) v_u_2, (ref) v_u_1, (ref) v_u_114, (ref) v_u_12, (ref) v_u_55, (ref) v_u_44, (ref) v_u_67, (ref) v_u_6
		v_u_115 = v_u_115 + 1
		local v116 = v_u_115
		local v_u_117 = true
		local v118 = v_u_112.BarHolder.Bar
		local v119 = v_u_113.Setting.Decimals
		local v120 = ("%%.%*f"):format((tostring(v119)))
		local v122 = v_u_2.InputEnded:Connect(function(p121)
			-- upvalues: (ref) v_u_117
			if p121.UserInputType == Enum.UserInputType.MouseButton1 or p121.UserInputType == Enum.UserInputType.Touch then
				v_u_117 = false
			end
		end)
		local v123 = v_u_1.Settings[v_u_114]
		local v124 = v_u_117
		while v_u_112 and (v124 and v116 == v_u_115) do
			local v125 = Vector2.new(v_u_12.X, v_u_12.Y)
			local v126 = v118.AbsolutePosition.X
			local v127 = v118.AbsoluteSize.X
			local v128 = (v125.X - v126) / v127
			local v129 = math.clamp(v128, 0, 1)
			local v130 = v_u_113.Setting.Min
			local v131 = v_u_113.Setting.Max
			local v132 = math.lerp(v130, v131, v129)
			local v133 = string.format(v120, v132)
			v_u_112.Buttons.Input.Text = v133
			v_u_1.Settings[v_u_114] = tonumber(v133)
			v118.Slider.Position = UDim2.fromScale(v129, 0.5)
			v_u_112.Buttons.Reset.Visible = v_u_1.Settings[v_u_114] ~= v_u_113.Setting.Value
			if v123 ~= v_u_1.Settings[v_u_114] then
				v_u_55(v_u_114)
				if v_u_113.Callback and v_u_44[v_u_113.Callback] then
					v123 = v_u_1.Settings[v_u_114]
					v_u_44[v_u_113.Callback](v123)
				end
				v_u_67(v_u_114, v123, v_u_1.Settings[v_u_114])
			end
			v_u_6.RenderStepped:Wait()
		end
		v_u_117 = false
		v122:Disconnect()
	end
	local v135 = v_u_7.Game.Local.Menu.UI
	local v_u_136 = v135.ButtonClickIn
	local v_u_137 = v135.ButtonClickOut
	local v_u_138 = v135.ButtonHover
	local function v_u_144(p139, p140, p141, _)
		-- upvalues: (ref) v_u_9, (ref) v_u_75, (ref) v_u_91, (ref) v_u_98
		if p140.SettingType == v_u_9.SETTING_TYPE.Toggle then
			v_u_75(p139, p140, p141, p140.Setting.Value, true, false)
		elseif p140.SettingType == v_u_9.SETTING_TYPE.Slider then
			local v142 = v_u_91
			local v143 = p140.Setting.Decimals
			v142(p139, p140, ("%%.%*f"):format((tostring(v143))), p141, nil, p140.Setting.Value, false)
		elseif p140.SettingType == v_u_9.SETTING_TYPE.Shifter then
			v_u_98(p139, p140, 1, p141, false)
		end
		p141.Buttons.Reset.Visible = false
	end
	local v_u_145 = v_u_115
	local v_u_146 = v_u_113
	local v_u_147 = v_u_112
	local v_u_148 = v_u_114
	local function v_u_150(p149)
		-- upvalues: (copy) v_u_138, (copy) v_u_136, (copy) v_u_137
		p149.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_138
			v_u_138:Play()
		end)
		p149.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_136
			v_u_136:Play()
		end)
		p149.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_137
			v_u_137:Play()
		end)
	end
	local function v_u_155(p151, p152)
		local v153 = string.lower(p151)
		local v154 = #p152
		return string.sub(v153, 1, v154) == string.lower(p152) and true or string.match(string.lower(p151), string.lower(p152))
	end
	for v_u_156, v157 in pairs(v_u_45) do
		local v_u_158 = v_u_111.Bottom["Items_" .. tostring(v_u_156)].Contents
		local v_u_159 = {}
		local v160 = 1
		local v_u_161 = {}
		for _, v162 in ipairs(v_u_47[v_u_156]) do
			local v163 = v157[v162]
			local v164 = v_u_4.Assets.UI._Templates.Settings.Section:Clone()
			v164.Text = v162
			v164.LayoutOrder = v160
			v164.Parent = v_u_158
			table.insert(v_u_161, v164)
			for _, v_u_165 in ipairs(v_u_46[v_u_156][v162]) do
				v160 = v160 + 1
				local v_u_166 = v163[v_u_165]
				if not v_u_1.Settings[v_u_165] then
					v_u_1.Settings[v_u_165] = v_u_166.Setting.Value
				end
				local v_u_167 = v_u_166.Setting.Value
				local v183 = (function()
					-- upvalues: (copy) v_u_166, (ref) v_u_9, (ref) v_u_49, (ref) v_u_61, (copy) v_u_167, (ref) v_u_1, (copy) v_u_165, (ref) v_u_44, (ref) v_u_55, (copy) v_u_150, (ref) v_u_75, (ref) v_u_147, (ref) v_u_148, (ref) v_u_146, (copy) v_u_134, (ref) v_u_145, (ref) v_u_91, (copy) v_u_144
					local v_u_168 = nil
					if v_u_166.SettingType == v_u_9.SETTING_TYPE.Toggle then
						v_u_168 = v_u_49.Toggle:Clone()
						v_u_61(v_u_168, v_u_167, false)
						v_u_150(v_u_168.Buttons.ToggleBtn)
						v_u_168.Buttons.ToggleBtn.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_75, (ref) v_u_165, (ref) v_u_166, (ref) v_u_168, (ref) v_u_1
							v_u_75(v_u_165, v_u_166, v_u_168, not v_u_1.Settings[v_u_165], true, false)
						end)
						v_u_168.Buttons.Reset.Visible = v_u_1.Settings[v_u_165] ~= v_u_166.Setting.Value
					elseif v_u_166.SettingType == v_u_9.SETTING_TYPE.Slider then
						v_u_1.Settings[v_u_165] = v_u_166.Setting.Value
						v_u_168 = v_u_49.Slider:Clone()
						local v169 = v_u_166.Setting.Decimals
						local v_u_170 = ("%%.%*f"):format((tostring(v169)))
						local v171 = string.format(v_u_170, v_u_166.Setting.Value)
						local v_u_172
						if v_u_166.Setting.Decimals == 0 then
							v_u_172 = 1
						else
							local v173 = "." .. string.rep("0", v_u_166.Setting.Decimals - 1) .. "1"
							v_u_172 = tonumber(v173)
						end
						v_u_168.Buttons.Input.Text = v171
						v_u_168.Buttons.Input.PlaceholderText = v171
						v_u_168.BarHolder.Bar.Slider.MouseButton1Down:Connect(function()
							-- upvalues: (ref) v_u_147, (ref) v_u_168, (ref) v_u_148, (ref) v_u_165, (ref) v_u_146, (ref) v_u_166, (ref) v_u_134
							v_u_147 = v_u_168
							v_u_148 = v_u_165
							v_u_146 = v_u_166
							v_u_134()
						end)
						v_u_168.BarHolder.Bar.Slider.MouseButton1Up:Connect(function()
							-- upvalues: (ref) v_u_145
							v_u_145 = v_u_145 + 1
						end)
						v_u_150(v_u_168.BarHolder.Bar.Slider)
						v_u_168.BarHolder.IncreaseBtn.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_91, (ref) v_u_165, (ref) v_u_166, (copy) v_u_170, (ref) v_u_168, (copy) v_u_172
							v_u_91(v_u_165, v_u_166, v_u_170, v_u_168, v_u_172, nil)
						end)
						v_u_150(v_u_168.BarHolder.IncreaseBtn)
						v_u_168.BarHolder.DecreaseBtn.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_91, (ref) v_u_165, (ref) v_u_166, (copy) v_u_170, (ref) v_u_168, (copy) v_u_172
							v_u_91(v_u_165, v_u_166, v_u_170, v_u_168, -v_u_172, nil)
						end)
						v_u_150(v_u_168.BarHolder.DecreaseBtn)
						v_u_168.Buttons.Input.FocusLost:Connect(function(p174)
							-- upvalues: (ref) v_u_168, (ref) v_u_91, (ref) v_u_165, (ref) v_u_166, (copy) v_u_170, (ref) v_u_1
							local v175
							if p174 then
								local v176 = v_u_168.Buttons.Input.Text
								v175 = tonumber(v176)
							else
								v175 = p174
							end
							if p174 and v175 then
								if not v_u_91(v_u_165, v_u_166, v_u_170, v_u_168, nil, v175) then
									v_u_91(v_u_165, v_u_166, v_u_170, v_u_168, nil, v_u_1.Settings[v_u_165])
								end
							else
								v_u_91(v_u_165, v_u_166, v_u_170, v_u_168, nil, v_u_1.Settings[v_u_165])
							end
						end)
						local v177 = v_u_168.BarHolder.Bar.Slider
						local v178 = UDim2.fromScale
						local v179 = v_u_166.Setting.Min
						local v180 = v_u_166.Setting.Max
						v177.Position = v178((v_u_1.Settings[v_u_165] - v179) / (v180 - v179), 0.5)
						v_u_168.Buttons.Reset.Visible = v_u_1.Settings[v_u_165] ~= v_u_166.Setting.Value
					elseif v_u_166.SettingType == v_u_9.SETTING_TYPE.Shifter then
						local v_u_181 = v_u_49.Shifter:Clone()
						v_u_1.Settings[v_u_165] = v_u_166.Setting.Options[1]
						v_u_181.Buttons.Multiple.mText.Text = v_u_1.Settings[v_u_165]
						v_u_181.Buttons.Multiple.mTextBG.Text = v_u_1.Settings[v_u_165]
						v_u_181.Buttons.Reset.Visible = v_u_1.Settings[v_u_165] ~= v_u_166.Setting.Options[1]
						v_u_181.Buttons.Multiple.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_166, (ref) v_u_1, (ref) v_u_165, (ref) v_u_55, (ref) v_u_181, (ref) v_u_44
							local v182 = table.find(v_u_166.Setting.Options, v_u_1.Settings[v_u_165])
							if v182 then
								if v182 + 1 > #v_u_166.Setting.Options then
									v_u_1.Settings[v_u_165] = v_u_166.Setting.Options[1]
								else
									v_u_1.Settings[v_u_165] = v_u_166.Setting.Options[v182 + 1]
								end
								v_u_55(v_u_165)
								v_u_181.Buttons.Multiple.mText.Text = v_u_1.Settings[v_u_165]
								v_u_181.Buttons.Multiple.mTextBG.Text = v_u_1.Settings[v_u_165]
								v_u_181.Buttons.Reset.Visible = v_u_1.Settings[v_u_165] ~= v_u_166.Setting.Options[1]
								if v_u_166.Callback and v_u_44[v_u_166.Callback] then
									v_u_44[v_u_166.Callback](v_u_1.Settings[v_u_165])
								end
							end
						end)
						v_u_150(v_u_181.Buttons.Multiple)
						v_u_168 = v_u_181
					end
					v_u_168.Buttons.Reset.MouseButton1Click:Connect(function()
						-- upvalues: (ref) v_u_144, (ref) v_u_165, (ref) v_u_166, (ref) v_u_168
						v_u_144(v_u_165, v_u_166, v_u_168)
					end)
					v_u_150(v_u_168.Buttons.Reset)
					return v_u_168
				end)()
				if v183 then
					v183.LayoutOrder = v160
					v183.Title.Text = v_u_166.UITitle
					v183.Desc.Text = v_u_166.UIDesc
					v183.Parent = v_u_158
				else
					v183 = nil
				end
				table.insert(v_u_159, {
					v_u_165,
					v_u_166,
					v183,
					v164
				})
			end
			v160 = v160 + 1
		end
		v_u_51[v_u_156] = v_u_159
		v_u_158.Parent.ResetTab.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_4, (copy) v_u_156, (copy) v_u_159, (ref) v_u_1, (ref) v_u_9, (copy) v_u_144
			v_u_4.Modules.Controllers.UIController.Modal:Invoke("CANCEL_ACCEPT", {
				["Title"] = string.upper("reset " .. v_u_156 .. " settings"),
				["Description"] = "This will reset all of the settings in the " .. string.upper(v_u_156) .. " tab. Are you sure?"
			}).Event:Connect(function(p184)
				-- upvalues: (ref) v_u_159, (ref) v_u_1, (ref) v_u_9, (ref) v_u_144, (ref) v_u_4
				if p184 then
					local v185 = {}
					local v186 = false
					for _, v187 in pairs(v_u_159) do
						if v_u_1.Settings[v187[1]] ~= nil then
							local v188 = v187[2].SettingType == v_u_9.SETTING_TYPE.Shifter and v187[2].Setting.Options[1] or v187[2].Setting.Value
							if v_u_1.Settings[v187[1]] ~= v188 then
								v185[v187[1]] = v188
								v_u_144(v187[1], v187[2], v187[3], true)
								v186 = true
							end
						end
					end
					if v186 then
						v_u_4.Remotes.PlayerData.Settings.UpdateSettings:FireServer(v185)
					end
				end
			end)
		end)
		v_u_158.Parent.SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			-- upvalues: (copy) v_u_158, (copy) v_u_159, (copy) v_u_161, (copy) v_u_155
			local v189 = v_u_158.Parent.SearchBox.Text
			if v189 == "" then
				for _, v190 in pairs(v_u_159) do
					v190[3].Visible = true
					v190[4].Visible = true
				end
			else
				local v191 = table.clone(v_u_161)
				for _, v192 in pairs(v_u_159) do
					if v_u_155(v192[2].UITitle, v189) or v_u_155(v192[1], v189) then
						local v193 = table.find(v191, v192[4])
						if v193 then
							table.remove(v191, v193)
						end
						v192[4].Visible = true
						v192[3].Visible = true
					else
						v192[3].Visible = false
					end
				end
				for _, v194 in pairs(v191) do
					v194.Visible = false
				end
			end
		end)
	end
	v_u_108(true)
	local v_u_195 = v_u_110.Scale
	v_u_110:GetPropertyChangedSignal("Scale"):Connect(function()
		-- upvalues: (copy) v_u_110, (copy) v_u_111, (ref) v_u_195
		local v196 = v_u_110.Scale
		for _, v197 in v_u_111.Bottom:GetChildren() do
			if v197:IsA("Frame") and string.find(v197.Name, "Items_") then
				local v198 = v197.Contents
				v198.CanvasPosition = v198.CanvasPosition / v_u_195 * v196
			end
		end
		v_u_195 = v196
	end)
end
function v_u_1.GetPlatform()
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	return v_u_3:IsTenFootInterface() and "Console" or ((v_u_2.KeyboardEnabled or not v_u_2.TouchEnabled) and "Desktop" or "Mobile")
end
function v_u_1.OnSettingChanged(_, p199, p200)
	-- upvalues: (copy) v_u_50
	if v_u_50[p199] then
		local v201 = v_u_50[p199]
		table.insert(v201, p200)
	else
		v_u_50[p199] = { p200 }
	end
end
return v_u_1
