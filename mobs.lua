Portalsoup.MobsUI = {}
Portalsoup.MobsUI.buttons = {}

function Portalsoup.MobsUI:Create(parentFrame)
    if self.frame then
        self.frame:Hide()
        self.frame:SetParent(nil)
    end

    self.frame = CreateFrame("Frame", "MobsListFrame", parentFrame, "BackdropTemplate")
    --self.frame:SetSize(200, 300)
    self.frame:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 0, -10)

    self.frame:Show()

    return self.frame
end

function Portalsoup.MobsUI:Refresh(mobsList)
    for _, button in ipairs(self.buttons) do
        button:Hide()
        button:SetParent(nil)
    end
    wipe(self.buttons)

    local lastButton = self.frame
    local contentHeight = 0
    local buttonSpacing = 5
    local buttonHeight = 20

    for id, mob in pairs(mobsList) do
        local button = createMobButton(lastButton, id, mob)
        table.insert(self.buttons, button)
        lastButton = button
        contentHeight = contentHeight + buttonHeight + buttonSpacing
    end

    Portalsoup.MobsUI.frame:SetSize(180, contentHeight)
    Portalsoup.MobsUI.frame:SetPoint("BOTTOMLEFT", Portalsoup.frame, "BOTTOMLEFT", 0, 0)

    return contentHeight
end

function createMobButton(lastButton, id, mob)
    local button = CreateFrame("Button", "MobButton" .. id, lastButton, "BackdropTemplate")
    button:SetPoint("TOPLEFT", lastButton, "TOPLEFT", 0, 0)

    local text = calculateQuest(id, mob.name)

    local fontString = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fontString:SetPoint("LEFT")
    fontString:SetText(text)
    button.fontString = fontString

    local buttonWidth = math.max(180, fontString:GetStringWidth() + 20)
    local buttonHeight = fontString:GetStringHeight() + 10
    button:SetSize(buttonWidth, buttonHeight)
    button:Show()

    button.mobId = id
    button:SetScript("OnClick", function(self)
        print(self.mobId)
    end)

    return button
end
