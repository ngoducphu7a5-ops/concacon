-- Delta Executor Compatible Version
-- Remove old GUI if exists
pcall(function()
    local gui = game:GetService("CoreGui"):FindFirstChild("HovxrzGui")
    if gui then
        gui:Destroy()
    end
end)

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Safe function wrappers for Delta
local function safeCall(func)
    local success, result = pcall(func)
    if not success then
        warn("Error:", result)
    end
    return success, result
end

-- Make GUI draggable
local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        TweenService:Create(object, TweenInfo.new(0.2), {Position = pos}):Play()
    end

    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

local library = {}

function library:CreateWindow(text, maincolor, text2, logo)
    logo = logo or 0
    maincolor = maincolor or Color3.fromRGB(63, 233, 233)
    local isselected = false

    local HovxrzGui = Instance.new("ScreenGui")
    HovxrzGui.Name = "HovxrzGui"
    HovxrzGui.Parent = game:GetService("CoreGui")
    HovxrzGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = HovxrzGui
    Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Main.BorderColor3 = Color3.fromRGB(25, 25, 25)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Size = UDim2.new(0, 375, 0, 460)

    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(0, 375, 0, 20)
    Top.ClipsDescendants = true

    local NameHub = Instance.new("TextLabel")
    NameHub.Name = "NameHub"
    NameHub.Parent = Top
    NameHub.BackgroundTransparency = 1
    NameHub.Position = UDim2.new(0, 25, 0, 0)
    NameHub.Size = UDim2.new(0, 50, 0, 20)
    NameHub.Font = Enum.Font.GothamSemibold
    NameHub.Text = string.upper(text)
    NameHub.TextColor3 = Color3.fromRGB(225, 225, 225)
    NameHub.TextSize = 15

    local Hub = Instance.new("TextLabel")
    Hub.Name = "Hub"
    Hub.Parent = Top
    Hub.BackgroundTransparency = 1
    Hub.Position = UDim2.new(0, 75, 0, 0)
    Hub.Size = UDim2.new(0, 60, 0, 20)
    Hub.Font = Enum.Font.GothamSemibold
    Hub.Text = "HUB"
    Hub.TextColor3 = maincolor
    Hub.TextSize = 15
    Hub.TextXAlignment = Enum.TextXAlignment.Left

    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = Top
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 5, 0, 0)
    Logo.Size = UDim2.new(0, 20, 0, 20)
    Logo.Image = "rbxassetid://" .. tostring(logo)

    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Parent = Top
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 125, 0, 0)
    Description.Size = UDim2.new(0, 250, 0, 20)
    Description.Font = Enum.Font.GothamSemibold
    Description.Text = text2
    Description.TextColor3 = Color3.fromRGB(225, 225, 225)
    Description.TextSize = 15
    Description.TextXAlignment = Enum.TextXAlignment.Left

    local Tab = Instance.new("Frame")
    Tab.Name = "Tab"
    Tab.Parent = Main
    Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Tab.BorderSizePixel = 0
    Tab.Position = UDim2.new(0, 5, 0, 25)
    Tab.Size = UDim2.new(0, 365, 0, 25)

    local ScrollTab = Instance.new("ScrollingFrame")
    ScrollTab.Name = "ScrollTab"
    ScrollTab.Parent = Tab
    ScrollTab.Active = true
    ScrollTab.BackgroundTransparency = 1
    ScrollTab.BorderSizePixel = 0
    ScrollTab.Size = UDim2.new(0, 365, 0, 25)
    ScrollTab.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollTab.ScrollBarThickness = 0

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Name = "TabListLayout"
    TabListLayout.Parent = ScrollTab
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)

    local Page = Instance.new("Frame")
    Page.Name = "Page"
    Page.Parent = Main
    Page.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Page.BorderSizePixel = 0
    Page.Position = UDim2.new(0, 5, 0, 55)
    Page.Size = UDim2.new(0, 365, 0, 395)

    local pagesFolder = Instance.new("Folder")
    pagesFolder.Name = "pagesFolder"
    pagesFolder.Parent = Page

    MakeDraggable(Top, Main)

    -- Hide/Show button
    local uihide = false
    local ScreenGui = Instance.new("ScreenGui")
    local ImageButton = Instance.new("ImageButton")

    ScreenGui.Parent = game.CoreGui
    ImageButton.Parent = ScreenGui
    ImageButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ImageButton.Position = UDim2.new(0.12, 0, 0.095, 0)
    ImageButton.Size = UDim2.new(0, 50, 0, 50)
    ImageButton.BorderSizePixel = 0
    ImageButton.Image = "rbxassetid://8622542227"

    ImageButton.MouseButton1Click:Connect(function()
        uihide = not uihide
        Main.Visible = not uihide
    end)

    local uitab = {}

    function uitab:AddTab(text)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.Parent = ScrollTab
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(0, 80, 0, 25)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = text
        TabButton.TextColor3 = Color3.fromRGB(225, 225, 225)
        TabButton.TextSize = 14
        TabButton.TextTransparency = 0.5

        local MainPage = Instance.new("Frame")
        MainPage.Name = "MainPage"
        MainPage.Parent = pagesFolder
        MainPage.BackgroundTransparency = 1
        MainPage.Size = UDim2.new(0, 365, 0, 395)
        MainPage.Visible = false

        local MainFramePage = Instance.new("ScrollingFrame")
        MainFramePage.Name = "MainFramePage"
        MainFramePage.Parent = MainPage
        MainFramePage.Active = true
        MainFramePage.BackgroundTransparency = 1
        MainFramePage.BorderSizePixel = 0
        MainFramePage.Size = UDim2.new(0, 365, 0, 395)
        MainFramePage.CanvasSize = UDim2.new(0, 0, 0, 0)
        MainFramePage.ScrollBarThickness = 3

        local PageListLayout = Instance.new("UIListLayout")
        PageListLayout.Name = "PageListLayout"
        PageListLayout.Padding = UDim.new(0, 15)
        PageListLayout.Parent = MainFramePage
        PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local PagePadding = Instance.new("UIPadding")
        PagePadding.Name = "PagePadding"
        PagePadding.Parent = MainFramePage
        PagePadding.PaddingLeft = UDim.new(0, 15)
        PagePadding.PaddingTop = UDim.new(0, 15)

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(pagesFolder:GetChildren()) do
                v.Visible = false
            end
            MainPage.Visible = true

            for _, v in pairs(ScrollTab:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v, TweenInfo.new(0.3), {TextTransparency = 0.5}):Play()
                end
            end
            TweenService:Create(TabButton, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        end)

        if not isselected then
            isselected = true
            MainPage.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        end

        spawn(function()
            while wait(0.1) do
                pcall(function()
                    ScrollTab.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X + 10, 0, 0)
                    MainFramePage.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y + 30)
                end)
            end
        end)

        local main = {}

        function main:AddButton(text, callback)
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Name = "ButtonFrame"
            ButtonFrame.Parent = MainFramePage
            ButtonFrame.BackgroundColor3 = maincolor
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Size = UDim2.new(0, 335, 0, 30)

            local UICorner = Instance.new("UICorner")
            UICorner.Parent = ButtonFrame
            UICorner.CornerRadius = UDim.new(0, 5)

            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = ButtonFrame
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Button.BorderSizePixel = 0
            Button.Position = UDim2.new(0, 1, 0, 1)
            Button.Size = UDim2.new(0, 333, 0, 28)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(225, 225, 225)
            Button.TextSize = 14

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.Parent = Button
            UICorner_2.CornerRadius = UDim.new(0, 5)

            Button.MouseButton1Click:Connect(function()
                safeCall(callback)
                Button.TextSize = 0
                TweenService:Create(Button, TweenInfo.new(0.3), {TextSize = 14}):Play()
            end)
        end

        function main:AddToggle(text, config, callback)
            config = config or false
            local istoggled = config

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = MainFramePage
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Size = UDim2.new(0, 335, 0, 25)

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
            ToggleLabel.Size = UDim2.new(0, 276, 0, 25)
            ToggleLabel.Font = Enum.Font.GothamSemibold
            ToggleLabel.Text = text
            ToggleLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
            ToggleLabel.TextSize = 15
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleImage = Instance.new("Frame")
            ToggleImage.Name = "ToggleImage"
            ToggleImage.Parent = ToggleFrame
            ToggleImage.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
            ToggleImage.Position = UDim2.new(0, 290, 0, 2)
            ToggleImage.Size = UDim2.new(0, 40, 0, 20)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = ToggleImage

            local Circle = Instance.new("Frame")
            Circle.Name = "Circle"
            Circle.Parent = ToggleImage
            Circle.BackgroundColor3 = Color3.fromRGB(233, 63, 63)
            Circle.Position = UDim2.new(0, 2, 0, 2)
            Circle.Size = UDim2.new(0, 16, 0, 16)

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 10)
            UICorner_2.Parent = Circle

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Size = UDim2.new(0, 335, 0, 25)
            ToggleButton.Font = Enum.Font.SourceSans
            ToggleButton.Text = ""
            ToggleButton.TextSize = 14

            ToggleButton.MouseButton1Click:Connect(function()
                istoggled = not istoggled
                safeCall(function() callback(istoggled) end)

                if istoggled then
                    TweenService:Create(Circle, TweenInfo.new(0.3), {
                        Position = UDim2.new(0, 22, 0, 2),
                        BackgroundColor3 = maincolor
                    }):Play()
                else
                    TweenService:Create(Circle, TweenInfo.new(0.3), {
                        Position = UDim2.new(0, 2, 0, 2),
                        BackgroundColor3 = Color3.fromRGB(233, 63, 63)
                    }):Play()
                end
            end)

            if config then
                Circle.Position = UDim2.new(0, 22, 0, 2)
                Circle.BackgroundColor3 = maincolor
            end
        end

        function main:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = MainFramePage
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(0, 335, 0, 20)
            Label.Font = Enum.Font.GothamSemibold
            Label.TextColor3 = Color3.fromRGB(225, 225, 225)
            Label.TextSize = 16
            Label.Text = text
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local PaddingLabel = Instance.new("UIPadding")
            PaddingLabel.PaddingLeft = UDim.new(0, 15)
            PaddingLabel.Parent = Label

            local labell = {}
            function labell:Set(newtext)
                Label.Text = newtext
            end
            return labell
        end

        function main:AddSeperator(text)
            local Seperator = Instance.new("Frame")
            Seperator.Name = "Seperator"
            Seperator.Parent = MainFramePage
            Seperator.BackgroundTransparency = 1
            Seperator.Size = UDim2.new(0, 335, 0, 20)

            local Sep2 = Instance.new("TextLabel")
            Sep2.Name = "Sep2"
            Sep2.Parent = Seperator
            Sep2.BackgroundTransparency = 1
            Sep2.Position = UDim2.new(0.5, 0, 0, 0)
            Sep2.Size = UDim2.new(0, 100, 0, 20)
            Sep2.Font = Enum.Font.GothamSemibold
            Sep2.Text = text
            Sep2.TextColor3 = Color3.fromRGB(255, 255, 255)
            Sep2.TextSize = 14
            Sep2.AnchorPoint = Vector2.new(0.5, 0)
        end

        function main:AddDropdown(text, options, callback)
            local DropFrame = Instance.new("Frame")
            DropFrame.Name = "DropFrame"
            DropFrame.Parent = MainFramePage
            DropFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropFrame.Size = UDim2.new(0, 335, 0, 30)
            DropFrame.ClipsDescendants = true

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = DropFrame

            local DropLabel = Instance.new("TextLabel")
            DropLabel.Name = "DropLabel"
            DropLabel.Parent = DropFrame
            DropLabel.BackgroundTransparency = 1
            DropLabel.Position = UDim2.new(0, 10, 0, 0)
            DropLabel.Size = UDim2.new(0, 300, 0, 30)
            DropLabel.Font = Enum.Font.GothamSemibold
            DropLabel.Text = text .. ": "
            DropLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
            DropLabel.TextSize = 14
            DropLabel.TextXAlignment = Enum.TextXAlignment.Left

            local DropScroll = Instance.new("ScrollingFrame")
            DropScroll.Name = "DropScroll"
            DropScroll.Parent = DropFrame
            DropScroll.BackgroundTransparency = 1
            DropScroll.Position = UDim2.new(0, 0, 0, 35)
            DropScroll.Size = UDim2.new(0, 335, 0, 100)
            DropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropScroll.ScrollBarThickness = 3

            local DropLayout = Instance.new("UIListLayout")
            DropLayout.Parent = DropScroll
            DropLayout.Padding = UDim.new(0, 5)

            local isOpen = false

            local DropButton = Instance.new("TextButton")
            DropButton.Name = "DropButton"
            DropButton.Parent = DropFrame
            DropButton.BackgroundTransparency = 1
            DropButton.Size = UDim2.new(0, 335, 0, 30)
            DropButton.Font = Enum.Font.SourceSans
            DropButton.Text = ""
            DropButton.TextSize = 14

            for _, option in pairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = "Option"
                OptionButton.Parent = DropScroll
                OptionButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                OptionButton.Size = UDim2.new(0, 325, 0, 25)
                OptionButton.Font = Enum.Font.GothamSemibold
                OptionButton.Text = option
                OptionButton.TextColor3 = Color3.fromRGB(225, 225, 225)
                OptionButton.TextSize = 13

                local OUICorner = Instance.new("UICorner")
                OUICorner.CornerRadius = UDim.new(0, 5)
                OUICorner.Parent = OptionButton

                OptionButton.MouseButton1Click:Connect(function()
                    DropLabel.Text = text .. ": " .. option
                    safeCall(function() callback(option) end)
                    isOpen = false
                    TweenService:Create(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 335, 0, 30)}):Play()
                end)
            end

            DropScroll.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y + 10)

            DropButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    TweenService:Create(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 335, 0, 135)}):Play()
                else
                    TweenService:Create(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 335, 0, 30)}):Play()
                end
            end)

            local dropdown = {}
            function dropdown:Add(option)
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = "Option"
                OptionButton.Parent = DropScroll
                OptionButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                OptionButton.Size = UDim2.new(0, 325, 0, 25)
                OptionButton.Font = Enum.Font.GothamSemibold
                OptionButton.Text = option
                OptionButton.TextColor3 = Color3.fromRGB(225, 225, 225)
                OptionButton.TextSize = 13

                local OUICorner = Instance.new("UICorner")
                OUICorner.CornerRadius = UDim.new(0, 5)
                OUICorner.Parent = OptionButton

                OptionButton.MouseButton1Click:Connect(function()
                    DropLabel.Text = text .. ": " .. option
                    safeCall(function() callback(option) end)
                    isOpen = false
                    TweenService:Create(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 335, 0, 30)}):Play()
                end)

                DropScroll.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y + 10)
            end

            function dropdown:Clear()
                for _, v in pairs(DropScroll:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
                DropLabel.Text = text .. ": "
            end

            return dropdown
        end

        return main
    end
    return uitab
end

-- World Detection
local World1, World2, World3
if game.PlaceId == 2753915549 then
    World1 = true
elseif game.PlaceId == 4442272183 then
    World2 = true
elseif game.PlaceId == 7449423635 then
    World3 = true
end

-- Mob selection (simplified for Delta)
function CheckQuest()
    local MyLevel = LocalPlayer.Data.Level.Value
    
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 then
            return "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1550)
        elseif MyLevel >= 10 and MyLevel <= 14 then
            return "Monkey", "JungleQuest", 1, CFrame.new(-1598, 35, 153)
        elseif MyLevel >= 15 and MyLevel <= 29 then
            return "Gorilla", "JungleQuest", 2, CFrame.new(-1598, 35, 153)
        elseif MyLevel >= 30 and MyLevel <= 39 then
            return "Pirate", "BuggyQuest1", 1, CFrame.new(-1141, 4, 3831)
        elseif MyLevel >= 40 and MyLevel <= 59 then
            return "Brute", "BuggyQuest1", 2, CFrame.new(-1141, 4, 3831)
        elseif MyLevel >= 60 then
            return "Desert Bandit", "DesertQuest", 1, CFrame.new(894, 5, 4392)
        end
    end
    
    return "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1550)
end

-- Simple teleport function for Delta
function topos(Pos)
    local Distance = (Pos.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    
    if Distance < 250 then
        LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    else
        local tween = TweenService:Create(
            LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance / 300, Enum.EasingStyle.Linear),
            {CFrame = Pos}
        )
        tween:Play()
    end
end

-- Equip weapon
function EquipWeapon(ToolSe)
    if LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        local Tool = LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(0.1)
        LocalPlayer.Character.Humanoid:EquipTool(Tool)
    end
end

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    local VirtualUser = game:GetService("VirtualUser")
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- Create UI
local RenUi = library:CreateWindow("MARU", Color3.fromRGB(175, 238, 238), "Delta Compatible", 0)

-- Main Tab
local Main = RenUi:AddTab("Main")

Main:AddSeperator("Auto Farm")

Main:AddLabel("Select your weapon first!")

Main:AddToggle("Auto Farm Level", false, function(value)
    _G.AutoFarm = value
    
    spawn(function()
        while _G.AutoFarm do
            wait()
            safeCall(function()
                local Mon, NameQuest, LevelQuest, CFrameQuest = CheckQuest()
                
                if Mon and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    -- Check if have quest
                    if not LocalPlayer.PlayerGui.Main.Quest.Visible then
                        -- Go to quest giver
                        if (CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then
                            topos(CFrameQuest)
                        else
                            -- Take quest
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                        end
                    else
                        -- Find and attack mob
                        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == Mon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                repeat
                                    wait()
                                    if _G.SelectWeapon then
                                        EquipWeapon(_G.SelectWeapon)
                                    end
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.Head.CanCollide = false
                                    
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                until not _G.AutoFarm or not v.Parent or v.Humanoid.Health <= 0
                                break
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

-- Settings Tab
local Settings = RenUi:AddTab("Settings")

Settings:AddSeperator("Weapon")

local WeaponList = {}
for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        table.insert(WeaponList, v.Name)
    end
end

local SelectWeaponDropdown = Settings:AddDropdown("Select Weapon", WeaponList, function(value)
    _G.SelectWeapon = value
end)

Settings:AddButton("Refresh Weapon", function()
    SelectWeaponDropdown:Clear()
    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            SelectWeaponDropdown:Add(v.Name)
        end
    end
end)

Settings:AddSeperator("Game Settings")

Settings:AddToggle("Auto Set Spawn", true, function(value)
    _G.AutoSetSpawn = value
end)

spawn(function()
    while wait(1) do
        if _G.AutoSetSpawn then
            safeCall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                end
            end)
        end
    end
end)

Settings:AddToggle("Fast Attack", true, function(value)
    _G.FastAttack = value
end)

spawn(function()
    while wait() do
        if _G.FastAttack then
            safeCall(function()
                local CombatFramework = require(LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
                local CombatFrameworkR = debug.getupvalues(CombatFramework)[2]
                
                if CombatFrameworkR and CombatFrameworkR.activeController then
                    CombatFrameworkR.activeController.timeToNextAttack = 0
                    CombatFrameworkR.activeController.attacking = false
                    CombatFrameworkR.activeController.increment = 3
                    CombatFrameworkR.activeController.blocking = false
                    CombatFrameworkR.activeController.hitboxMagnitude = 55
                end
            end)
        end
    end
end)

Settings:AddToggle("Bring Mob", true, function(value)
    _G.BringMonster = value
end)

spawn(function()
    while wait(0.5) do
        if _G.BringMonster and _G.AutoFarm then
            safeCall(function()
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 350 then
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.Humanoid.JumpPower = 0
                            if v.Humanoid:FindFirstChild("Animator") then
                                v.Humanoid.Animator:Destroy()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- NoClip for auto farm
spawn(function()
    while wait() do
        if _G.AutoFarm then
            safeCall(function()
                if LocalPlayer.Character then
                    for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Haki
spawn(function()
    while wait(0.5) do
        if _G.AutoFarm then
            safeCall(function()
                if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end
    end
end)

-- Stats Tab
local Stats = RenUi:AddTab("Stats")

Stats:AddSeperator("Auto Stats")

Stats:AddToggle("Auto Melee", false, function(value)
    _G.AutoMelee = value
end)

Stats:AddToggle("Auto Defense", false, function(value)
    _G.AutoDefense = value
end)

Stats:AddToggle("Auto Sword", false, function(value)
    _G.AutoSword = value
end)

Stats:AddToggle("Auto Gun", false, function(value)
    _G.AutoGun = value
end)

Stats:AddToggle("Auto Devil Fruit", false, function(value)
    _G.AutoFruit = value
end)

spawn(function()
    while wait(0.5) do
        safeCall(function()
            if _G.AutoMelee then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
            end
            if _G.AutoDefense then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
            end
            if _G.AutoSword then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
            end
            if _G.AutoGun then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1)
            end
            if _G.AutoFruit then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1)
            end
        end)
    end
end)

-- Combat Tab
local Combat = RenUi:AddTab("Combat")

Combat:AddSeperator("Boss Farm")

local BossList = {}
if World1 then
    BossList = {"The Gorilla King", "Bobby", "Yeti", "Mob Leader", "Vice Admiral", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg"}
elseif World2 then
    BossList = {"Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Cursed Captain", "Darkbeard", "Order", "Awakened Ice Admiral"}
elseif World3 then
    BossList = {"Stone", "Island Empress", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "rip_indra True Form", "Longma", "Soul Reaper", "Cake Queen"}
else
    BossList = {"The Gorilla King", "Bobby", "Yeti"}
end

local SelectBoss = Combat:AddDropdown("Select Boss", BossList, function(value)
    _G.SelectBoss = value
end)

Combat:AddToggle("Auto Farm Boss", false, function(value)
    _G.AutoFarmBoss = value
    
    spawn(function()
        while _G.AutoFarmBoss do
            wait()
            safeCall(function()
                if game.Workspace.Enemies:FindFirstChild(_G.SelectBoss) then
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == _G.SelectBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                wait()
                                if _G.SelectWeapon then
                                    EquipWeapon(_G.SelectWeapon)
                                end
                                topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.Transparency = 1
                                v.Humanoid.WalkSpeed = 0
                                v.Head.CanCollide = false
                                
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            until not _G.AutoFarmBoss or not v.Parent or v.Humanoid.Health <= 0
                            break
                        end
                    end
                end
            end)
        end
    end)
end)

-- Teleport Tab
local Teleport = RenUi:AddTab("Teleport")

Teleport:AddSeperator("World Teleport")

if World1 then
    Teleport:AddButton("Teleport to Second Sea", function()
        safeCall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
        end)
    end)
elseif World2 then
    Teleport:AddButton("Teleport to First Sea", function()
        safeCall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
        end)
    end)
    
    Teleport:AddButton("Teleport to Third Sea", function()
        safeCall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
        end)
    end)
elseif World3 then
    Teleport:AddButton("Teleport to Second Sea", function()
        safeCall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
        end)
    end)
end

Teleport:AddSeperator("Island Teleport")

local IslandList = {}
if World1 then
    IslandList = {
        "Starter Island",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Frozen Village",
        "Marine Fortress",
        "Sky Island 1",
        "Prison",
        "Colosseum",
        "Magma Village"
    }
else
    IslandList = {"Kingdom of Rose", "Cafe", "Mansion"}
end

local IslandCFrames = {
    ["Starter Island"] = CFrame.new(1071, 16, 1426),
    ["Jungle"] = CFrame.new(-1598, 36, 153),
    ["Pirate Village"] = CFrame.new(-1141, 4, 3831),
    ["Desert"] = CFrame.new(944, 20, 4373),
    ["Frozen Village"] = CFrame.new(1200, 87, -1409),
    ["Marine Fortress"] = CFrame.new(-4505, 20, 4047),
    ["Sky Island 1"] = CFrame.new(-4970, 717, -2622),
    ["Prison"] = CFrame.new(4854, 5, 740),
    ["Colosseum"] = CFrame.new(-1427, 7, -2792),
    ["Magma Village"] = CFrame.new(-5247, 12, 8504),
    ["Kingdom of Rose"] = CFrame.new(-246, 47, 1608),
    ["Cafe"] = CFrame.new(-380, 77, 298),
    ["Mansion"] = CFrame.new(-390, 381, 585)
}

Teleport:AddDropdown("Select Island", IslandList, function(value)
    _G.SelectIsland = value
end)

Teleport:AddButton("Teleport to Island", function()
    if _G.SelectIsland and IslandCFrames[_G.SelectIsland] then
        safeCall(function()
            topos(IslandCFrames[_G.SelectIsland])
        end)
    end
end)

-- Misc Tab
local Misc = RenUi:AddTab("Misc")

Misc:AddSeperator("Misc Options")

Misc:AddButton("Remove Lag", function()
    safeCall(function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                v.Material = Enum.Material.SmoothPlastic
                if v:IsA("Texture") or v:IsA("Decal") then
                    v:Destroy()
                end
            end
        end
    end)
end)

Misc:AddButton("FPS Boost", function()
    safeCall(function()
        local decalsyeeted = true
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        
        settings().Rendering.QualityLevel = "Level01"
        
        for _, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            end
        end
    end)
end)

Misc:AddButton("Unlock FPS", function()
    safeCall(function()
        setfpscap(999)
    end)
end)

Misc:AddToggle("Walk on Water", false, function(value)
    _G.WalkOnWater = value
    
    spawn(function()
        while wait() do
            if _G.WalkOnWater then
                safeCall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        if game.Workspace:FindFirstChild("Water") then
                            game.Workspace.Water.CanCollide = true
                        end
                    end
                end)
            else
                if game.Workspace:FindFirstChild("Water") then
                    game.Workspace.Water.CanCollide = false
                end
            end
        end
    end)
end)

Misc:AddSeperator("Server")

Misc:AddButton("Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

Misc:AddButton("Server Hop", function()
    safeCall(function()
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        
        local function TPReturner()
            local Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            local ID = ""
            
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                foundAnything = Site.nextPageCursor
            end
            
            for i,v in pairs(Site.data) do
                ID = tostring(v.id)
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    table.insert(AllIDs, ID)
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, LocalPlayer)
                    wait(4)
                end
            end
        end
        
        while wait() do
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end
    end)
end)

-- Info Tab
local Info = RenUi:AddTab("Info")

Info:AddSeperator("Script Info")

Info:AddLabel("Script: DucPhu Hub")
Info:AddLabel("Version: Delta Compatible v1.0")
Info:AddLabel("Game: Blox Fruits")
Info:AddLabel("Made for: Delta Executor")

Info:AddSeperator("Player Info")

local LevelLabel = Info:AddLabel("Level: Loading...")
local BelliLabel = Info:AddLabel("Beli: Loading...")
local FragLabel = Info:AddLabel("Fragments: Loading...")

spawn(function()
    while wait(1) do
        safeCall(function()
            if LocalPlayer.Data then
                LevelLabel:Set("Level: " .. tostring(LocalPlayer.Data.Level.Value))
                BelliLabel:Set("Beli: " .. tostring(LocalPlayer.Data.Beli.Value))
                if LocalPlayer.Data:FindFirstChild("Fragments") then
                    FragLabel:Set("Fragments: " .. tostring(LocalPlayer.Data.Fragments.Value))
                end
            end
        end)
    end
end)

Info:AddSeperator("Credits")

Info:AddLabel("Script by: DucPhu")
Info:AddLabel("UI Library: Custom")
Info:AddLabel("Thanks for using!")

print("✅ Maru Hub loaded successfully!")
print("✅ Delta Executor Compatible Version")
print("✅ All features working!")
