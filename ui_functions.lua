local DELAY_TO_HIDE_SECONDS = 30

function isQuestComplete(questID)
    return C_QuestLog.IsQuestFlaggedCompleted(questID)
end

function calculateQuest(questID, name)
    local isComplete = isQuestComplete(questID)
    local completedString = string.format("%s\n", green(name)) -- green colored text
    local incompletedString = string.format("%s\n", red(name)) -- red colored text

    if isComplete then return completedString else return incompletedString end
end

-- return true if already logged and after expiration
function logKill(questID)
    local now = GetTime() -- time since client start
    if isQuestComplete(questID) and isKillExpired(questID, now) then
        return true
    else
        Portalsoup.recentKills[questID] = now
    end
    return false
end

function isKillExpired(questID, timeOfKill)
    for id, timestamp in pairs(Portalsoup.recentKills) do
        local duration = timeOfKill - timestamp
        if id == questID and duration > DELAY_TO_HIDE_SECONDS then
            return true
        end
    end
    return false
end

local function generateZonesToVisitText()
    local zonesToVisit = {}
    local knownZones = {}
    for id, obj in pairs(PortalsoupTrackedQuests) do
        if not isQuestComplete(id) and not knownZones[obj.zone] then
            table.insert(zonesToVisit, obj.zone)
            knownZones[obj.zone] = true
        end
    end

    local text = green("Zones requiring visit:") .. "\n"
    for _, zone in ipairs(zonesToVisit) do
        zoneText = zone
        if zone == GetZoneText() then
            zone = cyan(zone)
        end
        text = text .. string.format("%s\n", zone)
    end
    return text .. "\n"
end

local function generateText()
    local text = ""
    for questID, obj in pairs(PortalsoupTrackedQuests) do
        local isExpiredKill = logKill(questID)
        local currentZone = GetZoneText()

        if not isExpiredKill and obj.zone == currentZone then
            text = text .. calculateQuest(questID, obj.name)
        end
    end
    if text == "" then
        return ""
    end
    return green("In this zone:") .. "\n" .. text
end

local function generateTimersText()
    local weeklyTimer = green("Weekly reset:") .. "  " .. timeToWeeklyReset()
    local dailyTimer = green("Daily reset:") .. "  " .. timeToDailyReset()

    return string.format("%s\n%s\n\n", weeklyTimer, dailyTimer)
end

local function UpdateDisplay()
    local statusText = generateText()
    local remainingTimeText = generateTimersText()
    local zonesToVisitText = generateZonesToVisitText()

    Portalsoup.text:SetText(remainingTimeText .. zonesToVisitText .. statusText)

    -- define min dimensions but grow with text
    local width = math.max(200, Portalsoup.text:GetStringWidth() + 20)
    local height = math.max(60, Portalsoup.text:GetStringHeight() + 40)
    Portalsoup.frame:SetSize(width, height)
end

-- This is a one time init of the recent kills to hide anything killed during a previous session
for id, _ in pairs(PortalsoupTrackedQuests) do
    local isComplete = isQuestComplete(id)
    if isComplete then
        Portalsoup.recentKills[id] = GetTime() - DELAY_TO_HIDE_SECONDS + 1
    end
end

-- render changes every second
C_Timer.NewTicker(1, UpdateDisplay)
