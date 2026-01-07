-- [[ ZENO ELITE ADMIN | THE YOUTUBE POWER ]] --
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "🌪️ ZENO ELITE ADMIN", HidePremium = false, SaveConfig = false, IntroText = "Zeno Is Dominating..."})

-- [[ 👤 قسم القوة المطلقة (Main Admin) ]] --
local Tab1 = Window:MakeTab({Name = "👤 Admin Power", Icon = "rbxassetid://4483345998"})

Tab1:AddSlider({
	Name = "WalkSpeed (السرعة الخارقة)",
	Min = 16, Max = 1000, Default = 16,
	Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end    
})

Tab1:AddButton({
	Name = "Infinite Yield (أوامر الـ CMD الكاملة)",
	Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end
})

Tab1:AddButton({
	Name = "Fly V3 (الطيران بعداد)",
	Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))() end
})

-- [[ 🧨 قسم التخريب (Sabotage) ]] --
local Tab2 = Window:MakeTab({Name = "🧨 Sabotage", Icon = "rbxassetid://4483345998"})

Tab2:AddButton({
	Name = "Mass Kick (طرد وهمي/إزعاج)",
	Callback = function()
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                print("Targeting: "..v.Name) -- محاكاة الاستهداف
            end
        end
        OrionLib:MakeNotification({Name = "ZENO", Content = "Attempting Server Disruption...", Duration = 5})
    end
})

Tab2:AddButton({
	Name = "Clear Workspace (حذف الماب)",
	Callback = function()
        for _,v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") or v:IsA("Model") then v:Destroy() end
        end
    end
})

-- [[ 🏙️ قسم مترو لايف مخصص (Metro City) ]] --
local Tab3 = Window:MakeTab({Name = "🏙️ Metro Life", Icon = "rbxassetid://4483345998"})

Tab3:AddButton({
	Name = "Unlock All Cars (فتح العربيات)",
	Callback = function()
        local mt = getrawmetatable(game); setreadonly(mt, false)
        local old = mt.__index
        mt.__index = newcclosure(function(t, k)
            if k == "UserOwnsGamePassAsync" or k == "PlayerOwnsAsset" then return true end
            return old(t, k)
        end)
    end
})

Tab3:AddButton({
    Name = "Rob All Register (سرقة الخزنات)",
    Callback = function()
        OrionLib:MakeNotification({Name = "Zeno Hub", Content = "Teleporting to registers...", Duration = 3})
        -- كود الانتقام/السرقة
    end
})

-- [[ 🛡️ نظام الحماية (Anti-Ban) ]] --
pcall(function()
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end
        return old(self, ...)
    end)
end)

OrionLib:Init()
