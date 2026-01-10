-- [[ ZENO HUB: FINAL REPAIR ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🌪️ ZENO: PLAYER CONTROL", "BloodTheme")

-- [[ 👥 قسم التحكم في اللاعبين ]] --
local Tab1 = Window:NewTab("Players Control")
local Section1 = Tab1:NewSection("Teleport & Move")

local selectedPlayer = ""

Section1:NewDropdown("Select Player", "اختر الضحية", {}, function(v)
    selectedPlayer = v
end)

Section1:NewButton("Teleport Out (طرده)", "نقله للسماء", function()
    local p = game.Players:FindFirstChild(selectedPlayer)
    if p and p.Character then
        p.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0)
    end
end)

Section1:NewButton("Bring to Me (هاته عندي)", "سحب اللاعب", function()
    local p = game.Players:FindFirstChild(selectedPlayer)
    if p and p.Character then
        p.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

Section1:NewButton("Refresh List (تحديث القائمة)", "اضغط هنا لو القائمة اختفت", function()
    -- تحديث يدوي للأسماء
    pcall(function()
        local names = {}
        for _,v in pairs(game.Players:GetPlayers()) do table.insert(names, v.Name) end
        -- تحديث الدروب داون
    end)
end)

-- [[ 🏠 قسم البيوت - إصلاح القائمة الجانبية ]] --
local Tab2 = Window:NewTab("House Management")
local Section2 = Tab2:NewSection("Destroy & Reset")

Section2:NewButton("Ghost House (إخفاء البيت)", "بيختفي من قدامك", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and (v.Name:find("House") or v:FindFirstChild("Owner")) then
            v:Destroy()
        end
    end
end)

Section2:NewButton("Kill All (قتل الجميع)", "تجربة القوة", function()
    for _,v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            v.Character.Humanoid.Health = 0
        end
    end
end)

-- [[ 🛠️ أوامر إضافية ]] --
local Tab3 = Window:NewTab("Extra")
local Section3 = Tab3:NewSection("Server Fun")

Section3:NewButton("Infinite Yield", "فتح الأدمن الشامل", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
