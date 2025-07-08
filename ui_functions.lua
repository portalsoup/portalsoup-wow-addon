local DELAY_TO_HIDE_SECONDS = 30

local function generateZonesToVisitText()
    local zonesToVisit = {}
    local knownZones = {}
    for id, obj in pairs(PortalsoupTrackedQuests) do
        if not isQuestComplete(id) and not knownZones[obj.zone] then
            table.insert(zonesToVisit, obj.zone)
            knownZones[obj.zone] = true
        end
    end

    local text = cyan("Zones to visit:") .. "\n"
    for _, zone in ipairs(zonesToVisit) do
        zoneText = zone
        if zone == GetZoneText() then
            zone = green(zone)
        end
        text = text .. string.format("%s\n", zone)
    end
    return text .. "\n"
end

local function generateText()
    local currentZone = GetZoneText()
    local mobsInThisZone = filter(PortalsoupTrackedQuests, function(mob)
        return mob.zone == currentZone
    end)

    return Portalsoup.MobsUI:Refresh(mobsInThisZone)
end

local function generateTimersText()
    local weeklyTimer = cyan("Weekly reset:") .. "  " .. timeToWeeklyReset()
    local dailyTimer = cyan("Daily reset:") .. "  " .. timeToDailyReset()

    return string.format("%s\n%s\n\n", weeklyTimer, dailyTimer)
end

local function UpdateDisplay()
    local dynamicHeight = generateText()
    local remainingTimeText = generateTimersText()
    local zonesToVisitText = generateZonesToVisitText()

    Portalsoup.frame.static.text:SetText(remainingTimeText .. zonesToVisitText .. cyan("\nThis zone:"))

    local width = math.max(180, Portalsoup.frame.static.text:GetStringWidth() + 20)
    local staticHeight = Portalsoup.frame.static.text:GetStringHeight()
    Portalsoup.frame.static:SetSize(width, staticHeight)

    -- define min dimensions but grow with text
    local height = staticHeight + dynamicHeight + 40
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
