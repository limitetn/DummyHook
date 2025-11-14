--[[
    DummyHook Player Manager
    Player utilities, spectate, teleport, etc.
]]

local PlayerManager = {
    Spectating = false,
    SpectateTarget = nil,
    Connections = {},
    Whitelist = {},
    Blacklist = {},
    Friends = {},
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Spectate Player
function PlayerManager:Spectate(targetPlayer)
    if not targetPlayer or targetPlayer == LocalPlayer then
        self:StopSpectate()
        return
    end
    
    self:StopSpectate()
    
    self.Spectating = true
    self.SpectateTarget = targetPlayer
    
    self.Connections.Spectate = RunService.RenderStepped:Connect(function()
        if not self.Spectating or not self.SpectateTarget then
            self:StopSpectate()
            return
        end
        
        local character = self.SpectateTarget.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                Camera.CameraSubject = humanoid
            end
        else
            self:StopSpectate()
        end
    end)
    
    print("[PlayerManager] Now spectating: " .. targetPlayer.Name)
end

function PlayerManager:StopSpectate()
    self.Spectating = false
    self.SpectateTarget = nil
    
    if self.Connections.Spectate then
        self.Connections.Spectate:Disconnect()
        self.Connections.Spectate = nil
    end
    
    -- Reset camera to local player
    pcall(function()
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                Camera.CameraSubject = humanoid
            end
        end
    end)
end

-- Teleport to Player
function PlayerManager:TeleportTo(targetPlayer)
    if not targetPlayer or targetPlayer == LocalPlayer then return end
    
    local character = LocalPlayer.Character
    local targetChar = targetPlayer.Character
    
    if character and targetChar then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        
        if rootPart and targetRoot then
            -- Teleport behind target
            rootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
            print("[PlayerManager] Teleported to: " .. targetPlayer.Name)
        end
    end
end

-- Bring Player (teleport them to you)
function PlayerManager:BringPlayer(targetPlayer)
    if not targetPlayer or targetPlayer == LocalPlayer then return end
    
    local character = LocalPlayer.Character
    local targetChar = targetPlayer.Character
    
    if character and targetChar then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        
        if rootPart and targetRoot then
            -- Attempt to move target (may not work on FE games)
            pcall(function()
                targetRoot.CFrame = rootPart.CFrame * CFrame.new(0, 0, -3)
            end)
            print("[PlayerManager] Attempted to bring: " .. targetPlayer.Name)
        end
    end
end

-- View Player Stats
function PlayerManager:GetPlayerStats(targetPlayer)
    local stats = {
        Name = targetPlayer.Name,
        DisplayName = targetPlayer.DisplayName,
        UserId = targetPlayer.UserId,
        AccountAge = targetPlayer.AccountAge,
        Team = targetPlayer.Team and targetPlayer.Team.Name or "None",
        Health = "N/A",
        MaxHealth = "N/A",
        Distance = "N/A",
    }
    
    if targetPlayer.Character then
        local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            stats.Health = math.floor(humanoid.Health)
            stats.MaxHealth = math.floor(humanoid.MaxHealth)
        end
        
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if targetRoot and localRoot then
            local distance = (localRoot.Position - targetRoot.Position).Magnitude
            stats.Distance = math.floor(distance) .. " studs"
        end
    end
    
    return stats
end

-- Add to Whitelist
function PlayerManager:AddToWhitelist(targetPlayer)
    if not table.find(self.Whitelist, targetPlayer.UserId) then
        table.insert(self.Whitelist, targetPlayer.UserId)
        print("[PlayerManager] Added to whitelist: " .. targetPlayer.Name)
    end
end

function PlayerManager:RemoveFromWhitelist(targetPlayer)
    local index = table.find(self.Whitelist, targetPlayer.UserId)
    if index then
        table.remove(self.Whitelist, index)
        print("[PlayerManager] Removed from whitelist: " .. targetPlayer.Name)
    end
end

function PlayerManager:IsWhitelisted(targetPlayer)
    return table.find(self.Whitelist, targetPlayer.UserId) ~= nil
end

-- Blacklist
function PlayerManager:AddToBlacklist(targetPlayer)
    if not table.find(self.Blacklist, targetPlayer.UserId) then
        table.insert(self.Blacklist, targetPlayer.UserId)
        print("[PlayerManager] Added to blacklist: " .. targetPlayer.Name)
    end
end

function PlayerManager:RemoveFromBlacklist(targetPlayer)
    local index = table.find(self.Blacklist, targetPlayer.UserId)
    if index then
        table.remove(self.Blacklist, index)
        print("[PlayerManager] Removed from blacklist: " .. targetPlayer.Name)
    end
end

function PlayerManager:IsBlacklisted(targetPlayer)
    return table.find(self.Blacklist, targetPlayer.UserId) ~= nil
end

-- Friends
function PlayerManager:AddFriend(targetPlayer)
    if not table.find(self.Friends, targetPlayer.UserId) then
        table.insert(self.Friends, targetPlayer.UserId)
        print("[PlayerManager] Added friend: " .. targetPlayer.Name)
    end
end

function PlayerManager:RemoveFriend(targetPlayer)
    local index = table.find(self.Friends, targetPlayer.UserId)
    if index then
        table.remove(self.Friends, index)
        print("[PlayerManager] Removed friend: " .. targetPlayer.Name)
    end
end

function PlayerManager:IsFriend(targetPlayer)
    return table.find(self.Friends, targetPlayer.UserId) ~= nil
end

-- Get All Players (sorted by distance)
function PlayerManager:GetPlayersNear()
    local playerList = {}
    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot and localRoot then
                local distance = (localRoot.Position - targetRoot.Position).Magnitude
                table.insert(playerList, {
                    Player = player,
                    Distance = distance
                })
            end
        end
    end
    
    -- Sort by distance
    table.sort(playerList, function(a, b)
        return a.Distance < b.Distance
    end)
    
    return playerList
end

-- Kill Player (attempt)
function PlayerManager:KillPlayer(targetPlayer)
    if not targetPlayer or targetPlayer == LocalPlayer then return end
    
    -- Method 1: Try to damage via remotes
    local success = pcall(function()
        local remotes = game:GetService("ReplicatedStorage"):GetDescendants()
        for _, remote in pairs(remotes) do
            if remote:IsA("RemoteEvent") then
                local name = remote.Name:lower()
                if name:find("damage") or name:find("kill") or name:find("hit") then
                    pcall(function()
                        remote:FireServer(targetPlayer, 999999)
                        remote:FireServer(targetPlayer.Character, 999999)
                        if targetPlayer.Character then
                            remote:FireServer(targetPlayer.Character.Humanoid, 999999)
                        end
                    end)
                end
            end
        end
    end)
    
    if success then
        print("[PlayerManager] Attempted kill on: " .. targetPlayer.Name)
    end
end

-- Freeze Player (attempt to anchor)
function PlayerManager:FreezePlayer(targetPlayer)
    if not targetPlayer or targetPlayer == LocalPlayer then return end
    
    pcall(function()
        if targetPlayer.Character then
            local rootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Anchored = true
                print("[PlayerManager] Froze: " .. targetPlayer.Name)
            end
        end
    end)
end

function PlayerManager:UnfreezePlayer(targetPlayer)
    if not targetPlayer or targetPlayer == LocalPlayer then return end
    
    pcall(function()
        if targetPlayer.Character then
            local rootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Anchored = false
                print("[PlayerManager] Unfroze: " .. targetPlayer.Name)
            end
        end
    end)
end

-- Cleanup
function PlayerManager:Cleanup()
    self:StopSpectate()
    
    for _, connection in pairs(self.Connections) do
        connection:Disconnect()
    end
    
    self.Connections = {}
end

return PlayerManager
