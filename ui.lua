-- Setup window frame
Portalsoup.frame = CreateFrame("Frame", "QuestTrackerFrame", UIParent, "BackdropTemplate")
Portalsoup.frame:SetSize(200, 200)
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

-- Setup window text
Portalsoup.title = Portalsoup.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Portalsoup.title:SetPoint("TOP", 0, -10)
Portalsoup.title:SetText("World Bosses")

Portalsoup.text = Portalsoup.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
Portalsoup.text:SetPoint("TOPLEFT", 10, -30)
Portalsoup.text:SetJustifyH("LEFT")
Portalsoup.text:SetJustifyH("LEFT")
Portalsoup.text:SetJustifyV("TOP")
Portalsoup.text:SetText("")
