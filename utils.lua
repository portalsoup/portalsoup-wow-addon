function timeToDailyReset()
    return SecondsToTime(GetQuestResetTime())
end

function timeToWeeklyReset()
    return SecondsToTime(C_DateAndTime.GetSecondsUntilWeeklyReset())
end

function red(str)
    return string.format("|cffff0000%s|r", str)
end

function green(str)
    return string.format("|cff00ff00%s|r", str)
end

function cyan(str)
    return string.format("|cff00ffff%s|r", str)
end

function filter(map, predicate)
    local result = {}
    for key, value in pairs(map) do
        if predicate(value, key) then
            result[key] = value
        end
    end
    return result
end

function AddDebugBorder(frame, color)
    color = color or { r = 1, g = 0, b = 0, a = 1 } -- default red border
    frame:SetBackdrop({
        bgFile = nil,
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })
    frame:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
end

-- return true if already dead and after expiration
function logKill(questID)
    local now = GetTime() -- time since client start
    if isQuestComplete(questID) then
        return isKillExpired(questID, now)
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

function isQuestComplete(questID)
    return C_QuestLog.IsQuestFlaggedCompleted(questID)
end

function calculateQuest(questID, name)
    local isComplete = isQuestComplete(questID)
    local completedString = string.format("%s\n", green(name))
    local incompletedString = string.format("%s\n", name)

    if isComplete then return completedString else return incompletedString end
end