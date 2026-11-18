----************ Functions ************----

-- Removes shop button from menu bar
local function HideStoreButton()
    if StoreMicroButton and StoreMicroButton:IsShown() then
        StoreMicroButton:Hide()
    end
end

----************ Hooks ************----

-- StoreMicroButton shown
hooksecurefunc(StoreMicroButton, "Show", HideStoreButton)

-- Layout update fallback
hooksecurefunc("UpdateMicroButtons", HideStoreButton)
