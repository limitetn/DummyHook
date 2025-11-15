--[[
    DummyHook Notifications System
    Advanced notification system with animations and customization
]]

local Notifications = {
    Enabled = true,
    Settings = {
        Duration = 5,
        Position = "TopRight", -- TopLeft, TopRight, BottomLeft, BottomRight
        AnimationSpeed = 0.3,
        MaxNotifications = 5,
        ShowIcons = true
    },
    ActiveNotifications = {},
    NotificationFrame = nil
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local function CreateElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

local function Tween(object, properties, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    local tweenInfo = TweenInfo.new(duration or 0.2, style, direction)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Initialize notification system
function Notifications:Initialize()
    if self.NotificationFrame then return end
    
    local screenGui = CreateElement("ScreenGui", {
        Name = "DummyHook_Notifications_Center",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    })
    
    self.NotificationFrame = CreateElement("Frame", {
        Name = "NotificationsContainer",
        Size = UDim2.new(0, 300, 1, 0),
        Position = UDim2.new(1, -320, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = screenGui
    })
    
    local layout = CreateElement("UIListLayout", {
        Name = "NotificationLayout",
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10),
        Parent = self.NotificationFrame
    })
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if self.NotificationFrame and layout.AbsoluteContentSize then
            self.NotificationFrame.CanvasSize = UDim2.new(0, 300, 0, layout.AbsoluteContentSize.Y + 20)
        end
    end)
end

-- Create a notification
function Notifications:Create(title, message, icon, duration)
    if not self.Enabled then return end
    if not self.NotificationFrame then self:Initialize() end
    
    duration = duration or self.Settings.Duration
    
    -- Limit number of notifications
    if #self.ActiveNotifications >= self.Settings.MaxNotifications then
        local oldest = table.remove(self.ActiveNotifications, 1)
        if oldest.Frame then
            oldest.Frame:Destroy()
        end
    end
    
    -- Create notification frame
    local notificationFrame = CreateElement("Frame", {
        Name = "Notification",
        Size = UDim2.new(1, -20, 0, 80),
        Position = UDim2.new(1, 20, 0, 0), -- Start off-screen
        BackgroundColor3 = Color3.fromRGB(25, 25, 30),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.NotificationFrame
    })
    
    local corner = CreateElement("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = notificationFrame
    })
    
    local stroke = CreateElement("UIStroke", {
        Color = Color3.fromRGB(130, 195, 65),
        Thickness = 2,
        Parent = notificationFrame
    })
    
    -- Icon
    if self.Settings.ShowIcons and icon then
        local iconLabel = CreateElement("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(0, 15, 0, 15),
            BackgroundTransparency = 1,
            Image = icon,
            Parent = notificationFrame
        })
    end
    
    -- Title
    local titleOffset = self.Settings.ShowIcons and icon and 45 or 15
    local titleLabel = CreateElement("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -(titleOffset + 15), 0, 20),
        Position = UDim2.new(0, titleOffset, 0, 12),
        BackgroundTransparency = 1,
        Text = title or "Notification",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = notificationFrame
    })
    
    -- Message
    local messageLabel = CreateElement("TextLabel", {
        Name = "Message",
        Size = UDim2.new(1, -(titleOffset + 15), 0, 30),
        Position = UDim2.new(0, titleOffset, 0, 35),
        BackgroundTransparency = 1,
        Text = message or "",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = notificationFrame
    })
    
    -- Close button
    local closeButton = CreateElement("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -30, 0, 10),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        Parent = notificationFrame
    })
    
    local closeCorner = CreateElement("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = closeButton
    })
    
    closeButton.MouseEnter:Connect(function()
        Tween(closeButton, {TextColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    
    closeButton.MouseLeave:Connect(function()
        Tween(closeButton, {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.2)
    end)
    
    -- Store notification data
    local notification = {
        Frame = notificationFrame,
        Created = tick(),
        Duration = duration
    }
    
    table.insert(self.ActiveNotifications, notification)
    
    -- Animate in
    Tween(notificationFrame, {Position = UDim2.new(0, 10, 0, 0)}, self.Settings.AnimationSpeed, Enum.EasingStyle.Back)
    
    -- Close button functionality
    closeButton.MouseButton1Click:Connect(function()
        self:RemoveNotification(notification)
    end)
    
    -- Auto-remove after duration
    spawn(function()
        wait(duration)
        self:RemoveNotification(notification)
    end)
    
    return notification
end

-- Remove notification
function Notifications:RemoveNotification(notification)
    if not notification or not notification.Frame then return end
    
    -- Find and remove from active list
    for i, notif in pairs(self.ActiveNotifications) do
        if notif == notification then
            table.remove(self.ActiveNotifications, i)
            break
        end
    end
    
    -- Animate out
    if notification.Frame then
        Tween(notification.Frame, {Position = UDim2.new(1, 20, 0, 0)}, self.Settings.AnimationSpeed, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        wait(self.Settings.AnimationSpeed)
        if notification.Frame then
            notification.Frame:Destroy()
        end
    end
end

-- Predefined notification types
function Notifications:Success(title, message, duration)
    return self:Create(title, message, "rbxassetid://7733992358", duration or self.Settings.Duration)
end

function Notifications:Error(title, message, duration)
    return self:Create(title, message, "rbxassetid://7743395745", duration or self.Settings.Duration)
end

function Notifications:Warning(title, message, duration)
    return self:Create(title, message, "rbxassetid://7743394444", duration or self.Settings.Duration)
end

function Notifications:Info(title, message, duration)
    return self:Create(title, message, "rbxassetid://7743393255", duration or self.Settings.Duration)
end

-- Cleanup
function Notifications:Cleanup()
    if self.NotificationFrame then
        self.NotificationFrame:Destroy()
        self.NotificationFrame = nil
    end
    self.ActiveNotifications = {}
end

return Notifications
