-- [[ ZENO ENDLESS SOURCE | ANIME FIGHTING SIMULATOR ]] --
-- النسخة الكاملة للميزات اللي في الفيديو

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🌪️ ZENO ENDLESS: ANIME", "DarkTheme")

-- [[ 1. قسم التطوير التلقائي (Auto Farm) ]] --
local Tab1 = Window:NewTab("🔥 Auto Farm")
local Section1 = Tab1:NewSection("Training Skills")

Section1:NewToggle("Auto Strength (قوة)", "تطوير القوة تلقائياً", function(state)
    _G.Strength = state
    while _G.Strength do
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer({"Strength"})
        task.wait(0.1)
    end
end)

Section1:NewToggle("Auto Durability (دفاع)", "تطوير الدفاع تلقائياً", function(state)
    _G.Durability = state
    while _G.Durability do
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer({"Durability"})
        task.wait(0.1)
    end
end)

Section1:NewToggle("Auto Chakra (تشاكرا)", "تطوير التشاكرا تلقائياً", function(state)
    _G.Chakra = state
    while _G.Chakra do
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer({"Chakra"})
        task.wait(0.1)
    end
end)

-- [[ 2. قسم المهام والجوائز (Quests) ]] --
local Tab2 = Window:NewTab("📜 Quests")
local Section2 = Tab2:NewSection("Auto Rewards")

Section2:NewButton("Claim All Chests", "فتح كل الصناديق في الماب", function()
    for _,v in pairs(game:GetService("Workspace").Chests:GetChildren()) do
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
    end
end)

-- [[ 3. قسم الأدمن والسرعة (Movement) ]] --
local Tab3 = Window:NewTab("👤 Player")
local Section3 = Tab3:NewSection("Speed & Fly")

Section3:NewSlider("WalkSpeed", "التحكم بالسرعة", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Section3:NewButton("Infinite Jump", "قفز مستمر", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end)
end)

-- [[ 4. ميزات التخريب (Sabotage) ]] --
local Tab4 = Window:NewTab("🧨 Chaos")
local Section4 = Tab4:NewSection("Server Destory")

Section4:NewButton("Kill Aura (قتل المحيطين)", "يقتل أي حد يقرب منك", function()
    task.spawn(function()
        while task.wait(0.5) do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    local dist = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 20 then v.Character.Humanoid.Health = 0 end
                end
            end
        end
    end)
end)

Section4:NewButton("Destroy Map (مسح الماب)", "تخريب الماب للكل", function()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Part") or v:IsA("Model") then v:Destroy() end
    end
end)
