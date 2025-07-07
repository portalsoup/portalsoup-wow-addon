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
        PortalsoupTrackedQuests[questID].name = title
    else
        print("Usage: /portalsoup add {id} {title}")
    end
end

function remove(args)
    local questID = tonumber(args)
    if PortalsoupTrackedQuests[questID] then
        print("Removed '" .. PortalsoupTrackedQuests[questID].name .. "' (ID " .. questID .. ")")
        PortalsoupTrackedQuests[questID] = nil
    else
        print("Quest ID " .. questID .. " not tracked.")
    end
end

function show()
    QuestTrackerFrame:Show()
end

function hide()
    QuestTrackerFrame:Hide()
end

function clean()
    if PortalsoupTrackedQuests then
        PortalsoupTrackedQuests = {}
    end
end

function init()
    clean()
    PortalsoupTrackedQuests = Portalsoup.defaultInit
end