-- Initialize the persistent data variable
function init()
    -- first time run, pre-populate with some bosses, `/portalsoup init` in cli.lua also does this
    return {
        [32098] = "Galleon",
        [37464] = "Rukhmar",
        [32099] = "Sha of Anger",
        [32518] = "Nalak <The Storm Lord>",
        [32519] = "Oondasta",
    }
end

if not PortalsoupSavedData then
    PortalsoupSavedData = init()
end

Portalsoup = Portalsoup or {}
