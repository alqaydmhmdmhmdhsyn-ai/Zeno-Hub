-- [[ ZENO HUB | LEGENDARY FLUENT EDITION - V12 ]]
-- Anti-Kick + Stealth + All features replicated as much as possible

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "🌪️ ZENO HUB | LEGENDARY",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {}
Tabs.Targets = Window:AddTab({ Title = "🎯 Targets", Icon = "crosshair" })
Tabs.Mirror = Window:AddTab({ Title = "🎭 Mirror", Icon = "copy" })
Tabs.Kill = Window:AddTab({ Title = "💀 Kill", Icon = "skull" })
Tabs.Houses = Window:AddTab({ Title = "🏠 Houses", Icon = "home" })
Tabs.Seize = Window:AddTab({ Title = "🔗 Seize", Icon = "link" })
Tabs.Movement = Window:AddTab({ Title = "⚡ Movement", Icon = "zap" })
Tabs.Steal = Window:AddTab({ Title = "🚀 Instant Steal", Icon = "download" })
Tabs.Fixes = Window:AddTab({ Title = "🛠️ Fixes", Icon = "wrench" })

-- [[ Anti-Kick & Stealth ]]
local function SecureBypass()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" or method == "Ban" then
            return nil
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end
SecureBypass()

-- [[ Targets Section ]]
local SelectedTarget = ""

local PlayerDropdown
PlayerDropdown = Tabs.Targets:AddDropdown("TargetPlayer", {
    Title = "Select Target",
    Values = {},
    Multi = false,
    Default = 1,
    Callback = function(Value)
        SelectedTarget = Value
    end
})

local function RefreshPlayers()
    local players = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            table.insert(players, p.Name)
        end
    end
    PlayerDropdown:SetValues(players)
    if #players > 0 and SelectedTarget == "" then
        SelectedTarget = players[1]
        PlayerDropdown:SetValue(players[1])
    end
end

Tabs.Targets:AddButton({
    Title = "Refresh Players",
    Callback = RefreshPlayers
})

-- Auto Refresh every 8 seconds
task.spawn(function()
    while true do
        RefreshPlayers()
        task.wait(8)
    end
end)

RefreshPlayers() -- Initial refresh

-- [[ Mirror Appearance ]]
Tabs.Mirror:AddButton({
    Title = "Mirror Target Appearance (Full Copy)",
    Callback = function()
        if SelectedTarget == "" then Fluent:Notify({Title="Error",Content="Select a target first!"}) return end
        local targetPlr = game.Players:FindFirstChild(SelectedTarget)
        local lp = game.Players.LocalPlayer
        if targetPlr and lp.Character then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                local desc = game.Players:GetHumanoidDescriptionFromUserId(targetPlr.UserId)
                hum:ApplyDescription(desc)
                -- Force replication / reset
                task.delay(0.3, function()
                    hum.Health = 0
                end)
                Fluent:Notify({Title="Success",Content="Appearance mirrored! (may need respawn)"})
            end
        end
    end
})

-- [[ Kill ]]
Tabs.Kill:AddButton({
    Title = "Kill Target (Hard Drop)",
    Callback = function()
        if SelectedTarget == "" then Fluent:Notify({Title="Error",Content="Select a target!"}) return end
        local target = game.Players:FindFirstChild(SelectedTarget)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local root = target.Character.HumanoidRootPart
            for i = 1, 15 do
                root.CFrame = CFrame.new(0, -9999, 0)
                task.wait(0.03)
            end
            if target.Character:FindFirstChildOfClass("Humanoid") then
                target.Character.Humanoid.Health = 0
            end
            Fluent:Notify({Title="Success",Content="Target killed / dropped!"})
        end
    end
})

-- [[ Wipe House ]]
Tabs.Houses:AddButton({
    Title = "Wipe Target's House",
    Callback = function()
        if SelectedTarget == "" then Fluent:Notify({Title="Error",Content="Select a target!"}) return end
        local lowerName = string.lower(SelectedTarget)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (string.find(string.lower(obj.Name), lowerName) or (obj:FindFirstChild("Owner") and tostring(obj.Owner.Value) == SelectedTarget)) then
                for _, part in pairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Model") then
                        pcall(function() part:Destroy() end)
                    end
                end
                pcall(function() obj:Destroy() end)
            end
        end
        Fluent:Notify({Title="Success",Content="Target house wiped (if found)!"})
    end
})

