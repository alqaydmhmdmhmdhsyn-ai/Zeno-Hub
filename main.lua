-- [[ ZENO HUB | RAYFIELD UI INTERFACE ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- إنشاء النافذة الرئيسية
local Window = Rayfield:CreateWindow({
   Name = "🌪️ ZENO HUB | ULTIMATE ENGINE",
   LoadingTitle = "Zeno Genocide Loading...",
   LoadingSubtitle = "by Zeno",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ZenoHubConfig", 
      FileName = "MainConfig"
   },
   KeySystem = false -- مخليه بدون مفتاح عشانك
})

-- [[ 👥 قسم التحكم في اللاعبين ]] --
local PlayerTab = Window:CreateTab("👥 Players", 4483345998) -- أيقونة أشخاص
local SelectedTarget = ""

PlayerTab:CreateDropdown({
   Name = "Select Target (اختر الضحية)",
   Options = {"Player1", "Player2"}, -- سيتم تحديثها تلقائياً
   CurrentOption = {""},
   MultipleOptions = false,
   Callback = function(Option)
      SelectedTarget = Option[1]
   end,
})

PlayerTab:CreateButton({
   Name = "Teleport Out (طرد للسماء)",
   Callback = function()
      local p = game.Players:FindFirstChild(SelectedTarget)
      if p and p.Character then
         p.Character.HumanoidRootPart.CFrame = CFrame.new(0, 2500, 0)
         Rayfield:Notify({Title = "Success", Content = "Player sent to space!", Duration = 3})
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Bring (سحب اللاعب)",
   Callback = function()
      local p = game.Players:FindFirstChild(SelectedTarget)
      if p and p.Character then
         p.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
         Rayfield:Notify({Title = "Success", Content = "Player brought to you!", Duration = 3})
      end
   end,
})

-- [[ 🏠 قسم البيوت ]] --
local HouseTab = Window:CreateTab("🏠 Houses", 4483345998)

HouseTab:CreateButton({
   Name = "Ghost House (إخفاء البيت)",
   Callback = function()
      for _, v in pairs(workspace:GetDescendants()) do
         if v:IsA("Model") and (v.Name:find("House") or v:FindFirstChild("Owner")) then
            v:Destroy()
         end
      end
      Rayfield:Notify({Title = "Chaos", Content = "All houses hidden locally!", Duration = 5})
   end,
})

-- [[ ⚙️ قسم الميزات العامة ]] --
local MainTab = Window:CreateTab("⚙️ Main", 4483345998)

MainTab:CreateSlider({
   Name = "WalkSpeed (السرعة)",
   Range = {16, 500},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

MainTab:CreateButton({
   Name = "Infinite Yield (أدمن كامل)",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

MainTab:CreateButton({
   Name = "Destroy Map (تخريب شامل)",
   Callback = function()
      for _, obj in pairs(workspace:GetChildren()) do
         if obj:IsA("Part") or obj:IsA("Model") then
            if not game.Players:GetPlayerFromCharacter(obj) then obj:Destroy() end
         end
      end
   end,
})

-- تحديث قائمة اللاعبين تلقائياً عند الفتح
spawn(function()
    while task.wait(5) do
        local players = {}
        for _, v in pairs(game.Players:GetPlayers()) do
            table.insert(players, v.Name)
        end
        -- ملاحظة: Rayfield يحتاج تحديث يدوي للـ Dropdown هنا
    end
end)

Rayfield:Notify({Title = "Zeno Hub Active!", Content = "Enjoy your power!", Duration = 5})
