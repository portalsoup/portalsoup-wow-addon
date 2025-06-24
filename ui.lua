-- utility functions
local function timeToDailyReset()
    return SecondsToTime(GetQuestResetTime())
end

local function timeToWeeklyReset()
    return SecondsToTime(C_DateAndTime.GetSecondsUntilWeeklyReset())
end

-- Setup window frame
Portalsoup.frame = CreateFrame("Frame", "QuestTrackerFrame", UIParent, "BackdropTemplate")
Portalsoup.frame:SetSize(200, 200)
Portalsoup.frame:SetPoint("TOPLEFT")
Portalsoup.frame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true,
    tileSize    = 16,
    edgeSize    = 16,
    insets = {
        left    = 4,
        right   = 4,
        top     = 4,
        bottom  = 4
    }
})
Portalsoup.frame:SetBackdropColor(0, 0, 0, 0.7)

Portalsoup.frame:EnableMouse(true)
Portalsoup.frame:SetMovable(true)
Portalsoup.frame:SetClampedToScreen(true)
Portalsoup.frame:RegisterForDrag("LeftButton")

Portalsoup.frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
Portalsoup.frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

-- Setup window text
Portalsoup.title = Portalsoup.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Portalsoup.title:SetPoint("TOP", 0, -10)
Portalsoup.title:SetText("World Bosses")

Portalsoup.text = Portalsoup.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
Portalsoup.text:SetPoint("TOPLEFT", 10, -30)
Portalsoup.text:SetJustifyH("LEFT")
Portalsoup.text:SetJustifyH("LEFT")
Portalsoup.text:SetJustifyV("TOP")
Portalsoup.text:SetText("")

local function red(str)
    return string.format("|cffff0000%s|r", str)
end

local function green(str)
    return string.format("|cff00ff00%s|r", str)
end

local function generateText()
    local text = ""
    for questID, name in pairs(PortalsoupSavedData) do
        local isComplete = C_QuestLog.IsQuestFlaggedCompleted(questID)
        local completedString = string.format("%s %s", questID, green(name)) -- green colored text
        local incompletedString = string.format("%s %s", questID, red(name)) -- red colored text

        text = text .. string.format("%s\n", isComplete and completedString or incompletedString)
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

-- render changes every second
C_Timer.NewTicker(1, UpdateDisplay)
