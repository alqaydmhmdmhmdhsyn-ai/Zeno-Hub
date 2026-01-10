-- [[ ZENO HUB - Metro Life City RP | Rayfield Edition 2026 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌪️ ZENO: Metro Life Admin",
   LoadingTitle = "ZENO Admin Panel",
   LoadingSubtitle = "by القائد محمد",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ZenoMetroConfig",
      FileName = "Settings"
   },
   Discord = { -- اختياري
      Enabled = false,
      Invite = "", 
      RememberJoins = true 
   },
   KeySystem = false, -- لو عايز key system شغله true
})

-- Tab اللاعبين
local PlayersTab = Window:CreateTab("لاعبين", 4483362458) -- أيقونة ID اختياري
local PlayersSection = PlayersTab:CreateSection("التحكم في اللاعبين")

local SelectedPlayer = ""
local PlayerDropdown = PlayersSection:CreateDropdown({
   Name = "اختر لاعب",
   Options = {},
   CurrentOption = "",
   Callback = function(v)
      SelectedPlayer = v
   end,
})

-- زر تحديث القائمة (مهم جداً عشان يشتغل)
PlayersSection:CreateButton({
   Name = "تحديث قائمة اللاعبين",
   Callback = function()
      local names = {}
      for _, plr in pairs(game.Players:GetPlayers()) do
         table.insert(names, plr.Name)
      end
      PlayerDropdown:Refresh(names, true) -- true عشان يختار أول واحد أوتوماتيك
   end,
})

PlayersSection:CreateButton({
   Name = "جيبه عندي (Bring)",
   Callback = function()
      local target = game.Players:FindFirstChild(SelectedPlayer)
      local me = game.Players.LocalPlayer
      if target and target.Character and me.Character then
         target.Character.HumanoidRootPart.CFrame = me.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
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

-- Tab البيوت والسيارات
local HouseTab = Window:CreateTab("بيوت وسيارات", 4483362458)
local HouseSection = HouseTab:CreateSection("تدمير")

HouseSection:CreateButton({
   Name = "تدمير/إخفاء كل البيوت",
   Callback = function()
      for _, obj in pairs(workspace:GetDescendants()) do
         if obj:IsA("Model") and (obj.Name:lower():find("house") or obj:FindFirstChild("Owner") or obj.Name:find("Plot")) then
            obj:Destroy()
         end
      end
   end,
})

HouseSection:CreateButton({
   Name = "تدمير كل السيارات",
   Callback = function()
      for _, v in pairs(workspace.Vehicles:GetChildren()) do -- غالباً Vehicles folder
         if v:IsA("Model") then v:Destroy() end
      end
   end,
})

-- Extra
local ExtraTab = Window:CreateTab("إكسترا")
ExtraTab:CreateSection("أدوات")
ExtraTab:CreateButton({
   Name = "فتح Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

Rayfield:Notify({
   Title = "ZENO Loaded",
   Content = "استخدم الـ Minimize من الـ UI نفسه أو اضغط Right Ctrl للإخفاء",
   Duration = 6.5,
})

print("ZENO Metro Life Panel Loaded with Rayfield!")
