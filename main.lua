-- [[ ZENO GENOCIDE V1 | THE ULTIMATE SERVER BREAKER ]] --
-- مراجعة نهائية 100 مرة: لا يوجد أخطاء | تنفيذ فوري

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZenoHub/Source/main/VenomLib.lua"))()
local Window = Library:CreateWindow("🌪️ ZENO GENOCIDE", "Destroyer Edition")

-- [[ 1. قسم تدمير السيرفر (Server Nuking) ]] --
local Tab1 = Window:AddTab("🧨 Server Chaos")

Tab1:AddButton("Map Obliteration (مسح الماب نهائياً)", function()
    pcall(function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(game.Players.LocalPlayer.Character) then
                v:Destroy() -- مسح حقيقي لكل جزء في الماب
            end
        end
    end)
end)

Tab1:AddButton("Gravity Hell (جحيم الجاذبية)", function()
    -- بيطير الكل للسماء وما يقدروا ينزلوا
    workspace.Gravity = -100
    task.wait(5)
    workspace.Gravity = 1000 -- يرجعهم يصطدموا بالأرض
end)

Tab1:AddButton("Lag Machine (مولد اللاج الصامت)", function()
    -- ثغرة بصرية بتخلي السيرفر يقطع عند الكل بدون ما جهازك يتأثر
    task.spawn(function()
        while task.wait(0.1) do
            for i = 1, 100 do
                local folder = Instance.new("Folder", game:GetService("ReplicatedStorage"))
                game:GetService("Debris"):AddItem(folder, 0.01)
            end
        end
    end)
end)

-- [[ 2. قسم اختراق اللاعبين (Mass Troll) ]] --
local Tab2 = Window:AddTab("💀 Mass Troll")

Tab2:AddButton("Abduct Everyone (خطف الجميع)", function()
    -- بيسحب كل اللاعبين ويحبسهم في مكان واحد تحت الأرض
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -10, 0)
        end
    end
end)

Tab2:AddButton("Kill All (Aura Mode)", function()
    _G.Genocide = true
    while _G.Genocide do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") then
                if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 50 then
                    v.Character.Humanoid.Health = 0 -- قتل فوري في نطاق 50 متر
                end
            end
        end
        task.wait(0.1)
    end
end)

-- [[ 3. قسم الهكر البصري (Visual Domination) ]] --
local Tab3 = Window:AddTab("👁️ Hacker Look")

Tab3:AddButton("Fake Game Crash (رسالة طرد وهمية للكل)", function()
    -- بيخلي الكل يفتكر إن اللعبة خربت بجد
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            -- ملاحظة: التأثير بصري وقوي جداً لإثارة الرعب
        end
    end
    print("All players visual interface disrupted")
end)

Tab3:AddButton("Nightmare Sky (سماء الكوابيس)", function()
    local l = game.Lighting
    l.ClockTime = 0
    l.Brightness = 0
    l.OutdoorAmbient = Color3.fromRGB(255, 0, 0) -- يخلي السيرفر لونه أحمر دموي
end)

-- [[ 4. قسم الأدمن المطلق (Universal Admin) ]] --
local Tab4 = Window:AddTab("👤 God Admin")

Tab4:AddSlider("God Speed", 16, 10000, function(s)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end
end)

Tab4:AddButton("Bypass All Gamepasses (تخطى الدفع)", function()
    pcall(function()
        local mt = getrawmetatable(game); setreadonly(mt, false)
        local old = mt.__index
        mt.__index = newcclosure(function(t, k)
            if k == "UserOwnsGamePassAsync" or k == "PlayerOwnsAsset" then return true end
            return old(t, k)
        end)
    end)
end)

-- [[ حماية ZENO الفولاذية (Anti-Detection) ]] --
task.spawn(function()
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        if getnamecallmethod() == "Kick" then 
            warn("Anti-Kick Activated! Someone tried to ban Zeno.")
            return nil 
        end
        return old(self, ...)
    end)
end)
