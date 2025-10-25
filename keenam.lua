-- ULTIMATE Combat Power Multiplier for Delta
-- Advanced Hook System - Maximum Gains

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local Config = {
    Multiplier = 1000,        -- Start with 1000x
    SpeedMultiplier = 50,     -- 50x faster training
    AutoTrain = false,
    Enabled = false,
    HookActive = false
}

local Stats = {
    TotalGains = 0,
    TrainCount = 0,
    LastValue = 0
}

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateBooster"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 500)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 255, 200)
Stroke.Thickness = 3
Stroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ ULTIMATE MULTIPLIER ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBlack
Title.Parent = Header

-- Content Area
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -80)
Content.Position = UDim2.new(0, 10, 0, 70)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 6
Content.Parent = MainFrame

-- Status Display
local StatusBox = Instance.new("Frame")
StatusBox.Size = UDim2.new(1, 0, 0, 120)
StatusBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
StatusBox.BorderSizePixel = 0
StatusBox.Parent = Content

local SBCorner = Instance.new("UICorner")
SBCorner.CornerRadius = UDim.new(0, 10)
SBCorner.Parent = StatusBox

local StatusTitle = Instance.new("TextLabel")
StatusTitle.Size = UDim2.new(1, -20, 0, 30)
StatusTitle.Position = UDim2.new(0, 10, 0, 5)
StatusTitle.BackgroundTransparency = 1
StatusTitle.Text = "📊 STATUS"
StatusTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
StatusTitle.TextSize = 16
StatusTitle.Font = Enum.Font.GothamBold
StatusTitle.TextXAlignment = Enum.TextXAlignment.Left
StatusTitle.Parent = StatusBox

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 25)
StatusLabel.Position = UDim2.new(0, 10, 0, 35)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "⚪ INACTIVE"
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.TextSize = 15
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = StatusBox

local GainLabel = Instance.new("TextLabel")
GainLabel.Size = UDim2.new(1, -20, 0, 22)
GainLabel.Position = UDim2.new(0, 10, 0, 62)
GainLabel.BackgroundTransparency = 1
GainLabel.Text = "💎 Total Gain: +0"
GainLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
GainLabel.TextSize = 14
GainLabel.Font = Enum.Font.Gotham
GainLabel.TextXAlignment = Enum.TextXAlignment.Left
GainLabel.Parent = StatusBox

local CountLabel = Instance.new("TextLabel")
CountLabel.Size = UDim2.new(1, -20, 0, 22)
CountLabel.Position = UDim2.new(0, 10, 0, 88)
CountLabel.BackgroundTransparency = 1
CountLabel.Text = "🎯 Training Count: 0"
CountLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
CountLabel.TextSize = 13
CountLabel.Font = Enum.Font.Gotham
CountLabel.TextXAlignment = Enum.TextXAlignment.Left
CountLabel.Parent = StatusBox

-- Multiplier Section
local MultBox = Instance.new("Frame")
MultBox.Size = UDim2.new(1, 0, 0, 110)
MultBox.Position = UDim2.new(0, 0, 0, 130)
MultBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MultBox.BorderSizePixel = 0
MultBox.Parent = Content

local MBCorner = Instance.new("UICorner")
MBCorner.CornerRadius = UDim.new(0, 10)
MBCorner.Parent = MultBox

local MultTitle = Instance.new("TextLabel")
MultTitle.Size = UDim2.new(1, -20, 0, 30)
MultTitle.Position = UDim2.new(0, 10, 0, 5)
MultTitle.BackgroundTransparency = 1
MultTitle.Text = "🔥 GAIN MULTIPLIER: x1000"
MultTitle.TextColor3 = Color3.fromRGB(255, 100, 255)
MultTitle.TextSize = 16
MultTitle.Font = Enum.Font.GothamBold
MultTitle.TextXAlignment = Enum.TextXAlignment.Left
MultTitle.Parent = MultBox

