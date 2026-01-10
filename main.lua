-- [[ ZENO HUB: HOUSE & PLAYER CONTROL ]] --
-- مخصص للتحكم في بيوت اللاعبين ونقلهم

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🌪️ ZENO: PLAYER CONTROL", "BloodTheme")

-- [[ 👤 قسم التحكم في اللاعبين (Teleport) ]] --
local Tab1 = Window:NewTab("👥 Players Control")
local Section1 = Tab1:NewSection("Teleport & Move")

-- قائمة أسماء اللاعبين (بتتحدث تلقائياً)
local playerList = {}
for _, v in pairs(game.Players:GetPlayers()) do
    table.insert(playerList, v.Name)
end

local selectedPlayer = ""

Section1:NewDropdown("Select Player (اختر اللاعب)", "اختار الشخص اللي عايز تنقله", playerList, function(currentOption)
    selectedPlayer = currentOption
end)

Section1:NewButton("Teleport Out (طرده من بيته)", "بينقل اللاعب لمكان عشوائي بعيد", function()
    local target = game.Players:FindFirstChild(selectedPlayer)
    if target and target.Character then
        -- نقله لمنطقة بعيدة جداً تحت الماب أو في السماء
        target.Character.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0)
        print("Done: Player moved to sky")
    end
end)

Section1:NewButton("Bring to Me (هاته عندي)", "بيجيب اللاعب قدامك", function()
    local target = game.Players:FindFirstChild(selectedPlayer)
    if target and target.Character then
        target.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

-- [[ 🏠 قسم تدمير البيوت (House Destroyer) ]] --
local Tab2 = Window:NewTab("🏠 House Management")
local Section2 = Tab2:NewSection("Destroy & Reset")

Section2:NewButton("Clear My House (مسح بيتي)", "لو عايز تمسح بيتك بسرعة", function()
    -- ده كود مخصص لبروخ هافن ومترو لايف
    game:GetService("ReplicatedStorage").RemoteEvents.HouseEvent:FireServer("RemoveHouse")
end)

Section2:NewButton("Ghost House (إخفاء بيت الخصم)", "بيحاول يخفي البيت قدامك عشان تاخد مكانه", function()
    -- فكرة "إخفاء" بيت حد تاني بتكون بصرياً (Client-Side) عشان تقدر تبني مكانها
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and (v.Name:match("House") or v:FindFirstChild("Owner")) then
            if v:FindFirstChild("Owner") and v.Owner.Value == selectedPlayer then
                v:Destroy() -- البيت بيختفي عندك وتقدر تحط بيتك مكانه
                print("House of " .. selectedPlayer .. " has been hidden locally!")
            end
        end
    end
end)

Section2:NewButton("Unban from House", "فك البلوك لو حد طردك من بيته", function()
    game:GetService("ReplicatedStorage").RemoteEvents.HouseEvent:FireServer("UnbanMe")
end)

-- [[ 🛠️ تحديث القائمة ]] --
Section1:NewButton("Refresh Player List", "حدث قائمة الأسماء", function()
    -- الكود ده بيحدث الأسماء لو حد دخل أو خرج
    playerList = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        table.insert(playerList, v.Name)
    end
end)

-- [[ حماية من الطرد ]] --
pcall(function()
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end
        return old(self, ...)
    end)
end)
