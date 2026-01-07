-- [[ ZENO GENOCIDE FINAL | INTERNAL BYPASS SYSTEM ]] --
-- النسخة النهائية الشاملة (تخريب + أدمن + سرقة + طيران)

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TabContainer = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Title = Instance.new("TextLabel")

-- إعداد النظام الأساسي
ScreenGui.Parent = game:GetService("CoreGui")
MainFrame.Name = "ZenoUltimate"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
Title.Text = "🌪️ ZENO GENOCIDE V20"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

TabContainer.Parent = MainFrame
TabContainer.Size = UDim2.new(1, -10, 1, -50)
TabContainer.Position = UDim2.new(0, 5, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.CanvasSize = UDim2.new(0, 0, 2, 0) -- للسكرول
TabContainer.ScrollBarThickness = 4

UIListLayout.Parent = TabContainer
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [[ وظيفة صنع الأزرار بسرعة ]] --
local function CreateButton(txt, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = TabContainer
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = color
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(callback)
    
    -- تأثير زوايا مستديرة
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
end

-- [[ 🧨 قسم التخريب والدمار ]] --
CreateButton("Delete Map (تخريب الماب)", Color3.fromRGB(150, 0, 0), function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(game.Players.LocalPlayer.Character) then
            v:Destroy()
        end
    end
end)

CreateButton("Gravity 0 (انعدام الجاذبية)", Color3.fromRGB(100, 0, 0), function()
    workspace.Gravity = 0
end)

CreateButton("Lag Server (قنبلة اللاج)", Color3.fromRGB(80, 0, 0), function()
    task.spawn(function() while task.wait(0.1) do for i=1,100 do Instance.new("RemoteEvent", game.ReplicatedStorage).Name = "Zeno" end end end)
end)

-- [[ 👤 قسم الأدمن والهكر ]] --
CreateButton("Speed 500 (سرعة صاروخ)", Color3.fromRGB(0, 100, 0), function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 500
end)

CreateButton("Infinite Yield (أدمن CMD)", Color3.fromRGB(0, 80, 150), function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

CreateButton("Fly GUI (قائمة الطيران)", Color3.fromRGB(0, 120, 120), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end)

-- [[ 🏙️ قسم المابات (Brookhaven/Metro) ]] --
CreateButton("Unlock VIP (فتح الجيم باس)", Color3.fromRGB(150, 150, 0), function()
    local mt = getrawmetatable(game); setreadonly(mt, false)
    local old = mt.__index
    mt.__index = newcclosure(function(t, k)
        if k == "UserOwnsGamePassAsync" or k == "PlayerOwnsAsset" then return true end
        return old(t, k)
    end)
end)

CreateButton("Noclip (اختراق الجدران)", Color3.fromRGB(100, 100, 100), function()
    _G.noclip = true
    game:GetService("RunService").Stepped:Connect(function()
        if _G.noclip then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

CreateButton("Nightmare Sky (سماء حمراء)", Color3.fromRGB(50, 0, 0), function()
    game.Lighting.ClockTime = 0
    game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 0, 0)
end)

-- [[ 🛑 زر الإغلاق ]] --
CreateButton("CLOSE HUB (إغلاق)", Color3.fromRGB(50, 50, 50), function()
    ScreenGui:Destroy()
end)

-- [[ حماية ضد الطرد ]] --
pcall(function()
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end
        return old(self, ...)
    end)
end)

print("ZENO GENOCIDE V20 LOADED SUCCESSFULLY")
