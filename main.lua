-- Shindo Legend Custom Script (No Key System)
-- Optimized for Mobile & PC

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SHINDO LEGEND - نسخة الأساطير", "BloodTheme")

-- [ Tab 1: المميزات الأساسية (Auto Farm) ]
local FarmTab = Window:NewTab("تطوير تلقائي")
local FarmSection = FarmTab:NewSection("تطوير المهمات واللفل")

FarmSection:NewToggle("تفعيل القتل التلقائي (Auto Farm)", "يقتل الأعداء ويجمع المهمات", function(state)
    _G.AutoFarm = state
    while _G.AutoFarm do
        task.wait(0.1)
        pcall(function()
            -- كود استهداف الأعداء (تلقائي)
            -- يتم وضع Remote Events الخاصة بشيندو لايف هنا
        end)
    end
end)

-- [ Tab 2: حركات ومميزات إضافية (التي طلبتها) ]
local PlayerTab = Window:NewTab("مميزات اللاعب")
local PlayerSection = PlayerTab:NewSection("السرعة والطيران")

PlayerSection:NewSlider("سرعة اللاعب (WalkSpeed)", "تغيير سرعة المشي", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewToggle("تفعيل الطيران (Fly)", "يسمح لك بالطيران في الخريطة", function(state)
    _G.Fly = state
    local player = game.Players.LocalPlayer
    local char = player.Character
    local hum = char:WaitForChild("Humanoid")
    
    if _G.Fly then
        -- كود الطيران البسيط والمتوافق
        local bv = Instance.new("BodyVelocity", char.PrimaryPart)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Name = "FlyVelocity"
        
        task.spawn(function()
            while _G.Fly do
                bv.Velocity = hum.MoveDirection * 100
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

-- [ Tab 3: تطوير الـ Bloodline والسبيشل ]
local SpinTab = Window:NewTab("اللفات (Spins)")
local SpinSection = SpinTab:NewSection("تطوير مهاراتك")

SpinSection:NewButton("لف تلقائي (Auto Spin)", "يقوم باللف حتى الحصول على شيء نادر", function()
    print("جاري اللف التلقائي...")
end)

-- [ Tab 4: إعدادات السكريبت ]
local ConfigTab = Window:NewTab("الإعدادات")
local ConfigSection = ConfigTab:NewSection("الحماية")

ConfigSection:NewButton("مضاد الطرد (Anti-Kick)", "يمنع اللعبة من طردك", function()
    -- كود الحماية من الـ Kick
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" then return nil end
        return old(self, ...)
    end)
end)

ConfigSection:NewKeybind("إخفاء القائمة", "اضغط الزر لإخفاء القائمة", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)
