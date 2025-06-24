function isQuestComplete(questID)
    return C_QuestLog.IsQuestFlaggedCompleted(questID)
end

function calculateQuest(questID, name)
    local isComplete = isQuestComplete(questID)
    local completedString = string.format("%s %s\n", questID, green(name)) -- green colored text
    local incompletedString = string.format("%s %s\n", questID, red(name)) -- red colored text

    if isComplete then return completedString else return incompletedString end
end

-- return true if already dead after expiration
function logIfKill(questID)
    local now = GetTime() -- time since client start
    if isQuestComplete(questID) then
        for id, timestamp in pairs(Portalsoup.recentKills) do
            local duration = now - timestamp
            local expiration = (5)
            if id == questID and duration > expiration then
                return true
            end
        end
    else Portalsoup.recentKills[questID] = now end
    return false
end

local function generateText()
    local text = ""
    for questID, name in pairs(PortalsoupTrackedQuests) do
        local isExpiredKill = logIfKill(questID)

        if not isExpiredKill then
            text = text .. calculateQuest(questID, name)
        end
    end
    return text
end

local function generateTimersText()
    local weeklyTimer = green("Weekly reset:") .. "  " .. timeToWeeklyReset()
    local dailyTimer = green("Daily reset:") .. "  " .. timeToDailyReset()

    return string.format("%s\n%s\n\n", weeklyTimer, dailyTimer)
end

local function UpdateDisplay()
    local statusText = generateText()
    local remainingTimeText = generateTimersText()

    Portalsoup.text:SetText(remainingTimeText .. statusText)

    -- define min dimensions but grow with text
    local width = math.max(200, Portalsoup.text:GetStringWidth() + 20)
    local height = math.max(60, Portalsoup.text:GetStringHeight() + 40)
    Portalsoup.frame:SetSize(width, height)
end

-- This is a one time init of the recent kills for anything killed before login
for id, _ in pairs(PortalsoupTrackedQuests) do
    local isComplete = isQuestComplete(id)
    if isComplete then
        Portalsoup.recentKills[id] = GetTime()
    end
end

-- render changes every second
C_Timer.NewTicker(1, UpdateDisplay)
