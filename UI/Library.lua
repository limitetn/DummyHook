--[[
    DummyHook UI Library
    Skeet & Aimware Inspired Design
]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Theme Configuration (Skeet-style dark theme)
Library.Theme = {
    Background = Color3.fromRGB(15, 15, 18),
    Secondary = Color3.fromRGB(22, 22, 26),
    Tertiary = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(130, 195, 65),
    AccentDark = Color3.fromRGB(100, 165, 45),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(180, 180, 180),
    Border = Color3.fromRGB(45, 45, 50),
    Success = Color3.fromRGB(100, 255, 100),
    Error = Color3.fromRGB(255, 100, 100),
}

-- Store references to all themeable elements for dynamic updates
Library.ThemeElements = {}

-- Utility function to register themeable elements
function Library:RegisterThemeElement(element, property, themeKey)
    if not self.ThemeElements[themeKey] then
        self.ThemeElements[themeKey] = {}
    end
    table.insert(self.ThemeElements[themeKey], {Element = element, Property = property})
end

-- Function to update all theme elements
function Library:UpdateTheme(newTheme)
    if newTheme then
        self.Theme = newTheme
    end
    
    -- Update all registered elements
    for themeKey, elements in pairs(self.ThemeElements) do
        local color = self.Theme[themeKey]
        if color then
            for _, elementData in pairs(elements) do
                elementData.Element[elementData.Property] = color
            end
        end
    end
    
    -- Update main window elements
    if self.MainFrame then
        self.MainFrame.BackgroundColor3 = self.Theme.Background
    end
    
    if self.TopBar then
        self.TopBar.BackgroundColor3 = self.Theme.Accent
    end
    
    if self.Header then
        self.Header.BackgroundColor3 = self.Theme.Secondary
    end
    
    if self.TabContainer then
        self.TabContainer.BackgroundColor3 = self.Theme.Tertiary
    end
    
    if self.ScrollLeftButton then
        self.ScrollLeftButton.BackgroundColor3 = self.Theme.Secondary
    end
    
    if self.ScrollRightButton then
        self.ScrollRightButton.BackgroundColor3 = self.Theme.Secondary
    end
end

-- Utility Functions
local function CreateElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

local function Tween(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Create Window
function Library:CreateWindow(config)
    local Window = {
        Title = config.Title or "DummyHook",
        Theme = config.Theme or "Skeet",
        Size = config.Size or UDim2.new(0, 580, 0, 460),
        KeyBind = config.KeyBind or Enum.KeyCode.RightShift,
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Main ScreenGui
    local ScreenGui = CreateElement("ScreenGui", {
        Name = "DummyHook_UI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    })
    
    -- Main Frame
    local MainFrame = CreateElement("Frame", {
        Name = "MainFrame",
        Size = Window.Size,
        Position = UDim2.new(0.5, -Window.Size.X.Offset/2, 0.5, -Window.Size.Y.Offset/2),
        BackgroundColor3 = Library.Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = ScreenGui
    })
    Window.MainFrame = MainFrame -- Store reference for theme updates
    Library:RegisterThemeElement(MainFrame, "BackgroundColor3", "Background")
    
    -- Top Accent Bar (Rainbow Gradient - Skeet style)
    local TopBar = CreateElement("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Library.Theme.Accent,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    Window.TopBar = TopBar -- Store reference for theme updates
    Library:RegisterThemeElement(TopBar, "BackgroundColor3", "Accent")
    
    local Gradient = CreateElement("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 195, 65)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(90, 180, 220)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(180, 90, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 90, 90))
        },
        Parent = TopBar
    })
    
    -- Animate gradient
    spawn(function()
        while wait() do
            for i = 0, 360, 1 do
                Gradient.Rotation = i
                wait(0.01)
            end
        end
    end)
    
    -- Header
    local Header = CreateElement("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 45),
        Position = UDim2.new(0, 0, 0, 2),
        BackgroundColor3 = Library.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    Window.Header = Header -- Store reference for theme updates
    Library:RegisterThemeElement(Header, "BackgroundColor3", "Secondary")
    
    local Title = CreateElement("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = Window.Title,
        TextColor3 = Library.Theme.Text,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Header
    })
    Library:RegisterThemeElement(Title, "TextColor3", "Text")
    
    local VersionLabel = CreateElement("TextLabel", {
        Name = "Version",
        Size = UDim2.new(0, 100, 1, 0),
        Position = UDim2.new(1, -110, 0, 0),
        BackgroundTransparency = 1,
        Text = "v1.0.0",
        TextColor3 = Library.Theme.TextDark,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = Header
    })
    Library:RegisterThemeElement(VersionLabel, "TextColor3", "TextDark")
    
    -- Tab Container with Scrolling Support
    local TabContainer = CreateElement("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(1, 0, 0, 35),
        Position = UDim2.new(0, 0, 0, 47),
        BackgroundColor3 = Library.Theme.Tertiary,
        BorderSizePixel = 0,
        Parent = MainFrame
    })
    Window.TabContainer = TabContainer -- Store reference for theme updates
    Library:RegisterThemeElement(TabContainer, "BackgroundColor3", "Tertiary")
    
    -- Scroll buttons for tabs
    local ScrollLeftButton = CreateElement("TextButton", {
        Name = "ScrollLeft",
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Library.Theme.Secondary,
        BorderSizePixel = 0,
        Text = "<",
        TextColor3 = Library.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = TabContainer
    })
    Window.ScrollLeftButton = ScrollLeftButton -- Store reference for theme updates
    Library:RegisterThemeElement(ScrollLeftButton, "BackgroundColor3", "Secondary")
    Library:RegisterThemeElement(ScrollLeftButton, "TextColor3", "Text")
    
    local ScrollRightButton = CreateElement("TextButton", {
        Name = "ScrollRight",
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -20, 0, 0),
        BackgroundColor3 = Library.Theme.Secondary,
        BorderSizePixel = 0,
        Text = ">",
        TextColor3 = Library.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = TabContainer
    })
    Window.ScrollRightButton = ScrollRightButton -- Store reference for theme updates
    Library:RegisterThemeElement(ScrollRightButton, "BackgroundColor3", "Secondary")
    Library:RegisterThemeElement(ScrollRightButton, "TextColor3", "Text")
    
    local TabScrollFrame = CreateElement("ScrollingFrame", {
        Name = "TabScrollFrame",
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 25, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 1, 0),
        ScrollingDirection = Enum.ScrollingDirection.X,
        Parent = TabContainer
    })
    
    local TabList = CreateElement("Frame", {
        Name = "TabList",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = TabScrollFrame
    })
    
    local TabListLayout = CreateElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        Parent = TabList
    })
    
    -- Update canvas size when tabs are added
    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabScrollFrame.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X + 10, 1, 0)
    end)
    
    -- Scroll button functionality
    ScrollLeftButton.MouseButton1Click:Connect(function()
        Tween(TabScrollFrame, {CanvasPosition = Vector2.new(math.max(0, TabScrollFrame.CanvasPosition.X - 100), 0)}, 0.3)
    end)
    
    ScrollRightButton.MouseButton1Click:Connect(function()
        local maxScroll = math.max(0, TabScrollFrame.CanvasSize.X.Offset - TabScrollFrame.AbsoluteSize.X)
        Tween(TabScrollFrame, {CanvasPosition = Vector2.new(math.min(maxScroll, TabScrollFrame.CanvasPosition.X + 100), 0)}, 0.3)
    end)
    
    -- Hover effects for scroll buttons
    ScrollLeftButton.MouseEnter:Connect(function()
        Tween(ScrollLeftButton, {BackgroundColor3 = Library.Theme.Accent}, 0.2)
    end)
    
    ScrollLeftButton.MouseLeave:Connect(function()
        Tween(ScrollLeftButton, {BackgroundColor3 = Library.Theme.Secondary}, 0.2)
    end)
    
    ScrollRightButton.MouseEnter:Connect(function()
        Tween(ScrollRightButton, {BackgroundColor3 = Library.Theme.Accent}, 0.2)
    end)
    
    ScrollRightButton.MouseLeave:Connect(function()
        Tween(ScrollRightButton, {BackgroundColor3 = Library.Theme.Secondary}, 0.2)
    end)
    
    -- Content Container
    local ContentContainer = CreateElement("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, -20, 1, -97),
        Position = UDim2.new(0, 10, 0, 87),
        BackgroundTransparency = 1,
        Parent = MainFrame
    })
    
    -- Dragging functionality
    local dragging, dragInput, dragStart, startPos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Toggle UI visibility
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Window.KeyBind then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
    
    -- Create Tab
    function Window:CreateTab(name)
        local Tab = {
            Name = name,
            Sections = {},
            Active = false
        }
        
        -- Tab Button
        local TabButton = CreateElement("TextButton", {
            Name = name .. "Tab",
            Size = UDim2.new(0, 100, 1, -10),
            BackgroundColor3 = Library.Theme.Secondary,
            BorderSizePixel = 0,
            Text = name:upper(),
            TextColor3 = Library.Theme.TextDark,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false,
            Parent = TabList
        })
        
        local TabCorner = CreateElement("UICorner", {
            CornerRadius = UDim.new(0, 3),
            Parent = TabButton
        })
        
        -- Tab Content
        local TabContent = CreateElement("ScrollingFrame", {
            Name = name .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Library.Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = ContentContainer
        })
        
        local ContentLayout = CreateElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            Parent = TabContent
        })
        
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Active = false
                tab.Button.BackgroundColor3 = Library.Theme.Secondary
                tab.Button.TextColor3 = Library.Theme.TextDark
                tab.Content.Visible = false
            end
            
            Tab.Active = true
            TabButton.BackgroundColor3 = Library.Theme.Tertiary
            TabButton.TextColor3 = Library.Theme.Text
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end)
        
        TabButton.MouseEnter:Connect(function()
            if not Tab.Active then
                Tween(TabButton, {BackgroundColor3 = Library.Theme.Tertiary}, 0.15)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if not Tab.Active then
                Tween(TabButton, {BackgroundColor3 = Library.Theme.Secondary}, 0.15)
            end
        end)
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        
        -- Auto-select first tab
        if #Window.Tabs == 0 then
            TabButton.BackgroundColor3 = Library.Theme.Tertiary
            TabButton.TextColor3 = Library.Theme.Text
            TabContent.Visible = true
            Tab.Active = true
            Window.CurrentTab = Tab
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- Create Section
        function Tab:CreateSection(name)
            local Section = {
                Name = name,
                Elements = {}
            }
            
            local SectionFrame = CreateElement("Frame", {
                Name = name .. "Section",
                Size = UDim2.new(1, -10, 0, 0),
                BackgroundColor3 = Library.Theme.Secondary,
                BorderSizePixel = 0,
                Parent = TabContent
            })
            
            local SectionCorner = CreateElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
                Parent = SectionFrame
            })
            
            local SectionTitle = CreateElement("TextLabel", {
                Name = "Title",
                Size = UDim2.new(1, -20, 0, 30),
                Position = UDim2.new(0, 10, 0, 5),
                BackgroundTransparency = 1,
                Text = name:upper(),
                TextColor3 = Library.Theme.Accent,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = SectionFrame
            })
            
            local ElementContainer = CreateElement("Frame", {
                Name = "Elements",
                Size = UDim2.new(1, -20, 1, -40),
                Position = UDim2.new(0, 10, 0, 35),
                BackgroundTransparency = 1,
                Parent = SectionFrame
            })
            
            local ElementLayout = CreateElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
                Parent = ElementContainer
            })
            
            ElementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -10, 0, ElementLayout.AbsoluteContentSize.Y + 45)
            end)
            
            Section.Frame = SectionFrame
            Section.Container = ElementContainer
            
            -- Add Toggle
            function Section:AddToggle(name, default, callback)
                local Toggle = {Value = default}
                
                local ToggleFrame = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 25),
                    BackgroundTransparency = 1,
                    Parent = ElementContainer
                })
                
                local ToggleLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(1, -40, 1, 0),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ToggleFrame
                })
                
                local ToggleBox = CreateElement("TextButton", {
                    Size = UDim2.new(0, 35, 0, 18),
                    Position = UDim2.new(1, -35, 0.5, -9),
                    BackgroundColor3 = default and Library.Theme.Accent or Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false,
                    Parent = ToggleFrame
                })
                
                local BoxCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = ToggleBox
                })
                
                local ToggleIndicator = CreateElement("Frame", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = ToggleBox
                })
                
                local IndicatorCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = ToggleIndicator
                })
                
                -- Hover effects
                ToggleBox.MouseEnter:Connect(function()
                    Tween(ToggleBox, {
                        Size = UDim2.new(0, 37, 0, 20)
                    }, 0.15)
                end)
                
                ToggleBox.MouseLeave:Connect(function()
                    Tween(ToggleBox, {
                        Size = UDim2.new(0, 35, 0, 18)
                    }, 0.15)
                end)
                
                ToggleBox.MouseButton1Click:Connect(function()
                    Toggle.Value = not Toggle.Value
                    
                    -- Scale animation on click
                    Tween(ToggleBox, {Size = UDim2.new(0, 33, 0, 16)}, 0.1)
                    task.wait(0.1)
                    Tween(ToggleBox, {Size = UDim2.new(0, 35, 0, 18)}, 0.1)
                    
                    Tween(ToggleBox, {
                        BackgroundColor3 = Toggle.Value and Library.Theme.Accent or Library.Theme.Tertiary
                    }, 0.2)
                    
                    Tween(ToggleIndicator, {
                        Position = Toggle.Value and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
                    }, 0.2)
                    
                    callback(Toggle.Value)
                end)
                
                return Toggle
            end
            
            -- Add Slider
            function Section:AddSlider(name, min, max, default, callback)
                local Slider = {Value = default}
                
                local SliderFrame = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundTransparency = 1,
                    Parent = ElementContainer
                })
                
                local SliderLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(1, -50, 0, 15),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = SliderFrame
                })
                
                local ValueLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(0, 45, 0, 15),
                    Position = UDim2.new(1, -45, 0, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(default),
                    TextColor3 = Library.Theme.Accent,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = SliderFrame
                })
                
                local SliderBar = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 4),
                    Position = UDim2.new(0, 0, 0, 25),
                    BackgroundColor3 = Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Parent = SliderFrame
                })
                
                local BarCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = SliderBar
                })
                
                local SliderFill = CreateElement("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Library.Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = SliderBar
                })
                
                local FillCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = SliderFill
                })
                
                local SliderButton = CreateElement("TextButton", {
                    Size = UDim2.new(1, 0, 0, 12),
                    Position = UDim2.new(0, 0, 0, 21),
                    BackgroundTransparency = 1,
                    Text = "",
                    Parent = SliderFrame
                })
                
                local dragging = false
                
                SliderButton.MouseButton1Down:Connect(function()
                    dragging = true
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                SliderButton.MouseMoved:Connect(function(x, y)
                    if dragging then
                        local percentage = math.clamp((x - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        local value = math.floor(min + (max - min) * percentage)
                        
                        Slider.Value = value
                        ValueLabel.Text = tostring(value)
                        
                        -- Smooth fill animation
                        Tween(SliderFill, {
                            Size = UDim2.new(percentage, 0, 1, 0)
                        }, 0.1)
                        
                        callback(value)
                    end
                end)
                
                -- Hover effect on slider
                SliderBar.MouseEnter:Connect(function()
                    Tween(SliderBar, {Size = UDim2.new(1, 0, 0, 6)}, 0.15)
                    Tween(SliderBar, {Position = UDim2.new(0, 0, 0, 24)}, 0.15)
                end)
                
                SliderBar.MouseLeave:Connect(function()
                    if not dragging then
                        Tween(SliderBar, {Size = UDim2.new(1, 0, 0, 4)}, 0.15)
                        Tween(SliderBar, {Position = UDim2.new(0, 0, 0, 25)}, 0.15)
                    end
                end)
                
                return Slider
            end
            
            -- Add Dropdown
            function Section:AddDropdown(name, options, default, callback)
                local Dropdown = {Value = default, Open = false}
                
                local DropdownFrame = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    Parent = ElementContainer,
                    ZIndex = 10
                })
                
                local DropdownLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(0.4, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = DropdownFrame
                })
                
                local DropdownButton = CreateElement("TextButton", {
                    Size = UDim2.new(0.55, 0, 0, 25),
                    Position = UDim2.new(0.45, 0, 0, 2),
                    BackgroundColor3 = Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = default,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false,
                    Parent = DropdownFrame
                })
                
                local ButtonCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(0, 3),
                    Parent = DropdownButton
                })
                
                local OptionsList = CreateElement("Frame", {
                    Size = UDim2.new(0.55, 0, 0, 0),
                    Position = UDim2.new(0.45, 0, 0, 30),
                    BackgroundColor3 = Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 15,
                    Parent = DropdownFrame
                })
                
                local ListCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(0, 3),
                    Parent = OptionsList
                })
                
                local ListLayout = CreateElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 2),
                    Parent = OptionsList
                })
                
                for _, option in pairs(options) do
                    local OptionButton = CreateElement("TextButton", {
                        Size = UDim2.new(1, 0, 0, 22),
                        BackgroundColor3 = Library.Theme.Secondary,
                        BorderSizePixel = 0,
                        Text = option,
                        TextColor3 = Library.Theme.Text,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        AutoButtonColor = false,
                        ZIndex = 16,
                        Parent = OptionsList
                    })
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        Dropdown.Value = option
                        DropdownButton.Text = option
                        OptionsList.Visible = false
                        Dropdown.Open = false
                        callback(option)
                    end)
                    
                    OptionButton.MouseEnter:Connect(function()
                        OptionButton.BackgroundColor3 = Library.Theme.Accent
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        OptionButton.BackgroundColor3 = Library.Theme.Secondary
                    end)
                end
                
                ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    OptionsList.Size = UDim2.new(0.55, 0, 0, math.min(ListLayout.AbsoluteContentSize.Y + 4, 120))
                end)
                
                DropdownButton.MouseButton1Click:Connect(function()
                    Dropdown.Open = not Dropdown.Open
                    OptionsList.Visible = Dropdown.Open
                    
                    if Dropdown.Open then
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 30 + OptionsList.AbsoluteSize.Y + 5)
                    else
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 30)
                    end
                end)
                
                return Dropdown
            end
            
            -- Add Button
            function Section:AddButton(name, callback)
                local ButtonFrame = CreateElement("TextButton", {
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundColor3 = Library.Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false,
                    Parent = ElementContainer
                })
                
                local ButtonCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                    Parent = ButtonFrame
                })
                
                ButtonFrame.MouseButton1Click:Connect(callback)
                
                ButtonFrame.MouseEnter:Connect(function()
                    Tween(ButtonFrame, {BackgroundColor3 = Library.Theme.Accent}, 0.15)
                end)
                
                ButtonFrame.MouseLeave:Connect(function()
                    Tween(ButtonFrame, {BackgroundColor3 = Library.Theme.Tertiary}, 0.15)
                end)
            end
            
            -- Add Color Picker
            function Section:AddColorPicker(name, default, callback)
                local ColorPicker = {Value = default}
                
                local PickerFrame = CreateElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 25),
                    BackgroundTransparency = 1,
                    Parent = ElementContainer
                })
                
                local PickerLabel = CreateElement("TextLabel", {
                    Size = UDim2.new(1, -30, 1, 0),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Library.Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = PickerFrame
                })
                
                local ColorBox = CreateElement("TextButton", {
                    Size = UDim2.new(0, 25, 0, 20),
                    Position = UDim2.new(1, -25, 0.5, -10),
                    BackgroundColor3 = default,
                    BorderSizePixel = 1,
                    BorderColor3 = Library.Theme.Border,
                    Text = "",
                    Parent = PickerFrame
                })
                
                local BoxCorner = CreateElement("UICorner", {
                    CornerRadius = UDim.new(0, 3),
                    Parent = ColorBox
                })
                
                ColorBox.MouseButton1Click:Connect(function()
                    -- Simple color picker (you can expand this)
                    callback(ColorPicker.Value)
                end)
                
                return ColorPicker
            end
            
            table.insert(Tab.Sections, Section)
            return Section
        end
        
        return Tab
    end
    
    -- Unload function
    function Window:Unload()
        ScreenGui:Destroy()
    end
    
    -- Config functions
    function Window:SaveConfig(name)
        print("[DummyHook] Config saved: " .. name)
    end
    
    function Window:LoadConfig(name)
        print("[DummyHook] Config loaded: " .. name)
    end
    
    return Window
end

return Library
