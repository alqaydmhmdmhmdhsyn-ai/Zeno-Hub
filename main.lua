-- [[ ZENO HUB V2 | FIX ALL ERRORS ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌪️ ZENO HUB | FIXED EDITION",
   LoadingTitle = "Bypassing Anticheat...",
   ConfigurationSaving = { Enabled = false }
})

-- [[ 👤 قسم السرعة المضمون - WalkSpeed Bypass ]] --
local PlayerTab = Window:CreateTab("👤 Player", 4483345998)

PlayerTab:CreateSlider({
   Name = "Speed (سرعة ثابتة)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      -- طريقة Bypass عشان السرعة ما ترجعش تاني
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
          char.Humanoid.WalkSpeed = Value
          -- كود يمنع اللعبة من تصفير السرعة
          char.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
              char.Humanoid.WalkSpeed = Value
          end)
      end
   end,
})

-- [[ 👥 قسم اللاعبين المصلح - Working Dropdown ]] --
local TargetTab = Window:CreateTab("👥 Targets", 4483345998)
local SelectedPlayer = ""

local function GetNames()
    local t = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then table.insert(t, v.Name) end
    end
    return t
end

local Drop = TargetTab:CreateDropdown({
   Name = "Select Player",
   Options = GetNames(),
   CurrentOption = {""},
   Callback = function(Option) SelectedPlayer = Option[1] end,
})

TargetTab:CreateButton({
   Name = "Refresh Names (تحديث)",
   Callback = function() Drop:Refresh(GetNames()) end,
})

TargetTab:CreateButton({
   Name = "Bring (سحب حقيقي)",
   Callback = function()
      local p = game.Players:FindFirstChild(SelectedPlayer)
      if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
      end
   end,
})

-- [[ 🚀 ميزة السكرت - Instant Steal ]] --
local StealTab = Window:CreateTab("🚀 Instant Steal", 4483345998)

StealTab:CreateButton({
   Name = "Get Secret & Return",
   Callback = function()
      local lp = game.Players.LocalPlayer.Character
      if lp and lp:FindFirstChild("HumanoidRootPart") then
          local old = lp.HumanoidRootPart.CFrame
          -- جرب تغير الإحداثيات دي لمكان السكرت في مابك
          lp.HumanoidRootPart.CFrame = CFrame.new(0, 150, -2000) 
          task.wait(0.2) -- زودت الوقت شوية عشان السيرفر يلحق يقرأ اللمس
          
          for _, v in pairs(workspace:GetDescendants()) do
              if v:IsA("TouchTransmitter") then -- بيلبس أي حاجة قابلة للمس
                  firetouchinterest(lp.HumanoidRootPart, v.Parent, 0)
                  firetouchinterest(lp.HumanoidRootPart, v.Parent, 1)
              end
          end
          task.wait(0.1)
          lp.HumanoidRootPart.CFrame = old
      end
   end,
})

-- [[ 🛠️ حماية ضد الطرد - Anti Kick ]] --
local SettingsTab = Window:CreateTab("🛠️ Fixes", 4483345998)
SettingsTab:CreateButton({
   Name = "Fix Lag / Anti-Kick",
   Callback = function()
       local mt = getrawmetatable(game); setreadonly(mt, false)
       local old = mt.__namecall
       mt.__namecall = newcclosure(function(self, ...)
           local method = getnamecallmethod()
           if method == "Kick" then return nil end
           return old(self, ...)
       end)
   end,
})