-- [[ Seize / Abduct ]]
local Holding = false
Tabs.Seize:AddToggle("AbductToggle", {
    Title = "Abduct / Hold Target",
    Default = false,
    Callback = function(Value)
        Holding = Value
        if not Value then return end
        
        local victim = game.Players:FindFirstChild(SelectedTarget)
        local me = game.Players.LocalPlayer.Character
        
        if victim and victim.Character and me and me:FindFirstChild("HumanoidRootPart") then
            Fluent:Notify({Title="Abduct",Content="Holding target... (toggle off to release)"})
            
            local conn
            conn = game:GetService("RunService").Heartbeat:Connect(function()
                if not Holding then conn:Disconnect() return end
                if victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
                    local vRoot = victim.Character.HumanoidRootPart
                    vRoot.CFrame = me.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3.5)
                    vRoot.Velocity = Vector3.new()
                end
            end)
        else
            Fluent:Notify({Title="Error",Content="Target or your character not found!"})
            Holding = false
        end
    end
})

-- [[ Movement ]]
local currentSpeed = 16
Tabs.Movement:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Min = 16,
    Max = 300,
    Default = 16,
    Rounding = 1,
    Callback = function(Value)
        currentSpeed = Value
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = Value
            hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                hum.WalkSpeed = currentSpeed
            end)
        end
    end
})

local FlyEnabled = false
local FlySpeed = 50
Tabs.Movement:AddToggle("FlyToggle", {
    Title = "Fly (WASD + Space/Ctrl)",
    Default = false,
    Callback = function(v)
        FlyEnabled = v
        local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        if v then
            local bv = Instance.new("BodyVelocity", root)
            bv.MaxForce = Vector3.new(1e9,1e9,1e9)
            bv.Velocity = Vector3.new()
            
            local bg = Instance.new("BodyGyro", root)
            bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
            bg.P = 9000
            
            local conn = game:GetService("RunService").RenderStepped:Connect(function()
                if not FlyEnabled then conn:Disconnect() bv:Destroy() bg:Destroy() return end
                
                local cam = workspace.CurrentCamera
                local move = Vector3.new()
                local UIS = game:GetService("UserInputService")
                
                if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
                
                bv.Velocity = move.Unit * FlySpeed * (move.Magnitude > 0 and 1 or 0)
                bg.CFrame = cam.CFrame
            end)
        end
    end
})

-- [[ Instant Steal (change coords to your game secret location) ]]
Tabs.Steal:AddButton({
    Title = "Instant Steal Secret & Return",
    Callback = function()
        local lpChar = game.Players.LocalPlayer.Character
        if not lpChar or not lpChar:FindFirstChild("HumanoidRootPart") then return end
        
        local oldCF = lpChar.HumanoidRootPart.CFrame
        lpChar.HumanoidRootPart.CFrame = CFrame.new(0, 150, -2000) -- ← غير الإحداثيات دي حسب مكان الـ secret في اللعبة
        
        task.wait(0.6)
        
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part:FindFirstChild("TouchTransmitter") then
                firetouchinterest(lpChar.HumanoidRootPart, part, 0)
                task.wait(0.02)
                firetouchinterest(lpChar.HumanoidRootPart, part, 1)
            end
        end
        
        task.wait(0.3)
        lpChar.HumanoidRootPart.CFrame = oldCF
        Fluent:Notify({Title="Done",Content="Attempted instant steal!"})
    end
})

-- [[ Fixes ]]
Tabs.Fixes:AddButton({
    Title = "Re-Apply Anti-Kick",
    Callback = SecureBypass
})

Fluent:Notify({
    Title = "ZENO HUB Legendary",
    Content = "Loaded successfully with Fluent UI! Enjoy 🚀",
    Duration = 8
})
