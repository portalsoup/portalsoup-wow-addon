if not Portalsoup then
    Portalsoup = {}
    Portalsoup.recentKills = {}
    Portalsoup.defaultInit = {
        [32098] = { name = "Galleon", zone = "Valley of the Four Winds" },
        [32099] = { name = "Sha of Anger", zone = "Kun-Lai Summit" },
        [32518] = { name = "Nalak <The Storm Lord>", zone = "Isle of Thunder" },
        [32519] = { name = "Oondasta", zone = "Isle of Giants" },
        [37464] = { name = "Rukhmar", zone = "Spires of Arak" },
        [39288] = { name = "Terrorfist", zone = "Tanaan Jungle" },
        [39287] = { name = "Deathtalon", zone = "Tanaan Jungle" },
        [39289] = { name = "Doomroller", zone = "Tanaan Jungle" },
        [39290] = { name = "Vengeance", zone = "Tanaan Jungle" },
        [37546] = { name = "Warleader Tome", zone = "Nagrand" },
        [82560] = { name = "Croakit", zone = "Hallowfall" },
        [81763] = { name = "Beledar's Shadow", zone = "Hallowfall" },
        [78213] = { name = "Matriarch Keevah", zone = "Emerald Dream", },
        [78210] = { name = "Moragh The Slothful", zone = "Emerald Dream", },
        [77890] = { name = "Ristar The Rabid", zone = "Emerald Dream", },
        [77940] = { name = "Mosa Umbramane", zone = "Emerald Dream", },
        [78211] = { name = "Keen-Eyed Cian", zone = "Emerald Dream", },
        [77994] = { name = "Talthonei Ashwhisper", zone = "Emerald Dream", },
    }
end

-- This one is persistent across logins
if not PortalsoupTrackedQuests then
    PortalsoupTrackedQuests = Portalsoup.defaultInit
end