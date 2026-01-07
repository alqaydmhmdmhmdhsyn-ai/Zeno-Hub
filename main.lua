-- [[ ZENO HUB V17 | METRO LIFE CITY RP - ULTIMATE ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌪️ ZENO HUB V17: METRO CITY",
   LoadingTitle = "🏙️ جاري تفعيل صلاحيات عمدة المدينة...",
   LoadingSubtitle = "By Zeno - Metro Life Legend",
   ConfigurationSaving = { Enabled = false }
})

-- [[ 👤 قسم الأدمن والحركة (God Movement) ]] --
local AdminTab = Window:CreateTab("👤 Admin Powers", 4483362458)

AdminTab:CreateSlider({
   Name = "Speed (السرعة)",
   Range = {16, 500},
   Increment = 5,
   CurrentValue = 16,
   Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end,
})

AdminTab:CreateSlider({
   Name = "Jump (القفزة)",
   Range = {50, 500},
   Increment = 5,
   CurrentValue = 50,
   Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end,
})

AdminTab:CreateButton({
   Name = "Fly (الطيران الحر ✈️)",
   Callback = function() 
       loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))() 
   end,
})

-- [[ 🔓 قسم الجيم باس والـ VIP (Unlocker) ]] --
local VipTab = Window:CreateTab("💎 VIP Unlocker", 4483362458)

VipTab:CreateButton({
   Name = "Unlock All Cars (فتح سيارات الجيم باس)",
   Info = "بيفتح لك قائمة العربيات الـ VIP عشان تركبها مجاناً",
   Callback = function()
       pcall(function()
           -- ثغرة محاكاة امتلاك الجيم باس في مترو لايف
           local meta = getrawmetatable(game)
           setreadonly(meta, false)
           local old = meta.__index
           meta.__index = newcclosure(function(t, k)
               if k == "UserOwnsGamePassAsync" or k == "PlayerOwnsAsset" then return true end
               return old(t, k)
           end)
           Rayfield:Notify({Title = "ZENO VIP", Content = "Cars & Items Unlocked! 🏎️", Duration = 5})
       end)
   end,
})

-- [[ 🏠 قسم السيطرة على المنازل (House Admin) ]] --
local HouseTab = Window:CreateTab("🏠 House Admin", 4483362458)

HouseTab:CreateButton({
   Name = "Kick All from My House (طرد الجميع)",
   Callback = function()
       pcall(function() 
           game:GetService("ReplicatedStorage").RemoteEvents.HouseEvent:FireServer("KickAll") 
           Rayfield:Notify({Title = "ZENO HUB", Content = "Everyone has been kicked! 🧹", Duration = 3})
       end)
   end,
})

HouseTab:CreateButton({
   Name = "Enter Locked Houses (دخول البيوت المقفولة)",
   Info = "بيفعل الـ Noclip عشان تدخل أي بيت مقفول",
   Callback = function()
       _G.Noclip = not _G.Noclip
       game:GetService("RunService").Stepped:Connect(function()
           if _G.Noclip then
               for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                   if v:IsA("BasePart") then v.CanCollide = false end
               end
           end
       end)
   end,
})

-- [[ 🛠️ قسم أدوات الأدمن (Admin Tools) ]] --
local ToolTab = Window:CreateTab("🛠️ Admin Tools", 4483362458)

ToolTab:CreateButton({
   Name = "B-Tools (أدوات الحذف 🔨)",
   Callback = function()
       local hammer = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
       hammer.BinType = 4
       local grab = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
       grab.BinType = 2
   end,
})

ToolTab:CreateButton({
   Name = "Infinite Money (Visual 💰)",
   Callback = function()
       game.Players.LocalPlayer.leaderstats.Money.Value = 999999999
   end,
})

-- [[ 🛡️ حماية اللاعب (Anti-Kick) ]] --
task.spawn(function()
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end
        return old(self, ...)
    end)
end)
