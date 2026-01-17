-- SHINDO LEGEND ULTRA Mobile Edition | by القائد محمد | Rayfield UI (Mobile Friendly 2026)
-- استخدم Rayfield لأنها أفضل scaling وtouch على الموبايل

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()  -- رابط رسمي 2026 (لو اتغير ابحث عن "Rayfield Sirius")

local Window = Rayfield:CreateWindow({
   Name = "SHINDO LEGEND • الأسطورة 2026 Mobile",
   LoadingTitle = "جاري التحميل يا أسطورة",
   LoadingSubtitle = "by القائد محمد",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ShindoMobile",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false, -- بدون key
   ShowText = "Shindo Mobile",
   Theme = "Default" -- أو "Dark" لو عايز
})

-- Tabs أسطورية (أكبر وأسهل على الموبايل)
local FarmTab = Window:CreateTab("تطوير تلقائي", "rewind") -- أيقونة Lucide
local SpinTab = Window:CreateTab("اللفات", "refresh-ccw")
local PlayerTab = Window:CreateTab("مميزات اللاعب", "user")
local TeleTab = Window:CreateTab("Teleports", "navigation")
local SettingsTab = Window:CreateTab("إعدادات", "settings")

-- مثال: Auto Farm (نفس المميزات السابقة بس بـ Rayfield syntax)
local AutoFarmToggle = FarmTab:CreateToggle({
   Name = "Auto Farm NPCs + XP",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      getgenv().AutoFarm = Value
      Rayfield:Notify({
         Title = "Auto Farm",
         Content = Value and "مفعل يا وحش!" or "معطل",
         Duration = 3
      })
   end,
})

-- أضف الباقي زي: Auto Spin, Fly, God Mode, ESP, Teleports, Ryo Boost, Infinite Spins, Auto Stats, Auto Rank, etc.
-- مثال سريع لـ Fly:
PlayerTab:CreateToggle({
   Name = "تفعيل الطيران (Fly)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      getgenv().Fly = Value
      -- كود الطيران السابق هنا
   end,
})

PlayerTab:CreateSlider({
   Name = "سرعة الطيران",
   Range = {50, 500},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = 100,
   Flag = "FlySpeed",
   Callback = function(Value)
      getgenv().FlySpeed = Value
   end,
})

-- Anti-Kick في Settings
SettingsTab:CreateButton({
   Name = "تفعيل Anti-Kick",
   Callback = function()
      -- كود Anti-Kick السابق
      Rayfield:Notify({Title = "Anti-Kick", Content = "مفعل!"})
   end,
})

Rayfield:LoadConfiguration() -- يحفظ الإعدادات تلقائي

print("SHINDO LEGEND Mobile Loaded with Rayfield! 🔥 Right Ctrl أو زر الـ ShowText للتحكم")
