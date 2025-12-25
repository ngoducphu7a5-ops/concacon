--==================================================
-- Maru Hub - DELTA SAFE EDITION
-- Fixed & cleaned for Delta Executor
-- Author: Phu DuBai
-- Fixed by: DucPhu
--==================================================

print("[Maru Hub] Delta-safe version loading...")

-- ===== SERVICES =====
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===== SAFE API FALLBACKS =====
syn = syn or {}
syn.protect_gui = syn.protect_gui or function() end
gethui = gethui or function() return PlayerGui end
setclipboard = setclipboard or function() end
queue_on_teleport = queue_on_teleport or function() end

-- ===== SCREEN GUI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DucPhu_Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- ===== MAIN WINDOW =====
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.fromOffset(520, 360)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

-- ===== TOP BAR =====
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBar.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 12)

-- ===== TITLE =====
local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "Maru Hub (Delta Safe)"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(235, 235, 235)

-- ===== CONTENT AREA =====
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.fromOffset(0, 42)
Content.Size = UDim2.new(1, 0, 1, -42)
Content.BackgroundTransparency = 1

-- ===== DEMO BUTTON (PROOF SCRIPT RUNS) =====
local TestButton = Instance.new("TextButton", Content)
TestButton.Size = UDim2.fromOffset(200, 42)
TestButton.Position = UDim2.fromOffset(160, 120)
TestButton.Text = "Maru Hub Loaded"
TestButton.Font = Enum.Font.Gotham
TestButton.TextSize = 14
TestButton.TextColor3 = Color3.new(1,1,1)
TestButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
TestButton.BorderSizePixel = 0

local BtnCorner = Instance.new("UICorner", TestButton)
BtnCorner.CornerRadius = UDim.new(0, 8)

TestButton.MouseButton1Click:Connect(function()
    print("[Maru Hub] Button clicked - Delta OK")
end)

-- ===== DRAG WINDOW =====
do
    local dragging = false
    local dragStart
    local startPos

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

print("[Maru Hub] Loaded successfully on Delta")
