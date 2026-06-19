-- Mô phỏng cấu trúc Logic Auto Farm trong Roblox Studio
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Cấu hình thông tin mục tiêu
local TargetQuest = "Nhiệm vụ Cướp Biển"
local EnemyName = "Bandit"
local LevelRequired = 10

-- 1. Hàm kiểm tra cấp độ của người chơi
local function checkPlayerLevel()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        local level = leaderstats:FindFirstChild("Level")
        if level and level.Value >= LevelRequired then
            return true
        end
    end
    return false
end

-- 2. Hàm mô phỏng di chuyển mượt mà (Tween) tới mục tiêu
local function moveToTarget(targetPosition)
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if rootPart then
        local distance = (rootPart.Position - targetPosition).Position.Magnitude
        local speed = 50 -- Tốc độ di chuyển
        local duration = distance / speed
        
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
        tween:Play()
        tween.Completed:Wait() -- Chờ di chuyển xong
    end
end

-- 3. Vòng lặp chính điều khiển AI Farm
local function startSimulation()
    if checkPlayerLevel() then
        print("Đủ cấp độ! Bắt đầu tìm vị trí nhận nhiệm vụ: " .. TargetQuest)
        
        -- Giả lập vị trí NPC nhận nhiệm vụ và vị trí Quái
        local npcPosition = Vector3.new(100, 20, 150)
        local enemyPosition = Vector3.new(200, 20, 300)
        
        -- Di chuyển tới NPC nhận nhiệm vụ
        moveToTarget(npcPosition)
        print("Đã nhận nhiệm vụ thành công!")
        
        -- Di chuyển tới bãi quái
        moveToTarget(enemyPosition)
        print("Đã đến bãi quái. Bắt đầu kích hoạt lệnh tấn công " .. EnemyName)
    else
        print("Chưa đủ cấp độ để farm bãi này!")
    end
end

-- Chạy thử nghiệm hệ thống mô phỏng
startSimulation()
