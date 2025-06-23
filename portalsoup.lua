-- Initialize the persistent data variable
if not PortalsoupSavedData then
    PortalsoupSavedData = init()
end

-- Setup window
local frame = CreateFrame("Frame", "QuestTrackerFrame", UIParent, "BackdropTemplate")
frame:SetSize(200, 200)
frame:SetPoint("TOPLEFT")
frame:SetBackdrop({
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
frame:SetBackdropColor(0, 0, 0, 0.7)

frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetClampedToScreen(true)
frame:RegisterForDrag("LeftButton")

frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

-- Setup window text
local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title:SetPoint("TOP", 0, -10)
title:SetText("Daily Quests")

local text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetPoint("TOPLEFT", 10, -30)
text:SetJustifyH("LEFT")
text:SetJustifyV("TOP")
text:SetText("")

local function UpdateDisplay()
    local statusText = ""
    for questID, name in pairs(PortalsoupSavedData) do
        local isComplete = C_QuestLog.IsQuestFlaggedCompleted(questID)
        local completed = string.format("|cff00ff00%s|r", name)
        local incompleted = string.format("|cffff0000%s|r", name)
--         local check = complete and "|cff00ff00[x]|r" or "|cffff0000[ ]|r"
        statusText = statusText .. string.format("%s\n", isComplete and completed or incompleted)
--         statusText = statusText .. string.format("%s %s\n", check, name)
    end
    text:SetText(statusText)

    local width = math.max(200, text:GetStringWidth() + 20)
    local height = math.max(60, text:GetStringHeight() + 40)
    frame:SetSize(width, height)
end

C_Timer.NewTicker(1, UpdateDisplay)

-- cli
SLASH_PORTALSOUP1 = "/portalsoup"
SlashCmdList["PORTALSOUP"] = function(msg)
    local cmd, args = msg:match("^(%S*)%s*(.*)$")
    if cmd == "add" then
        local questID, name = args:match("^(%d+)%s*(.*)$")
        if questID then
            questID = tonumber(questID)

            local title = C_QuestLog.GetTitleForQuestID(questID)
            if (not title or title == "") then
                title = name
            end

            if title then
                print("Tracking quest " .. title)
            else
                print("Unable to find " .. questID)
            end
            PortalsoupSavedData[questID] = title
        else
            print("Usage: /portalsoup add {id} {title}")
        end

    elseif cmd == "remove" and tonumber(args) then
        local questID = tonumber(args)
        if PortalsoupSavedData[questID] then
            print("Removed '" .. PortalsoupSavedData[questID] .. "' (ID " .. questID .. ")")
            PortalsoupSavedData[questID] = nil
        else
            print("Quest ID " .. questID .. " not tracked.")
        end

    elseif cmd == "show" then
        QuestTrackerFrame:Show()
        print("PortalSoup: Display shown.")
    elseif cmd == "hide" then

        QuestTrackerFrame:Hide()
        print("PortalSoup: Display hidden.")

    elseif cmd == "clean" then
        wipe(PortalsoupSavedData)
        print("Cleared tracked dailies")

    elseif cmd == "init" then
        wipe(PortalsoupSavedData)
        PortalsoupSavedData = init()

    else
        print("PortalSoup commands:")
        print("/portalsoup add <questID>")
        print("/portalsoup remove <questID>")
        print("/portalsoup show")
        print("/portalsoup hide")
    end
end
