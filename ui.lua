-- Setup window
Portalsoup.frame = CreateFrame("Frame", "QuestTrackerFrame", UIParent, "BackdropTemplate")
Portalsoup.frame:SetSize(200, 200)
Portalsoup.frame:SetPoint("TOPLEFT")
Portalsoup.frame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4
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
Portalsoup.title:SetText("Daily Quests")

Portalsoup.text = Portalsoup.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
Portalsoup.text:SetPoint("TOPLEFT", 10, -30)
Portalsoup.text:SetJustifyH("LEFT")
Portalsoup.text:SetJustifyH("LEFT")
Portalsoup.text:SetJustifyV("TOP")
Portalsoup.text:SetText("")

-- Setup update handler
local function UpdateDisplay()
    local statusText = ""
    for questID, name in pairs(PortalsoupSavedData) do
        local isComplete = C_QuestLog.IsQuestFlaggedCompleted(questID)
        local completed = string.format("|cff00ff00%s|r", name) -- green colored text
        local incompleted = string.format("|cffff0000%s|r", name) -- red colored text
--         local check = complete and "|cff00ff00[x]|r" or "|cffff0000[ ]|r"
        statusText = statusText .. string.format("%s\n", isComplete and completed or incompleted)
--         statusText = statusText .. string.format("%s %s\n", check, name)
    end
    Portalsoup.text:SetText(statusText)

    local width = math.max(200, Portalsoup.text:GetStringWidth() + 20)
    local height = math.max(60, Portalsoup.text:GetStringHeight() + 40)
    Portalsoup.frame:SetSize(width, height)
end

-- render changes every second
C_Timer.NewTicker(1, UpdateDisplay)
