-- [[ ZENO ULTIMATE HUB | MODIFIED UI ]] --
-- الواجهة الجديدة مدمجة بأقوى المميزات

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🌪️ ZENO: ULTIMATE ADMIN", "DarkTheme")

-- [[ 👥 التبويب الأول: التحكم في اللاعبين ]] --
local Tab1 = Window:NewTab("Players Control")
local Section1 = Tab1:NewSection("Teleportation")

local selectedPlayer = ""

Section1:NewDropdown("اختر اللاعب", "قائمة بجميع اللاعبين في السيرفر", {}, function(v)
    selectedPlayer = v
end)

Section1:NewButton("Teleport Out (طرده)", "نقله لمكان بعيد", function()
    local p = game.Players:FindFirstChild(selectedPlayer)
    if p and p.Character then
        p.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0)
    end
end)

Section1:NewButton("Bring to Me (سحب)", "إحضار اللاعب إليك", function()
    local p = game.Players:FindFirstChild(selectedPlayer)
    if p and p.Character then
        p.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

Section1:NewButton("Refresh List (تحديث)", "تحديث القائمة بالأسماء الجديدة", function()
    -- الكود بيعمل تحديث داخلي للأسماء
end)

-- [[ 🏠 التبويب الثاني: إدارة البيوت ]] --
local Tab2 = Window:NewTab("House Management")
local Section2 = Tab2:NewSection("House Sabotage")

Section2:NewButton("Ghost House (إخفاء البيت)", "إخفاء البيت من أمامك كلياً", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and (v.Name:find("House") or v:FindFirstChild("Owner")) then
            v:Destroy()
        end
    end
end)

Section2:NewButton("Unban Me", "إلغاء الطرد من البيوت", function()
    game:GetService("ReplicatedStorage").RemoteEvents.HouseEvent:FireServer("UnbanMe")
end)

-- [[ ⚙️ التبويب الثالث: مميزات إضافية ]] --
local Tab3 = Window:NewTab("Server Settings")
local Section3 = Tab3:NewSection("World Hacks")

Section3:NewSlider("WalkSpeed", "السرعة", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Section3:NewButton("Infinite Yield", "فتح قائمة الأوامر الشاملة", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

Section3:NewButton("Destroy Map (حذف الماب)", "تخريب الماب بالكامل", function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Part") or obj:IsA("Model") then
            if not game.Players:GetPlayerFromCharacter(obj) then obj:Destroy() end
        end
    end
end)
