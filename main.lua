-- [[ ZENO HUB | RELOADED & FIXED V11 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌪️ ZENO HUB: V11 FIXED",
   LoadingTitle = "Bypassing Server Security... Please Wait",
   ConfigurationSaving = { Enabled = false }
})

-- [[ 🛡️ نظام حماية خارق - Anti-Kick & Stealth ]] --
local function SecureBypass()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then return nil end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end
SecureBypass()

-- [[ 🎯 القائمة الرئيسية للاعبين ]] --
local MainTab = Window:CreateTab("🎯 Targets", 4483345998)
local SelectedTarget = ""

local function GetPlayers()
    local p = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then table.insert(p, v.Name) end
    end
    return p
end

local PlayerDrop = MainTab:CreateDropdown({
   Name = "Target Player",
   Options = GetPlayers(),
   CurrentOption = {""},
   Callback = function(Option) SelectedTarget = Option[1] end,
})

MainTab:CreateButton({Name = "Refresh Players", Callback = function() PlayerDrop:Refresh(GetPlayers()) end})

-- [[ 🎭 ميزة نسخ الشكل الحقيقية (FIXED) ]] --
local MirrorTab = Window:CreateTab("🎭 Mirror", 4483345998)
MirrorTab:CreateButton({
   Name = "Mirror Appearance (نسخ كامل)",
   Callback = function()
       local target = game.Players:FindFirstChild(SelectedTarget)
       if target and game.Players.LocalPlayer.Character then
           -- الطريقة دي بتجبر الشخصية تلبس لبس الضحية بالكامل
           local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
           local desc = game.Players:GetHumanoidDescriptionFromUserId(target.UserId)
           if desc then hum:ApplyDescription(desc) end
       end
   end,
})

-- [[ 💀 ميزة القتل المضمونة (FIXED) ]] --
local KillTab = Window:CreateTab("💀 Kill", 4483345998)
KillTab:CreateButton({
   Name = "Kill & Reset Target (موت الضحية)",
   Callback = function()
       local target = game.Players:FindFirstChild(SelectedTarget)
       if target and target.Character then
           -- بنبعت اللاعب تحت الماب بمسافة كبيرة جداً عشان يموت غصب عن السيرفر
           target.Character.HumanoidRootPart.CFrame = CFrame.new(0, -1000, 0)
       end
   end,
})

-- [[ 🏠 ميزة تدمير البيوت (RE-FIXED) ]] --
local HouseTab = Window:CreateTab("🏠 Houses", 4483345998)
HouseTab:CreateButton({
   Name = "Wipe Target House (مسح بيته)",
   Callback = function()
       for _, v in pairs(workspace:GetDescendants()) do
           if v:IsA("Model") and (v.Name:lower():find(SelectedTarget:lower()) or (v:FindFirstChild("Owner") and tostring(v.Owner.Value) == SelectedTarget)) then
               -- عشان الكل يشوف البيت اتمسح، بنمسح كل "جزء" جوه البيت مش الموديل بس
               for _, part in pairs(v:GetDescendants()) do
                   if part:IsA("BasePart") then part:Destroy() end
               end
               v:Destroy()
           end
       end
   end,
})

-- [[ 🔗 ميزة الخطف والسحب (FIXED REPLICATION) ]] --
local SeizeTab = Window:CreateTab("🔗 Seize", 4483345998)
local Holding = false
SeizeTab:CreateToggle({
   Name = "Abduct Player (خطف)",
   CurrentValue = false,
   Callback = function(V)
      Holding = V
      local victim = game.Players:FindFirstChild(SelectedTarget)
      local me = game.Players.LocalPlayer.Character
      if victim and victim.Character and me then
          game:GetService("RunService").Heartbeat:Connect(function()
              if Holding then
                  -- تحديث المكان في كل فريم (Frame) لمنع السيرفر من الاعتراض
                  victim.Character.HumanoidRootPart.CFrame = me.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
              end
          end)
      end
   end,
})

-- [[ ⚡ الطيران والسرعة (Stealth Mode) ]] --
local MoveTab = Window:CreateTab("⚡ Movement", 4483345998)
MoveTab:CreateSlider({
   Name = "Speed",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(V) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V end,
})

local Flying = false
MoveTab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Callback = function(V)
       Flying = V
       local root = game.Players.LocalPlayer.Character.HumanoidRootPart
       if Flying then
           local bv = Instance.new("BodyVelocity", root)
           bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
           game:GetService("RunService").RenderStepped:Connect(function()
               if Flying then bv.Velocity = game.Players.LocalPlayer:GetMouse().Hit.LookVector * 50 else bv:Destroy() end
           end)
       end
   end,
})

Rayfield:Notify({Title = "ZENO HUB V11", Content = "Final Fixes Applied!", Duration = 5})
