
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
        print("/portalsoup add <questID> <name>")
        print("/portalsoup remove <questID>")
        print("/portalsoup show")
        print("/portalsoup hide")
        print("/portalsoup clean")
        print("/portalsoup init")

    end
end
