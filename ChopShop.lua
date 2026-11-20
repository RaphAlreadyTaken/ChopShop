----************ Functions ************----

-- Removes shop button from menu bar
local function HideStoreButton()
    if StoreMicroButton and StoreMicroButton:IsShown() then
        StoreMicroButton:Hide()
    end
end

-- Removes shop button from escape menu
local function HideGameMenuStoreButton(self)
    if not self.buttonPool then
        return
    end

    for button in self.buttonPool:EnumerateActive() do
        if button:GetText() == BLIZZARD_STORE then
            self.buttonPool:Release(button)
            break
        end
    end
end

----************ Hooks ************----

-- StoreMicroButton shown
hooksecurefunc(StoreMicroButton, "Show", HideStoreButton)

-- Layout update fallback
hooksecurefunc("UpdateMicroButtons", HideStoreButton)

-- Escape menu populating button pool
hooksecurefunc(GameMenuFrame, "InitButtons", HideGameMenuStoreButton)