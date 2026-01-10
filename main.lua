-- [[ ZENO HUB V10 | THE FINAL TERMINATOR EDITION ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌪️ ZENO HUB | V10 FINAL",
   LoadingTitle = "Assembling Final Weapons...",
   ConfigurationSaving = { Enabled = false }
})

-- [[ 🛡️ نظام الحماية (Anti-Kick) ]] --
local mt = getrawmetatable(game); setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    if getnamecallmethod() == "Kick" then return nil end
    return old(self, ...)
end)

-- [[ 🎯 اختيار الضحية - Target Selection ]] --
local MainTab = Window:CreateTab("🎯 Target List", 4483345998)
local SelectedTarget = ""

local function RefreshList()
    local p = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then table.insert(p, v.Name) end
    end
    return p
end

local PlayerDrop = MainTab:CreateDropdown({
   Name = "Select Victim",
   Options = RefreshList(),
   CurrentOption = {""},
   Callback = function(Option) SelectedTarget = Option[1] end,
})

MainTab:CreateButton({Name = "Refresh Players", Callback = function() PlayerDrop:Refresh(RefreshList()) end})

-- [[ 💀 ميزة القتل المستهدف - Target Kill (جديد) ]] --
local KillTab = Window:CreateTab("💀 Elimination", 4483345998)

KillTab:CreateButton({
   Name = "Kill Target (قتل الضحية)",
   Callback = function()
       local vic = game.Players:FindFirstChild(SelectedTarget)
       if vic and vic.Character then
           -- الطريقة الأولى: تصفير الدم
           if vic.Character:FindFirstChild("Humanoid") then
               vic.Character.Humanoid.Health = 0
           end
           -- الطريقة الثانية (للمابات المحمية): إرساله للعدم ليموت فوراً
           vic.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
           Rayfield:Notify({Title = "Eliminated", Content = SelectedTarget .. " has been sent to spawn!", Duration = 3})
       end
   end,
})

-- [[ 🏠 تدمير البيوت - House Control ]] --
local HouseTab = Window:CreateTab("🏠 Houses", 4483345998)

HouseTab:CreateButton({
   Name = "Delete Victim's House",
   Callback = function()
       for _, v in pairs(workspace:GetDescendants()) do
           if v:IsA("Model") then
               local owner = v:FindFirstChild("Owner") or v:FindFirstChild("OwnerName")
               if (owner and tostring(owner.Value) == SelectedTarget) or v.Name:lower():find(SelectedTarget:lower()) then
                   v:Destroy()
               end
           end
       end
   end,
})

HouseTab:CreateButton({Name = "Delete All Houses", Callback = function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and (v.Name:find("House") or v:FindFirstChild("Owner")) then v:Destroy() end
    end
end})

-- [[ 🎭 انتحال الشخصية - Full Avatar Mirror ]] --
local MirrorTab = Window:CreateTab("🎭 Mirror", 4483345998)

MirrorTab:CreateButton({
   Name = "Mirror (نسخ الأفاتار الحقيقي)",
   Callback = function()
       local target = game.Players:FindFirstChild(SelectedTarget)
       local me = game.Players.LocalPlayer
       if target and me.Character then
           local success, desc = pcall(function() return game.Players:GetHumanoidDescriptionFromUserId(target.UserId) end)
           if success then me.Character.Humanoid:ApplyDescription(desc) end
       end
   end,
})

-- [[ 🚀 الخطف والسحب - Seize & Abduct ]] --
local SeizeTab = Window:CreateTab("🚀 Seize", 4483345998)
local Seizing = false
SeizeTab:CreateToggle({
   Name = "Abduct & Freeze",
   CurrentValue = false,
   Callback = function(V)
       Seizing = V
       local vic = game.Players:FindFirstChild(SelectedTarget)
       local me = game.Players.LocalPlayer.Character
       if vic and vic.Character and me then
           spawn(function()
               while Seizing do
                   vic.Character.HumanoidRootPart.CFrame = me.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                   task.wait(0.01)
               end
           end)
       end
   end,
})

-- [[ ⚡ الحركة - Fly & Speed ]] --
local MoveTab = Window:CreateTab("⚡ Movement", 4483345998)
local FlySpeed = 50
local Flying = false

MoveTab:CreateSlider({
   Name = "Speed",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(V) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V end,
})

MoveTab:CreateToggle({
   Name = "Fly Mode",
   CurrentValue = false,
   Callback = function(S)
       Flying = S
       local root = game.Players.LocalPlayer.Character.HumanoidRootPart
       if Flying then
           local bv = Instance.new("BodyVelocity", root)
           bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
           spawn(function()
               while Flying do
                   bv.Velocity = game.Players.LocalPlayer:GetMouse().Hit.LookVector * FlySpeed
                   task.wait()
               end
               bv:Destroy()
           end)
       end
   end,
})

Rayfield:Notify({Title = "ZENO V10", Content = "Ultimate Master Script Ready!", Duration = 5})
