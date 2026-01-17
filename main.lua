-- Shindo Life Legend - Ultimate Edition 2026 | أسطوري Mobile/PC
-- Modern Fluent-Style UI (No Key)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()  -- أو أي رابط محدث لـ Fluent لو اتغير

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "SHINDO LEGEND • الأسطورة 2026",
    SubTitle = "by القائد محمد | Mobile & PC Optimized",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,  -- خلفية زجاجية أسطورية
    Theme = "Dark",  -- أو "Aqua" / "Amethyst" لو عايز تغير
    MinimizeKey = Enum.KeyCode.RightControl
})

-- إنشاء الـ Tabs الأسطورية
local FarmTab = Window:AddTab({ Title = "تطوير تلقائي", Icon = "rbxassetid://7733715400" })  -- أيقونة قوية
local SpinTab = Window:AddTab({ Title = "اللفات", Icon = "rbxassetid://7734053495" })
local PlayerTab = Window:AddTab({ Title = "مميزات اللاعب", Icon = "rbxassetid://7733964714" })
local TeleportTab = Window:AddTab({ Title = "التنقل", Icon = "rbxassetid://7733774602" })
local SettingsTab = Window:AddTab({ Title = "إعدادات", Icon = "rbxassetid://7734053421" })

-- =================== Auto Farm Section ===================
local FarmSection = FarmTab:AddSection("Auto Farm أسطوري")

getgenv().AutoFarm = false
FarmSection:AddToggle("قتل + جمع XP تلقائي", {
    Default = false,
    Callback = function(v)
        getgenv().AutoFarm = v
        task.spawn(function()
            while getgenv().AutoFarm do
                task.wait(0.1)
                pcall(function()
                    local plr = game.Players.LocalPlayer
                    for _, npc in pairs(workspace.NPCs:GetChildren()) do
                        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                            plr.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)
                            game:GetService("ReplicatedStorage").r:FireServer("attack", npc)  -- غير الـ remote لو لازم
                        end
                    end
                end)
            end
        end)
    end
})

FarmSection:AddToggle("Auto Spin Bloodline/Elements", {
    Default = false,
    Callback = function(v)
        getgenv().AutoSpin = v
        task.spawn(function()
            while getgenv().AutoSpin do
                task.wait(0.35)  -- سرعة آمنة
                pcall(function()
                    game:GetService("ReplicatedStorage").Spin:FireServer("Bloodline")
                    -- أضف: game.ReplicatedStorage.Spin:FireServer("Element") لو عايز الاتنين
                end)
            end
        end)
    end
})

-- =================== Player Mods ===================
local PlayerSection = PlayerTab:AddSection("قوة خارقة")

PlayerSection:AddSlider("سرعة المشي", {
    Min = 16,
    Max = 500,
    Default = 80,
    Rounding = 1,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

PlayerSection:AddSlider("قوة القفز", {
    Min = 50,
    Max = 300,
    Default = 100,
    Rounding = 1,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end
})

PlayerSection:AddToggle("No Clip (تمرر من الحيطان)", {
    Default = false,
    Callback = function(v)
        getgenv().NoClip = v
    end
})

game:GetService("RunService").Stepped:Connect(function()
    if getgenv().NoClip and game.Players.LocalPlayer.Character then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

PlayerSection:AddToggle("Godmode (لا تموت)", {
    Default = false,
    Callback = function(v)
        getgenv().God = v
        if v then
            task.spawn(function()
                while getgenv().God do
                    task.wait()
                    pcall(function()
                        game.Players.LocalPlayer.Character.Humanoid.Health = 100
                    end)
                end
            end)
        end
    end
})

-- =================== Anti Kick & Toggle ===================
SettingsTab:AddSection("الحماية الأسطورية")

SettingsTab:AddButton({
    Title = "تفعيل Anti-Kick",
    Callback = function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local old = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            if getnamecallmethod() == "Kick" then return end
            return old(self, ...)
        end)
        Fluent:Notify({Title="Anti-Kick",Content="تم التفعيل بنجاح!"})
    end
})

-- إضافة Save System (اختياري لكن أسطوري)
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:BuildInterfaceSection(SettingsTab)
InterfaceManager:BuildInterfaceSection(SettingsTab)

Fluent:SelectTab(1)  -- يفتح على أول تاب
