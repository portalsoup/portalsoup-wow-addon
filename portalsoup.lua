-- Initialize the persistent data variable
if not PortalsoupSavedData then
    PortalsoupSavedData = {}
end

if not Portalsoup then
    Portalsoup = {}
end

Portalsoup.defaultInit = {
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

Portalsoup = Portalsoup or Portalsoup.defaultInit
