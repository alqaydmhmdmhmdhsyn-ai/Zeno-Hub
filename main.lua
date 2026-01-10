-- [[ ZENO HUB - Metro Life City RP Edition 2026 ]] --
-- مع Minimize + Draggable + أوامر مخصصة للماب

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🌪️ ZENO: METRO LIFE ADMIN", "BloodTheme")

local isMinimized = false
local toggleButton = nil

local function toggleGUI()
    isMinimized = not isMinimized
    if isMinimized then
        game:GetService("CoreGui"):FindFirstChild("KavoUI", true).Enabled = false
        
        if not toggleButton then
            local sg = Instance.new("ScreenGui", game.CoreGui)
            sg.Name = "ZenoToggleMetro"
            toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(0, 60, 0, 60)
            toggleButton.Position = UDim2.new(0.01, 0, 0.1, 0)
            toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            toggleButton.Text = "ZENO\nMetro"
            toggleButton.TextColor3 = Color3.fromRGB(255, 80, 80)
            toggleButton.Font = Enum.Font.GothamBlack
            toggleButton.TextSize = 16
            toggleButton.Parent = sg
            toggleButton.MouseButton1Click:Connect(toggleGUI)
        end
        toggleButton.Visible = true
    else
        if game:GetService("CoreGui"):FindFirstChild("KavoUI", true) then
            game:GetService("CoreGui"):FindFirstChild("KavoUI", true).Enabled = true
        end
        if toggleButton then toggleButton.Visible = false end
    end
end

-- ================== Players Control ==================
local TabPlayers = Window:NewTab("لاعبين")
local SecPlayers = TabPlayers:NewSection("Teleport & Control")

local selected = ""
local dd = SecPlayers:NewDropdown("اختر لاعب", "Select Victim", {}, function(v) selected = v end)

SecPlayers:NewButton("تحديث القائمة (Refresh)", "اضغط لو اللاعبين اختفوا", function()
    local names = {}
    for _, plr in pairs(game.Players:GetPlayers()) do
        table.insert(names, plr.Name)
    end
    dd:Refresh(names, true)
end)

SecPlayers:NewButton("جيبه عندي (Bring to Me)", "ييجي جنبك", function()
    local target = game.Players:FindFirstChild(selected)
    local me = game.Players.LocalPlayer
    if target and target.Character and me.Character then
        target.Character.HumanoidRootPart.CFrame = me.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
    end
end)

SecPlayers:NewButton("طرده للسما (TP Out)", "يطير فوق", function()
    local target = game.Players:FindFirstChild(selected)
    if target and target.Character then
        target.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1500, 0)
    end
end)

SecPlayers:NewButton("قتله (Kill)", "يموت فورًا", function()
    local target = game.Players:FindFirstChild(selected)
    if target and target.Character and target.Character:FindFirstChild("Humanoid") then
        target.Character.Humanoid.Health = 0
    end
end)

-- ================== House & Cars ==================
local TabHouse = Window:NewTab("بيوت وسيارات")
local SecHouse = TabHouse:NewSection("تدمير/تحكم")

SecHouse:NewButton("إخفاء/تدمير كل البيوت (Ghost All Houses)", "يختفي كل البيوت", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("house") or obj:FindFirstChild("Owner") or obj.Name:find("Plot")) then
            obj:Destroy()
        end
    end
end)

SecHouse:NewButton("تدمير كل السيارات القريبة", "Clean Cars", function()
    for _, v in pairs(workspace.Vehicles:GetChildren()) do  -- غالبًا Vehicles Folder
        if v:IsA("Model") then
            v:Destroy()
        end
    end
end)

-- ================== Extra ==================
local TabExtra = Window:NewTab("إكسترا")
local SecExtra = TabExtra:NewSection("أدوات إضافية")

SecExtra:NewButton("تصغير الواجهة (Minimize)", "إخفاء الـ Panel مؤقتًا", toggleGUI)

SecExtra:NewButton("Infinite Yield (Admin شامل)", "فتح أوامر قوية جدًا", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

print("ZENO Metro Life Admin Loaded! → استخدم زر Minimize عشان تخفي/ترجع الواجهة")
