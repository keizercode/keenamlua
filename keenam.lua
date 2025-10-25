-- Auto Training Script untuk meningkatkan Combat Power
-- Optimized for Delta Executor

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Services
local TrainSpeedHasChanged = ReplicatedStorage.TrainSystem.Remote.TrainSpeedHasChanged
local ApplyMobileTrain = ReplicatedStorage.TrainEquipment.Remote.ApplyMobileTrain
local ApplyStationaryTrain = ReplicatedStorage.TrainEquipment.Remote.ApplyStationaryTrain
local ApplyBindingTrainingEffect = ReplicatedStorage.TrainEquipment.Remote.ApplyBindingTrainingEffect
local ApplyBindingTrainingBoostEffect = ReplicatedStorage.TrainEquipment.Remote.ApplyBindingTrainingBoostEffect

-- Variabel Global
local autoTrainEnabled = false
local selectedTrainingType = "arms"
local trainingSpeed = 4
local trainingDelay = 0.01
local isMinimized = false

-- Training Equipment IDs
local TrainingTypes = {
    arms = "Training_2001",
    legs = "Training_2002",
    back = "Training_2003",
    agility = "Training_2004"
}

-- Fungsi Auto Train
local function startAutoTrain()
    spawn(function()
        while autoTrainEnabled do
            pcall(function()
                ApplyMobileTrain:InvokeServer()
                TrainSpeedHasChanged:FireServer(trainingSpeed)
                
                local trainingId = TrainingTypes[selectedTrainingType]
                if trainingId then
                    ApplyBindingTrainingEffect:InvokeServer(trainingId, "Emit_2")
                end
                
                ApplyBindingTrainingBoostEffect:InvokeServer()
                ApplyStationaryTrain:InvokeServer()
            end)
            
            task.wait(trainingDelay)
        end
    end)
end

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local SpeedLabel = Instance.new("TextLabel")
local SpeedSlider = Instance.new("TextButton")
local TrainTypeLabel = Instance.new("TextLabel")
local ArmsButton = Instance.new("TextButton")
local LegsButton = Instance.new("TextButton")
local BackButton = Instance.new("TextButton")
local AgilityButton = Instance.new("TextButton")
local DelayLabel = Instance.new("TextLabel")
local DelayInput = Instance.new("TextBox")
local CombatPowerLabel = Instance.new("TextLabel")

-- ScreenGui
ScreenGui.Name = "AutoTrainGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Title Bar
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Active = true
TitleBar.Draggable = true

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Title
Title.Name = "Title"
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ Combat Power Booster"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize Button
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
MinimizeButton.Position = UDim2.new(0.82, 0, 0.25, 0)
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeButton

-- Close Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.Position = UDim2.new(0.91, 0, 0.25, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Content Frame
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.Size = UDim2.new(1, 0, 1, -50)

-- Status Label
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = ContentFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.1, 0, 0.02, 0)
StatusLabel.Size = UDim2.new(0.8, 0, 0, 30)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Inactive ⭕"
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.TextSize = 14

-- Toggle Button
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ContentFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
ToggleButton.Position = UDim2.new(0.15, 0, 0.09, 0)
ToggleButton.Size = UDim2.new(0.7, 0, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "START AUTO TRAIN"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

-- Training Type Selection
TrainTypeLabel.Name = "TrainTypeLabel"
TrainTypeLabel.Parent = ContentFrame
TrainTypeLabel.BackgroundTransparency = 1
TrainTypeLabel.Position = UDim2.new(0.1, 0, 0.21, 0)
TrainTypeLabel.Size = UDim2.new(0.8, 0, 0, 25)
TrainTypeLabel.Font = Enum.Font.GothamBold
TrainTypeLabel.Text = "Training Type:"
TrainTypeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TrainTypeLabel.TextSize = 14
TrainTypeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Function to create training type buttons
local function createTypeButton(name, position, yPos)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Button"
    btn.Parent = ContentFrame
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    btn.Position = UDim2.new(position, 0, yPos, 0)
    btn.Size = UDim2.new(0.35, 0, 0, 35)
    btn.Font = Enum.Font.Gotham
    btn.Text = name:upper()
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        selectedTrainingType = name:lower()
        ArmsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        LegsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        BackButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        AgilityButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        btn.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
    end)
    
    return btn
end

ArmsButton = createTypeButton("Arms", 0.1, 0.28)
LegsButton = createTypeButton("Legs", 0.55, 0.28)
BackButton = createTypeButton("Back", 0.1, 0.37)
AgilityButton = createTypeButton("Agility", 0.55, 0.37)
ArmsButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)

-- Speed Controls
SpeedLabel.Name = "SpeedLabel"
SpeedLabel.Parent = ContentFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.1, 0, 0.48, 0)
SpeedLabel.Size = UDim2.new(0.8, 0, 0, 25)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Training Speed: " .. trainingSpeed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 14
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

