-- [[ ZENO HUB - Metro Life City RP | Rayfield FIXED 2026 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌪️ ZENO: Metro Life Admin",
   LoadingTitle = "ZENO Admin Loading...",
   LoadingSubtitle = "by القائد محمد",
   ConfigurationSaving = { Enabled = false }, -- disable saving لو فيه مشكلة
})

Rayfield:Notify({
   Title = "جاري التحميل",
   Content = "انتظر ثواني... اضغط تحديث القائمة لو ما ظهرش حاجة",
   Duration = 8,
   Image = 4483362458,
})

-- Tab اللاعبين
local PlayersTab = Window:CreateTab("لاعبين", 4483362458)
local PlayersSection = PlayersTab:CreateSection("التحكم في اللاعبين")

local SelectedPlayer = ""
local PlayerDropdown

-- دالة تحديث القائمة
local function refreshPlayers()
   local names = {}
   for _, plr in pairs(game.Players:GetPlayers()) do
      table.insert(names, plr.Name)
   end
   if PlayerDropdown then
      PlayerDropdown:Refresh(names, true)
   end
end

PlayerDropdown = PlayersSection:CreateDropdown({
   Name = "اختر لاعب",
   Options = {},
   CurrentOption = "",
   Callback = function(v)
      SelectedPlayer = v
   end,
})

-- زر التحديث + auto refresh بعد 2 ثواني
PlayersSection:CreateButton({
   Name = "تحديث قائمة اللاعبين (مهم!)",
   Callback = refreshPlayers,
})

task.delay(2, refreshPlayers) -- auto refresh أول ما يفتح

-- باقي الأزرار (هتظهر بعد الـ refresh)
PlayersSection:CreateButton({
   Name = "جيبه عندي (Bring)",
   Callback = function()
      local target = game.Players:FindFirstChild(SelectedPlayer)
      local me = game.Players.LocalPlayer
      if target and target.Character and me.Character then
         target.Character:MoveTo(me.Character.HumanoidRootPart.Position + Vector3.new(0,0,-4))
      end
   end,
})

PlayersSection:CreateButton({
   Name = "طرده للسما (TP Out)",
   Callback = function()
      local target = game.Players:FindFirstChild(SelectedPlayer)
      if target and target.Character then
         target.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1500, 0)
      end
   end,
})

PlayersSection:CreateButton({
   Name = "قتله (Kill)",
   Callback = function()
      local target = game.Players:FindFirstChild(SelectedPlayer)
      if target and target.Character and target.Character:FindFirstChild("Humanoid") then
         target.Character.Humanoid.Health = 0
      end
   end,
})

-- باقي الـ Tabs (بيوت، إكسترا) زي ما كانت
local HouseTab = Window:CreateTab("بيوت وسيارات", 4483362458)
HouseTab:CreateSection("تدمير")
HouseTab:CreateButton({
   Name = "تدمير كل البيوت",
   Callback = function()
      for _, obj in workspace:GetDescendants() do
         if obj:IsA("Model") and (string.find(string.lower(obj.Name), "house") or obj:FindFirstChild("Owner")) then
            obj:Destroy()
         end
      end
   end,
})

-- إلخ...

Rayfield:Notify({
   Title = "تم التحميل!",
   Content = "اضغط 'تحديث قائمة اللاعبين' لو الأزرار مش ظاهرة",
   Duration = 6,
})

print("ZENO Fixed - Press refresh button!")