local MultInfo = Instance.new("TextLabel")
MultInfo.Size = UDim2.new(1, -20, 0, 20)
MultInfo.Position = UDim2.new(0, 10, 0, 35)
MultInfo.BackgroundTransparency = 1
MultInfo.Text = "Each training session will be multiplied by this value"
MultInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
MultInfo.TextSize = 11
MultInfo.Font = Enum.Font.Gotham
MultInfo.TextXAlignment = Enum.TextXAlignment.Left
MultInfo.Parent = MultBox

local MultInput = Instance.new("TextBox")
MultInput.Size = UDim2.new(1, -20, 0, 40)
MultInput.Position = UDim2.new(0, 10, 0, 60)
MultInput.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MultInput.BorderSizePixel = 0
MultInput.Text = "1000"
MultInput.PlaceholderText = "Enter multiplier (1-999999)"
MultInput.TextColor3 = Color3.fromRGB(255, 255, 0)
MultInput.TextSize = 18
MultInput.Font = Enum.Font.GothamBold
MultInput.Parent = MultBox

local MICorner = Instance.new("UICorner")
MICorner.CornerRadius = UDim.new(0, 8)
MICorner.Parent = MultInput

-- Speed Section
local SpeedBox = Instance.new("Frame")
SpeedBox.Size = UDim2.new(1, 0, 0, 110)
SpeedBox.Position = UDim2.new(0, 0, 0, 250)
SpeedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
SpeedBox.BorderSizePixel = 0
SpeedBox.Parent = Content

local SpBCorner = Instance.new("UICorner")
SpBCorner.CornerRadius = UDim.new(0, 10)
SpBCorner.Parent = SpeedBox

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, -20, 0, 30)
SpeedTitle.Position = UDim2.new(0, 10, 0, 5)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "⚡ SPEED MULTIPLIER: x50"
SpeedTitle.TextColor3 = Color3.fromRGB(255, 200, 50)
SpeedTitle.TextSize = 16
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.Parent = SpeedBox

local SpeedInfo = Instance.new("TextLabel")
SpeedInfo.Size = UDim2.new(1, -20, 0, 20)
SpeedInfo.Position = UDim2.new(0, 10, 0, 35)
SpeedInfo.BackgroundTransparency = 1
SpeedInfo.Text = "Multiplies training speed sent to server"
SpeedInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
SpeedInfo.TextSize = 11
SpeedInfo.Font = Enum.Font.Gotham
SpeedInfo.TextXAlignment = Enum.TextXAlignment.Left
SpeedInfo.Parent = SpeedBox

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, -20, 0, 40)
SpeedInput.Position = UDim2.new(0, 10, 0, 60)
SpeedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SpeedInput.BorderSizePixel = 0
SpeedInput.Text = "50"
SpeedInput.PlaceholderText = "Enter speed (1-1000)"
SpeedInput.TextColor3 = Color3.fromRGB(255, 200, 0)
SpeedInput.TextSize = 18
SpeedInput.Font = Enum.Font.GothamBold
SpeedInput.Parent = SpeedBox

local SICorner = Instance.new("UICorner")
SICorner.CornerRadius = UDim.new(0, 8)
SICorner.Parent = SpeedInput

-- Buttons
local EnableBtn = Instance.new("TextButton")
EnableBtn.Size = UDim2.new(1, 0, 0, 55)
EnableBtn.Position = UDim2.new(0, 0, 0, 370)
EnableBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
EnableBtn.Text = "🚀 ACTIVATE MULTIPLIER"
EnableBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableBtn.TextSize = 19
EnableBtn.Font = Enum.Font.GothamBlack
EnableBtn.BorderSizePixel = 0
EnableBtn.Parent = Content

local EBCorner = Instance.new("UICorner")
EBCorner.CornerRadius = UDim.new(0, 12)
EBCorner.Parent = EnableBtn

