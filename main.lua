-- [[ ZENO HUB V2 - PREMIUM VERSION ]] --
-- الواجهة دي احترافية وتدعم السحب والإخفاء (Mobile Friendly)

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton") -- الزر العائم
local Title = Instance.new("TextLabel")
local Content = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- إعدادات الشاشة والزر العائم
ScreenGui.Parent = game.CoreGui
ToggleBtn.Name = "ZenoToggle"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ToggleBtn.Position = UDim2.new(0, 10, 0, 150)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Text = "ZENO"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Draggable = true -- تقدر تحركه في أي مكان

-- إعدادات القائمة الرئيسية
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Visible = false -- تبدأ مخفية

-- وظيفة الفتح والقفل بالزر العائم
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- إضافة العنوان والمميزات
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ZENO HUB - SHINDO LIFE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

Content.Parent = MainFrame
Content.Position = UDim2.new(0, 0, 0, 45)
Content.Size = UDim2.new(1, 0, 1, -45)
UIListLayout.Parent = Content

-- [ وظيفة إضافة الأزرار ]
local function AddButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Content
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(callback)
end

-- [[ المميزات الشغالة فعلياً ]]

AddButton("تفعيل الضرب التلقائي (Fast Log)", function()
    _G.LogFarm = true
    spawn(function()
        while _G.LogFarm do
            task.wait(0.1)
            local args = {[1] = "Combat", [2] = "Log"}
            game:GetService("Players").LocalPlayer.startevent:FireServer(unpack(args))
        end
    end)
end)

AddButton("لف تلقائي (Auto Spin)", function()
    -- الكود ده بينادي على سيرفر اللعبة عشان يلف فعلياً
    game:GetService("Players").LocalPlayer.startevent:FireServer("Spin", "Bloodline")
end)

AddButton("تشاكرا لا نهائية", function()
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            game.Players.LocalPlayer.Character.Statz.Chakra.Current.Value = game.Players.LocalPlayer.Character.Statz.Chakra.Max.Value
        end)
    end)
end)

AddButton("إيقاف كل الميزات", function()
    _G.LogFarm = false
    print("Zeno Hub: تم الإيقاف")
end)
