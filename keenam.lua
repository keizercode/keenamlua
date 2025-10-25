-- Combat Power Booster Script for Delta Executor
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TrainValueInput = Instance.new("TextBox")
local CombatPowerInput = Instance.new("TextBox")
local BoostButton = Instance.new("TextButton")
local AutoTrainButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- GUI Properties
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -120)
MainFrame.Size = UDim2.new(0, 300, 0, 240)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "Combat Power Booster"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

TrainValueInput.Parent = MainFrame
TrainValueInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TrainValueInput.BorderSizePixel = 0
TrainValueInput.Position = UDim2.new(0.05, 0, 0.2, 0)
TrainValueInput.Size = UDim2.new(0.9, 0, 0, 30)
TrainValueInput.Font = Enum.Font.Gotham
TrainValueInput.PlaceholderText = "Train Value (e.g., 999999999999)"
TrainValueInput.Text = ""
TrainValueInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TrainValueInput.TextSize = 12

CombatPowerInput.Parent = MainFrame
CombatPowerInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CombatPowerInput.BorderSizePixel = 0
CombatPowerInput.Position = UDim2.new(0.05, 0, 0.4, 0)
CombatPowerInput.Size = UDim2.new(0.9, 0, 0, 30)
CombatPowerInput.Font = Enum.Font.Gotham
CombatPowerInput.PlaceholderText = "Combat Power (e.g., 999999999999)"
CombatPowerInput.Text = ""
CombatPowerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CombatPowerInput.TextSize = 12

BoostButton.Parent = MainFrame
BoostButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
BoostButton.BorderSizePixel = 0
BoostButton.Position = UDim2.new(0.05, 0, 0.6, 0)
BoostButton.Size = UDim2.new(0.9, 0, 0, 30)
BoostButton.Font = Enum.Font.GothamBold
BoostButton.Text = "Boost Stats"
BoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BoostButton.TextSize = 14

AutoTrainButton.Parent = MainFrame
AutoTrainButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
AutoTrainButton.BorderSizePixel = 0
AutoTrainButton.Position = UDim2.new(0.05, 0, 0.75, 0)
AutoTrainButton.Size = UDim2.new(0.9, 0, 0, 25)
AutoTrainButton.Font = Enum.Font.GothamBold
AutoTrainButton.Text = "Auto Train: OFF"
AutoTrainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTrainButton.TextSize = 12

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.05, 0, 0.9, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 10

-- Variables
local autoTrainEnabled = false

-- Functions
local function updateStatus(text)
    StatusLabel.Text = "Status: " .. text
end

local function boostStats()
    local trainValue = tonumber(TrainValueInput.Text) or 999999999999
    local combatPower = tonumber(CombatPowerInput.Text) or 999999999999
    
    pcall(function()
        -- Update train values for all elements (Arms, Legs, Back, Agility)
        for i = 1, 4 do
            local PlayerTrainValueHasChanged = ReplicatedStorage.TrainSystem.Bindable.PlayerTrainValueHasChanged
            PlayerTrainValueHasChanged:Fire(LocalPlayer, i, trainValue, trainValue)
        end
        
        -- Update Combat Power
        local PlayerCombatPowerHasChanged = ReplicatedStorage.TrainSystem.Bindable.PlayerCombatPowerHasChanged
        PlayerCombatPowerHasChanged:Fire(LocalPlayer, combatPower)
        
        -- Update Statistics
        local StatisticsDataHasChanged = ReplicatedStorage.Statistics.Bindable.StatisticsDataHasChanged
        StatisticsDataHasChanged:Fire(trainValue, 1)
        
        updateStatus("Boosted! Train: " .. trainValue .. " CP: " .. combatPower)
    end)
end

local function autoTrain()
    if not autoTrainEnabled then return end
    
    pcall(function()
        -- Simulate training action
        local ApplyStationaryTrain = ReplicatedStorage.TrainEquipment.Remote.ApplyStationaryTrain
        ApplyStationaryTrain:InvokeServer()
        
        -- Apply training speed bonus
        local trainValue = tonumber(TrainValueInput.Text) or 999999999999
        for i = 1, 4 do
            local PlayerTrainValueHasChanged = ReplicatedStorage.TrainSystem.Bindable.PlayerTrainValueHasChanged
            PlayerTrainValueHasChanged:Fire(LocalPlayer, i, trainValue, trainValue)
        end
    end)
end

-- Button Connections
BoostButton.MouseButton1Click:Connect(function()
    boostStats()
end)

AutoTrainButton.MouseButton1Click:Connect(function()
    autoTrainEnabled = not autoTrainEnabled
    if autoTrainEnabled then
        AutoTrainButton.Text = "Auto Train: ON"
        AutoTrainButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        updateStatus("Auto training enabled")
    else
        AutoTrainButton.Text = "Auto Train: OFF"
        AutoTrainButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        updateStatus("Auto training disabled")
    end
end)

-- Auto Train Loop
spawn(function()
    while true do
        if autoTrainEnabled then
            autoTrain()
        end
        wait(0.1)
    end
end)

updateStatus("GUI Loaded Successfully!")
print("Combat Power Booster loaded!")