SpeedSlider.Name = "SpeedSlider"
SpeedSlider.Parent = ContentFrame
SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpeedSlider.Position = UDim2.new(0.1, 0, 0.54, 0)
SpeedSlider.Size = UDim2.new(0.8, 0, 0, 30)
SpeedSlider.Font = Enum.Font.Gotham
SpeedSlider.Text = "Increase Speed +"
SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSlider.TextSize = 12

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = SpeedSlider

SpeedSlider.MouseButton1Click:Connect(function()
    trainingSpeed = trainingSpeed + 1
    if trainingSpeed > 10 then trainingSpeed = 1 end
    SpeedLabel.Text = "Training Speed: " .. trainingSpeed
end)

-- Delay Input
DelayLabel.Name = "DelayLabel"
DelayLabel.Parent = ContentFrame
DelayLabel.BackgroundTransparency = 1
DelayLabel.Position = UDim2.new(0.1, 0, 0.63, 0)
DelayLabel.Size = UDim2.new(0.8, 0, 0, 25)
DelayLabel.Font = Enum.Font.GothamBold
DelayLabel.Text = "Delay (seconds):"
DelayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayLabel.TextSize = 14
DelayLabel.TextXAlignment = Enum.TextXAlignment.Left

DelayInput.Name = "DelayInput"
DelayInput.Parent = ContentFrame
DelayInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
DelayInput.Position = UDim2.new(0.1, 0, 0.69, 0)
DelayInput.Size = UDim2.new(0.8, 0, 0, 30)
DelayInput.Font = Enum.Font.Gotham
DelayInput.PlaceholderText = "0.01 (recommended)"
DelayInput.Text = "0.01"
DelayInput.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayInput.TextSize = 13

local DelayCorner = Instance.new("UICorner")
DelayCorner.CornerRadius = UDim.new(0, 6)
DelayCorner.Parent = DelayInput

DelayInput.FocusLost:Connect(function()
    local newDelay = tonumber(DelayInput.Text)
    if newDelay and newDelay >= 0.01 then
        trainingDelay = newDelay
    else
        DelayInput.Text = tostring(trainingDelay)
    end
end)

-- Combat Power Display
CombatPowerLabel.Name = "CombatPowerLabel"
CombatPowerLabel.Parent = ContentFrame
CombatPowerLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
CombatPowerLabel.Position = UDim2.new(0.1, 0, 0.81, 0)
CombatPowerLabel.Size = UDim2.new(0.8, 0, 0, 35)
CombatPowerLabel.Font = Enum.Font.GothamBold
CombatPowerLabel.Text = "Combat Power: Loading..."
CombatPowerLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
CombatPowerLabel.TextSize = 13

local CPCorner = Instance.new("UICorner")
CPCorner.CornerRadius = UDim.new(0, 6)
CPCorner.Parent = CombatPowerLabel

-- Shadow Effect
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.ZIndex = 0
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5

-- Update Combat Power Display
spawn(function()
    while wait(1) do
        pcall(function()
            local GetCombatPower = ReplicatedStorage.TrainSystem.Bindable.GetCombatPower
            local cp = GetCombatPower:Invoke(player)
            if cp then
                CombatPowerLabel.Text = "Combat Power: " .. tostring(cp)
            end
        end)
    end
end)

-- Minimize/Maximize Function
local function toggleMinimize()
    isMinimized = not isMinimized
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    
    if isMinimized then
        local sizeTween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 350, 0, 50)})
        sizeTween:Play()
        MinimizeButton.Text = "□"
        ContentFrame.Visible = false
    else
        local sizeTween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 350, 0, 500)})
        sizeTween:Play()
        MinimizeButton.Text = "—"
        wait(0.1)
        ContentFrame.Visible = true
    end
end

-- Minimize Button Click
MinimizeButton.MouseButton1Click:Connect(function()
    toggleMinimize()
end)

-- Close Button Click
CloseButton.MouseButton1Click:Connect(function()
    autoTrainEnabled = false
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    local sizeTween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
    sizeTween:Play()
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Toggle Functionality
ToggleButton.MouseButton1Click:Connect(function()
    autoTrainEnabled = not autoTrainEnabled
    
    if autoTrainEnabled then
        ToggleButton.Text = "STOP AUTO TRAIN"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        StatusLabel.Text = "Status: Active ✅"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        startAutoTrain()
    else
        ToggleButton.Text = "START AUTO TRAIN"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
        StatusLabel.Text = "Status: Inactive ⭕"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Button Hover Effects
local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
    end)
end

addHoverEffect(CloseButton, Color3.fromRGB(255, 70, 70), Color3.fromRGB(220, 50, 50))
addHoverEffect(MinimizeButton, Color3.fromRGB(255, 200, 50), Color3.fromRGB(255, 180, 0))

print("✅ Auto Training Script Loaded!")
print("📊 GUI Created with Minimize/Close buttons")
print("⚡ Configure settings and press START")
print("🎯 Drag title bar to move | — to minimize | × to close")