local EBStroke = Instance.new("UIStroke")
EBStroke.Color = Color3.fromRGB(255, 100, 100)
EBStroke.Thickness = 3
EBStroke.Parent = EnableBtn

local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(1, 0, 0, 45)
AutoBtn.Position = UDim2.new(0, 0, 0, 435)
AutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
AutoBtn.Text = "🤖 AUTO TRAIN: OFF"
AutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBtn.TextSize = 16
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.BorderSizePixel = 0
AutoBtn.Parent = Content

local ABCorner = Instance.new("UICorner")
ABCorner.CornerRadius = UDim.new(0, 10)
ABCorner.Parent = AutoBtn

-- Helper Functions
local function FormatNumber(n)
    if n >= 1e12 then return string.format("%.2fT", n / 1e12)
    elseif n >= 1e9 then return string.format("%.2fB", n / 1e9)
    elseif n >= 1e6 then return string.format("%.2fM", n / 1e6)
    elseif n >= 1e3 then return string.format("%.2fK", n / 1e3)
    else return tostring(math.floor(n)) end
end

local function UpdateDisplay()
    MultTitle.Text = string.format("🔥 GAIN MULTIPLIER: x%d", Config.Multiplier)
    SpeedTitle.Text = string.format("⚡ SPEED MULTIPLIER: x%d", Config.SpeedMultiplier)
    GainLabel.Text = string.format("💎 Total Gain: +%s", FormatNumber(Stats.TotalGains))
    CountLabel.Text = string.format("🎯 Training Count: %d", Stats.TrainCount)
end

-- Input Handlers
MultInput.FocusLost:Connect(function()
    local value = tonumber(MultInput.Text)
    if value and value >= 1 and value <= 999999 then
        Config.Multiplier = math.floor(value)
        UpdateDisplay()
    else
        MultInput.Text = tostring(Config.Multiplier)
    end
end)

SpeedInput.FocusLost:Connect(function()
    local value = tonumber(SpeedInput.Text)
    if value and value >= 1 and value <= 1000 then
        Config.SpeedMultiplier = math.floor(value)
        UpdateDisplay()
    else
        SpeedInput.Text = tostring(Config.SpeedMultiplier)
    end
end)

-- Button Handlers
EnableBtn.MouseButton1Click:Connect(function()
    Config.Enabled = not Config.Enabled
    if Config.Enabled then
        EnableBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        EnableBtn.Text = "✅ MULTIPLIER ACTIVE"
        StatusLabel.Text = "🟢 ACTIVE - MULTIPLYING GAINS!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        EBStroke.Color = Color3.fromRGB(100, 255, 100)
    else
        EnableBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        EnableBtn.Text = "🚀 ACTIVATE MULTIPLIER"
        StatusLabel.Text = "⚪ INACTIVE"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        EBStroke.Color = Color3.fromRGB(255, 100, 100)
    end
end)

AutoBtn.MouseButton1Click:Connect(function()
    Config.AutoTrain = not Config.AutoTrain
    if Config.AutoTrain then
        AutoBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        AutoBtn.Text = "🤖 AUTO TRAIN: ON"
    else
        AutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        AutoBtn.Text = "🤖 AUTO TRAIN: OFF"
    end
end)

-- CORE HOOK SYSTEM
local function SetupHooks()
    if Config.HookActive then return end
    Config.HookActive = true
    
    -- Hook __namecall for FireServer and InvokeServer
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if not Config.Enabled then
            return oldNamecall(self, ...)
        end
        
        local method = getnamecallmethod()
        local args = {...}
        
        -- Hook FireServer - Multiply outgoing values
        if method == "FireServer" then
            if self.Name == "TrainSpeedHasChanged" then
                if args[1] and tonumber(args[1]) then
                    args[1] = args[1] * Config.SpeedMultiplier
                    Stats.TrainCount = Stats.TrainCount + 1
                    task.spawn(UpdateDisplay)
                end
            end
            return oldNamecall(self, unpack(args))
        end
        
        -- Hook InvokeServer - Multiply return values
        if method == "InvokeServer" then
            local results = {oldNamecall(self, ...)}
            
            if Config.Enabled then
                for i, result in ipairs(results) do
                    if typeof(result) == "number" and result > 0 then
                        results[i] = result * Config.Multiplier
                        Stats.TotalGains = Stats.TotalGains + (result * (Config.Multiplier - 1))
                    end
                end
                task.spawn(UpdateDisplay)
            end
            
            return unpack(results)
        end
        
        return oldNamecall(self, ...)
    end)
    
    print("✅ Hook System Active")
