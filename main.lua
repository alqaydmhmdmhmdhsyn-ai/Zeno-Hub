-- [[ ZENO HUB | النسخة النهائية المنظمة والمراجعة ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌪️ ZENO HUB | FINAL CLEAN",
   LoadingTitle = "Reviewing All Features...",
   ConfigurationSaving = { Enabled = false }
})

-- [[ 🛡️ نظام الحماية التلقائي - Auto Bypass ]] --
local mt = getrawmetatable(game); setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    if getnamecallmethod() == "Kick" then return nil end
    return old(self, ...)
end)

-- [[ 🎯 القسم الأول: اختيار الضحية ]] --
local TargetTab = Window:CreateTab("🎯 Target Selection", 4483345998)
local SelectedTarget = ""

local function GetNames()
    local names = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then table.insert(names, p.Name) end
    end
    return names
end

local PlayerDrop = TargetTab:CreateDropdown({
   Name = "Select Victim (اختر الضحية)",
   Options = GetNames(),
   CurrentOption = {""},
   Callback = function(Option) SelectedTarget = Option[1] end,
})

TargetTab:CreateButton({
   Name = "Refresh Player List",
   Callback = function() PlayerDrop:Refresh(GetNames()) end,
})

-- [[ 🏠 القسم الثاني: تدمير البيوت (منفصل) ]] --
local HouseTab = Window:CreateTab("🏠 House Destruction", 4483345998)

HouseTab:CreateButton({
   Name = "Delete Target's House (حذف بيت الضحية فقط)",
   Callback = function()
       if SelectedTarget == "" then return end
       for _, v in pairs(workspace:GetDescendants()) do
           if v:IsA("Model") then
               local owner = v:FindFirstChild("Owner") or v:FindFirstChild("OwnerName")
               if (owner and tostring(owner.Value) == SelectedTarget) or v.Name:lower():find(SelectedTarget:lower()) then
                   v:Destroy()
               end
           end
       end
       Rayfield:Notify({Title = "Action", Content = "Target house deleted.", Duration = 2})
   end,
})

HouseTab:CreateButton({
   Name = "Delete ALL Houses (حذف كل بيوت السيرفر)",
   Callback = function()
       for _, v in pairs(workspace:GetDescendants()) do
           if v:IsA("Model") and (v.Name:find("House") or v:FindFirstChild("Owner")) then
               v:Destroy()
           end
       end
       Rayfield:Notify({Title = "Action", Content = "All houses wiped!", Duration = 2})
   end,
})

-- [[ 🎭 القسم الثالث: نسخ الشكل (انتحال الشخصية) ]] --
local MirrorTab = Window:CreateTab("🎭 Mirror Shape", 4483345998)

MirrorTab:CreateButton({
   Name = "Mirror (نسخ شكل الضحية)",
   Callback = function()
       local target = game.Players:FindFirstChild(SelectedTarget)
       local char = game.Players.LocalPlayer.Character
       if target and char then
           for _, v in pairs(char:GetChildren()) do
               if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then v:Destroy() end
           end
           for _, v in pairs(target.Character:GetChildren()) do
               if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then v:Clone().Parent = char end
           end
       end
   end,
})

-- [[ 🚀 القسم الرابع: سحب اللاعبين (Bring) ]] --
local BringTab = Window:CreateTab("🚀 Bring Player", 4483345998)

BringTab:CreateButton({
   Name = "Bring Victim (سحب الضحية إليك)",
   Callback = function()
       local p = game.Players:FindFirstChild(SelectedTarget)
       if p and p.Character then
           p.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
       end
   end,
})

-- [[ ⚡ القسم الخامس: الطيران والسرعة ]] --
local MoveTab = Window:CreateTab("⚡ Movement", 4483345998)
local FlySpeed = 50
local Flying = false

MoveTab:CreateSlider({
   Name = "Speed Bypass",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(V) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V end,
})

MoveTab:CreateToggle({
   Name = "Fly Mode (طيران الماوس)",
   CurrentValue = false,
   Callback = function(State)
       Flying = State
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

-- [[ 🔗 القسم السادس: الخطف والتحكم ]] --
local SeizeTab = Window:CreateTab("🔗 Seize System", 4483345998)
local Abducting = false

SeizeTab:CreateToggle({
   Name = "Abduct Target (خطف وتكتيف)",
   CurrentValue = false,
   Callback = function(Value)
      Abducting = Value
      local victim = game.Players:FindFirstChild(SelectedTarget)
      local me = game.Players.LocalPlayer.Character
      if victim and victim.Character and me then
          spawn(function()
              while Abducting do
                  victim.Character.HumanoidRootPart.CFrame = me.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                  task.wait()
              end
          end)
      end
   end,
})

Rayfield:Notify({Title = "ZENO READY", Content = "Master Script Loaded!", Duration = 5})
