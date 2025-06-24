-- This one is persistent across logins
if not PortalsoupTrackedQuests then
    PortalsoupTrackedQuests = {
        [32098] = "Galleon",
        [32099] = "Sha of Anger",
        [32518] = "Nalak <The Storm Lord>",
        [32519] = "Oondasta",
        [37464] = "Rukhmar",
        [39288] = "Terrorfist",
        [39287] = "Deathtalon",
        [39289] = "Doomroller",
        [39290] = "Vengeance",
        [37546] = "Warleader Tome",
        [84054] = "Croakit",
        [81763] = "Beledar's Shadow",
    }
end

if not Portalsoup then
    Portalsoup = {}
    Portalsoup.recentKills = {}
end
