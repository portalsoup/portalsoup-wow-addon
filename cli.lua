SLASH_PORTALSOUP1 = "/portalsoup" -- The variable name here must be this way for the game to detect the command's presence

SlashCmdList["PORTALSOUP"] = function(msg)
    local cmd, args = msg:match("^(%S*)%s*(.*)$")
    if cmd == "add" then add(args)
    elseif cmd == "remove" and tonumber(args) then remove(args)
    elseif cmd == "show" then show()
    elseif cmd == "hide" then hide()
    elseif cmd == "clean" then clean()
    elseif cmd == "init" then init()
    else
        print("Portalsoup commands:")
        print("/portalsoup add <questID> <name>")
        print("/portalsoup remove <questID>")
        print("/portalsoup show")
        print("/portalsoup hide")
        print("/portalsoup clean")
        print("/portalsoup init")

    end
end