end

-- Hook BindableFunction Invoke
task.spawn(function()
    task.wait(2)
    
    local TrainSystem = ReplicatedStorage:FindFirstChild("TrainSystem")
    if TrainSystem and TrainSystem:FindFirstChild("Bindable") then
        for _, bindable in pairs(TrainSystem.Bindable:GetChildren()) do
            if bindable:IsA("BindableFunction") then
                pcall(function()
                    local oldInvoke = bindable.Invoke
                    bindable.Invoke = function(self, ...)
                        local results = {oldInvoke(self, ...)}
                        
                        if Config.Enabled then
                            for i, result in ipairs(results) do
                                if typeof(result) == "number" and result > 0 then
                                    results[i] = result * Config.Multiplier
                                end
                            end
                        end
                        
                        return unpack(results)
                    end
                    print("✅ Hooked:", bindable.Name)
                end)
            end
        end
    end
end)

-- Monitor incoming RemoteEvents
task.spawn(function()
    task.wait(2)
    
    local TrainSystem = ReplicatedStorage:FindFirstChild("TrainSystem")
    if TrainSystem and TrainSystem:FindFirstChild("Remote") then
        local trainValueChanged = TrainSystem.Remote:FindFirstChild("PlayerTrainValueHasChanged")
        if trainValueChanged then
            trainValueChanged.OnClientEvent:Connect(function(plr, trainType, newVal, oldVal)
                if Config.Enabled and newVal and oldVal then
                    local actualGain = newVal - oldVal
                    Stats.TotalGains = Stats.TotalGains + (actualGain * Config.Multiplier)
                    task.spawn(UpdateDisplay)
                end
            end)
            print("✅ Monitoring: PlayerTrainValueHasChanged")
        end
    end
end)

-- Auto Train Loop
task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoTrain and Config.Enabled then
            pcall(function()
                local TrainEquip = ReplicatedStorage:FindFirstChild("TrainEquipment")
                if TrainEquip and TrainEquip:FindFirstChild("Remote") then
                    local stationary = TrainEquip.Remote:FindFirstChild("ApplyStationaryTrain")
                    if stationary then
                        stationary:InvokeServer()
                    end
                    
                    local mobile = TrainEquip.Remote:FindFirstChild("ApplyMobileTrain")
                    if mobile then
                        mobile:InvokeServer()
                    end
                end
            end)
        end
    end
end)

-- Initialize
SetupHooks()
UpdateDisplay()

print("⚡ ============================================")
print("⚡ ULTIMATE COMBAT POWER MULTIPLIER - LOADED!")
print("⚡ ============================================")
print("")
print("🎯 DEFAULT SETTINGS:")
print("   • Gain Multiplier: x1000")
print("   • Speed Multiplier: x50")
print("")
print("💡 EXPECTED RESULTS (x1000 multiplier):")
print("   • Arms: 36,000,000 per training")
print("   • Legs: 72,000,000 per training")
print("   • Back: 18,000,000 per training")
print("   • Agility: 36,000,000 per training")
print("")
print("🚀 USAGE:")
print("   1. Adjust multipliers if needed")
print("   2. Click 'ACTIVATE MULTIPLIER'")
print("   3. Enable 'AUTO TRAIN' (optional)")
print("   4. Start training!")
print("")
print("⚡ Your gains will be INSANE! 🔥")
print("⚡ ============================================")
