-- Combat Power Auto Trainer v3 - Fast Automation
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedLabel = Instance.new("TextLabel")
local SpeedSlider = Instance.new("TextBox")
local AutoTrainButton = Instance.new("TextButton")
local TrainMethodButton = Instance.new("TextButton")
local StatsFrame = Instance.new("Frame")
local StatsTitle = Instance.new("TextLabel")
local TrainCountLabel = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")

-- GUI Setup
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

-- Add corner radius
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ ULTRA FAST TRAINER"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

SpeedLabel.Parent = MainFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.05, 0, 0.18, 0)
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Training Speed (per second)"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

SpeedSlider.Parent = MainFrame
SpeedSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Position = UDim2.new(0.05, 0, 0.27, 0)
SpeedSlider.Size = UDim2.new(0.9, 0, 0, 35)
SpeedSlider.Font = Enum.Font.GothamBold
SpeedSlider.Text = "100"
SpeedSlider.PlaceholderText = "1-1000"
SpeedSlider.TextColor3 = Color3.fromRGB(255, 215, 0)
SpeedSlider.TextSize = 16

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 6)
SliderCorner.Parent = SpeedSlider

TrainMethodButton.Parent = MainFrame
TrainMethodButton.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
TrainMethodButton.BorderSizePixel = 0
TrainMethodButton.Position = UDim2.new(0.05, 0, 0.43, 0)
TrainMethodButton.Size = UDim2.new(0.9, 0, 0, 35)
TrainMethodButton.Font = Enum.Font.GothamBold
TrainMethodButton.Text = "Method: SPAM SERVER"
TrainMethodButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TrainMethodButton.TextSize = 13

local MethodCorner = Instance.new("UICorner")
MethodCorner.CornerRadius = UDim.new(0, 6)
MethodCorner.Parent = TrainMethodButton

AutoTrainButton.Parent = MainFrame
AutoTrainButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
AutoTrainButton.BorderSizePixel = 0
AutoTrainButton.Position = UDim2.new(0.05, 0, 0.58, 0)
AutoTrainButton.Size = UDim2.new(0.9, 0, 0, 40)
AutoTrainButton.Font = Enum.Font.GothamBold
AutoTrainButton.Text = "START TRAINING"
AutoTrainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTrainButton.TextSize = 16

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = AutoTrainButton

StatsFrame.Parent = MainFrame
StatsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
StatsFrame.BorderSizePixel = 0
StatsFrame.Position = UDim2.new(0.05, 0, 0.73, 0)
StatsFrame.Size = UDim2.new(0.9, 0, 0, 50)

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 6)
StatsCorner.Parent = StatsFrame

StatsTitle.Parent = StatsFrame
StatsTitle.BackgroundTransparency = 1
StatsTitle.Size = UDim2.new(1, 0, 0, 20)
StatsTitle.Font = Enum.Font.GothamBold
StatsTitle.Text = "STATISTICS"
StatsTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
StatsTitle.TextSize = 11

TrainCountLabel.Parent = StatsFrame
TrainCountLabel.BackgroundTransparency = 1
TrainCountLabel.Position = UDim2.new(0, 0, 0.4, 0)
TrainCountLabel.Size = UDim2.new(1, 0, 0, 30)
TrainCountLabel.Font = Enum.Font.GothamBold
TrainCountLabel.Text = "Trains: 0 | Speed: 0/s"
TrainCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TrainCountLabel.TextSize = 12

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.93, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Ready to start"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 10

-- Variables
local autoTrainEnabled = false
local trainMethod = 1 -- 1 = Spam Server, 2 = Multi-Thread
local trainCount = 0
local lastTrainTime = tick()
local currentSpeed = 0

-- Core Functions
local function updateStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color or Color3.fromRGB(150, 150, 150)
end

local function spamTrainServer()
    local success, err = pcall(function()
        -- Spam Multiple Training Remotes
        local ApplyMobile = ReplicatedStorage.TrainEquipment.Remote.ApplyMobileTrain
        local ApplyStationary = ReplicatedStorage.TrainEquipment.Remote.ApplyStationaryTrain
        local ApplyBinding = ReplicatedStorage.TrainEquipment.Remote.ApplyBindingTrainingEffect
        local ApplyBoost = ReplicatedStorage.TrainEquipment.Remote.ApplyBindingTrainingBoostEffect
        
        -- Fire all training methods simultaneously
        spawn(function() ApplyMobile:InvokeServer() end)
        spawn(function() ApplyStationary:InvokeServer() end)
        spawn(function() ApplyBinding:InvokeServer("Training_2001", "Emit_2") end)
        spawn(function() ApplyBoost:InvokeServer() end)
        
        trainCount = trainCount + 1
    end)
    
    if not success then
        updateStatus("Error: " .. tostring(err), Color3.fromRGB(255, 100, 100))
    end
end

local function calculateSpeed()
    local currentTime = tick()
    local timeDiff = currentTime - lastTrainTime
    if timeDiff >= 1 then
        currentSpeed = trainCount / timeDiff
        lastTrainTime = currentTime
        trainCount = 0
    end
end

-- Button Events
TrainMethodButton.MouseButton1Click:Connect(function()
    trainMethod = trainMethod == 1 and 2 or 1
    if trainMethod == 1 then
        TrainMethodButton.Text = "Method: SPAM SERVER"
        TrainMethodButton.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    else
        TrainMethodButton.Text = "Method: ULTRA SPAM"
        TrainMethodButton.BackgroundColor3 = Color3.fromRGB(200, 50, 100)
    end
end)

AutoTrainButton.MouseButton1Click:Connect(function()
    autoTrainEnabled = not autoTrainEnabled
    
    if autoTrainEnabled then
        AutoTrainButton.Text = "⚡ TRAINING ACTIVE"
        AutoTrainButton.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
        updateStatus("Training started!", Color3.fromRGB(50, 255, 50))
        trainCount = 0
        lastTrainTime = tick()
        
        -- Start training loops based on speed
        local speed = tonumber(SpeedSlider.Text) or 100
        local waitTime = 1 / speed
        
        if trainMethod == 1 then
            -- Single thread spam
            spawn(function()
                while autoTrainEnabled do
                    spamTrainServer()
                    calculateSpeed()
                    TrainCountLabel.Text = string.format("Trains: %d | Speed: %.1f/s", trainCount, currentSpeed)
                    wait(waitTime)
                end
            end)
        else
            -- Multi-thread ultra spam
            for i = 1, 5 do
                spawn(function()
                    while autoTrainEnabled do
                        spamTrainServer()
                        calculateSpeed()
                        TrainCountLabel.Text = string.format("Trains: %d | Speed: %.1f/s", trainCount, currentSpeed)
                        wait(waitTime / 5)
                    end
                end)
            end
        end
    else
        AutoTrainButton.Text = "START TRAINING"
        AutoTrainButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        updateStatus("Training stopped", Color3.fromRGB(255, 150, 50))
    end
end)

-- Anti-AFK
spawn(function()
    while true do
        wait(300) -- Every 5 minutes
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- Initial message
updateStatus("Ready! Set speed and click START", Color3.fromRGB(100, 200, 255))
print("⚡ Ultra Fast Trainer loaded!")
print("💡 TIP: Start with speed 100, increase if needed")
print("⚠️ Make sure you're near training equipment!")
