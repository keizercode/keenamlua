-- Combat Power Booster Script v2 - Server-Side Method
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TrainSpeedInput = Instance.new("TextBox")
local MultiplierInput = Instance.new("TextBox")
local TrainTypeDropdown = Instance.new("TextButton")
local AutoTrainButton = Instance.new("TextButton")
local SpeedBoostButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- GUI Setup
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -140)
MainFrame.Size = UDim2.new(0, 300, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "Combat Power Booster v2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

TrainSpeedInput.Parent = MainFrame
TrainSpeedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TrainSpeedInput.BorderSizePixel = 0
TrainSpeedInput.Position = UDim2.new(0.05, 0, 0.17, 0)
TrainSpeedInput.Size = UDim2.new(0.9, 0, 0, 30)
TrainSpeedInput.Font = Enum.Font.Gotham
TrainSpeedInput.PlaceholderText = "Train Speed (default: 9999999)"
TrainSpeedInput.Text = "9999999"
TrainSpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TrainSpeedInput.TextSize = 12

MultiplierInput.Parent = MainFrame
MultiplierInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MultiplierInput.BorderSizePixel = 0
MultiplierInput.Position = UDim2.new(0.05, 0, 0.32, 0)
MultiplierInput.Size = UDim2.new(0.9, 0, 0, 30)
MultiplierInput.Font = Enum.Font.Gotham
MultiplierInput.PlaceholderText = "Train Multiplier (default: 1000000)"
MultiplierInput.Text = "1000000"
MultiplierInput.TextColor3 = Color3.fromRGB(255, 255, 255)
MultiplierInput.TextSize = 12

TrainTypeDropdown.Parent = MainFrame
TrainTypeDropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TrainTypeDropdown.BorderSizePixel = 0
TrainTypeDropdown.Position = UDim2.new(0.05, 0, 0.47, 0)
TrainTypeDropdown.Size = UDim2.new(0.9, 0, 0, 30)
TrainTypeDropdown.Font = Enum.Font.Gotham
TrainTypeDropdown.Text = "Train Type: 1 (Arms)"
TrainTypeDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
TrainTypeDropdown.TextSize = 12

SpeedBoostButton.Parent = MainFrame
SpeedBoostButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
SpeedBoostButton.BorderSizePixel = 0
SpeedBoostButton.Position = UDim2.new(0.05, 0, 0.62, 0)
SpeedBoostButton.Size = UDim2.new(0.9, 0, 0, 30)
SpeedBoostButton.Font = Enum.Font.GothamBold
SpeedBoostButton.Text = "Apply Speed Boost"
SpeedBoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBoostButton.TextSize = 13

AutoTrainButton.Parent = MainFrame
AutoTrainButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
AutoTrainButton.BorderSizePixel = 0
AutoTrainButton.Position = UDim2.new(0.05, 0, 0.77, 0)
AutoTrainButton.Size = UDim2.new(0.9, 0, 0, 30)
AutoTrainButton.Font = Enum.Font.GothamBold
AutoTrainButton.Text = "Auto Train: OFF"
AutoTrainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTrainButton.TextSize = 13

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.05, 0, 0.92, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 10

-- Variables
local autoTrainEnabled = false
local currentTrainType = 1
local trainTypes = {
    [1] = "Arms",
    [2] = "Legs", 
    [3] = "Back",
    [4] = "Agility"
}

-- Functions
local function updateStatus(text)
    StatusLabel.Text = "Status: " .. text
end

local function applySpeedBoost()
    local speed = tonumber(TrainSpeedInput.Text) or 9999999
    
    pcall(function()
        -- Fire TrainSpeedHasChanged to server (the key remote!)
        local TrainSpeedRemote = ReplicatedStorage.TrainSystem.Remote.TrainSpeedHasChanged
        for i = 1, 100 do -- Spam multiple times
            TrainSpeedRemote:FireServer(speed)
        end
        
        -- Apply Click Train Speed Bonus
        local ApplyBonus = ReplicatedStorage.TrainSystem.Bindable.ApplyAddClickTrainSpeedBonus
        ApplyBonus:Invoke()
        
        updateStatus("Speed boost applied: " .. speed)
    end)
end

local function performTrain()
    pcall(function()
        -- Method 1: Mobile Train (works on mobile and PC)
        local ApplyMobileTrain = ReplicatedStorage.TrainEquipment.Remote.ApplyMobileTrain
        ApplyMobileTrain:InvokeServer()
        
        wait(0.05)
        
        -- Method 2: Stationary Train 
        local ApplyStationaryTrain = ReplicatedStorage.TrainEquipment.Remote.ApplyStationaryTrain
        ApplyStationaryTrain:InvokeServer()
        
        -- Apply training effects
        local ApplyBindingEffect = ReplicatedStorage.TrainEquipment.Remote.ApplyBindingTrainingEffect
        ApplyBindingEffect:InvokeServer("Training_2001", "Emit_2")
        
        local ApplyBoostEffect = ReplicatedStorage.TrainEquipment.Remote.ApplyBindingTrainingBoostEffect
        ApplyBoostEffect:InvokeServer()
    end)
end

local function fastTrain()
    if not autoTrainEnabled then return end
    
    local speed = tonumber(TrainSpeedInput.Text) or 9999999
    local multiplier = tonumber(MultiplierInput.Text) or 1000000
    
    pcall(function()
        -- Continuously fire train speed with high values
        for i = 1, multiplier do
            if not autoTrainEnabled then break end
            
            local TrainSpeedRemote = ReplicatedStorage.TrainSystem.Remote.TrainSpeedHasChanged
            TrainSpeedRemote:FireServer(speed)
            
            if i % 1000 == 0 then
                performTrain()
            end
        end
    end)
end

-- Button Connections
SpeedBoostButton.MouseButton1Click:Connect(function()
    applySpeedBoost()
end)

TrainTypeDropdown.MouseButton1Click:Connect(function()
    currentTrainType = currentTrainType + 1
    if currentTrainType > 4 then currentTrainType = 1 end
    TrainTypeDropdown.Text = "Train Type: " .. currentTrainType .. " (" .. trainTypes[currentTrainType] .. ")"
    updateStatus("Selected: " .. trainTypes[currentTrainType])
end)

AutoTrainButton.MouseButton1Click:Connect(function()
    autoTrainEnabled = not autoTrainEnabled
    if autoTrainEnabled then
        AutoTrainButton.Text = "Auto Train: ON"
        AutoTrainButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        updateStatus("Auto training started...")
        spawn(function()
            while autoTrainEnabled do
                fastTrain()
                wait(0.1)
            end
        end)
    else
        AutoTrainButton.Text = "Auto Train: OFF"
        AutoTrainButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        updateStatus("Auto training stopped")
    end
end)

-- Continuous train speed sender
spawn(function()
    while true do
        if autoTrainEnabled then
            local speed = tonumber(TrainSpeedInput.Text) or 9999999
            pcall(function()
                local TrainSpeedRemote = ReplicatedStorage.TrainSystem.Remote.TrainSpeedHasChanged
                TrainSpeedRemote:FireServer(speed)
                performTrain()
            end)
        end
        wait(0.05) -- Very fast loop
    end
end)

updateStatus("GUI Loaded! Click Speed Boost first!")
print("Combat Power Booster v2 loaded successfully!")
