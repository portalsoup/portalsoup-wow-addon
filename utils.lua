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
