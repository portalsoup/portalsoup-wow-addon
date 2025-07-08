-- Setup window frame
Portalsoup.frame = CreateFrame("Frame", "QuestTrackerFrame", UIParent, "BackdropTemplate")
--Portalsoup.frame:SetSize(200, 200)
Portalsoup.frame:SetPoint("TOPLEFT")
Portalsoup.frame:SetBackdrop({
    bgFile      = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile    = "Interface/Tooltips/UI-Tooltip-Border",
    tile        = true,
    tileSize    = 16,
    edgeSize    = 16,
    insets = {
        left    = 4,
        right   = 4,
        top     = 4,
        bottom  = 4
    }
})
Portalsoup.frame:SetBackdropColor(0, 0, 0, 0.7)

Portalsoup.frame:EnableMouse(true)
Portalsoup.frame:SetMovable(true)
Portalsoup.frame:SetClampedToScreen(true)
Portalsoup.frame:RegisterForDrag("LeftButton")

Portalsoup.frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
Portalsoup.frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

-- Setup static window text
Portalsoup.frame.static = CreateFrame("Frame", "StaticTextFrame", Portalsoup.frame, "BackdropTemplate")
Portalsoup.title = Portalsoup.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Portalsoup.title:SetPoint("TOP", 0, -10)
Portalsoup.title:SetText("World Bosses")

Portalsoup.frame.static.text = Portalsoup.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
Portalsoup.frame.static.text:SetPoint("TOPLEFT", Portalsoup.frame, "TOPLEFT", 10, -30)
Portalsoup.frame.static.text:SetJustifyH("LEFT")
Portalsoup.frame.static.text:SetJustifyH("LEFT")
Portalsoup.frame.static.text:SetJustifyV("TOP")
Portalsoup.frame.static.text:SetText("")

-- Setup dynamic window text
Portalsoup.MobsUI:Create(Portalsoup.frame)
Portalsoup.MobsUI.frame:SetPoint("TOPLEFT", Portalsoup.frame.static.text, "BOTTOMLEFT", 0, 0)