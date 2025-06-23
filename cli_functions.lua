function add(args)
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
end

function remove(args)
    local questID = tonumber(args)
    if PortalsoupSavedData[questID] then
        print("Removed '" .. PortalsoupSavedData[questID] .. "' (ID " .. questID .. ")")
        PortalsoupSavedData[questID] = nil
    else
        print("Quest ID " .. questID .. " not tracked.")
    end
end

function show()
    QuestTrackerFrame:Show()
end

function hide()
    QuestTrackerFrame:Show()
end

function clean()
    if PortalsoupSavedData then
        PortalsoupSavedData = {}
    end
end

function init()
    clean()
    PortalsoupSavedData = Portalsoup.defaultInit
end