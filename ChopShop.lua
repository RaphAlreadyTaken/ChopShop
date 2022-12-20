-- Buttons should be stacked (true) or not
local stacked = false;

----************ Local functions ************----

-- Repositions Character button (first button) with offsets
function reanchorCharacterMicroButton(anchor, anchorTo, relAnchor, x, y)
    CharacterMicroButton:ClearAllPoints();
    CharacterMicroButton:SetPoint(anchor, anchorTo, relAnchor, x, y);
end

----************ Hooks ************----

-- Removes shop button from menu bar
hooksecurefunc("UpdateMicroButtons", function(...)
    StoreMicroButton:Hide();

    MainMenuMicroButton:ClearAllPoints();
    MainMenuMicroButton:SetPoint("TOPLEFT", EJMicroButton, "TOPRIGHT", 1, 0);

    if not stacked then
        reanchorCharacterMicroButton('BOTTOMLEFT', CharacterMicroButton:GetParent(), 'BOTTOMLEFT',  27, 6);
    end
end)

-- Repositions buttons on layout changes (enter/exit pet battle or vehicle)
hooksecurefunc("MoveMicroButtons", function(anchor, anchorTo, relAnchor, x, y, isStacked)
    stacked = isStacked;

    if stacked then
        reanchorCharacterMicroButton(anchor, anchorTo, relAnchor, x, y);
    else
        reanchorCharacterMicroButton(anchor, anchorTo, relAnchor, 27, 6);
    end
end)

-- Removes shop button from escape menu
hooksecurefunc("GameMenuFrame_UpdateVisibleButtons", function(...)
    local height = 280;

    local buttonToReanchor = GameMenuButtonWhatsNew;
    local reanchorYOffset = -1;

    if IsCharacterNewlyBoosted() or not C_SplashScreen.CanViewSplashScreen() then
        GameMenuButtonWhatsNew:Hide();
        height = height - 20;
        buttonToReanchor = GameMenuButtonSettings;
        reanchorYOffset = -16;
        GameMenuFrame:SetHeight(height + 16);
    else
        GameMenuButtonWhatsNew:Show();
        GameMenuFrame:SetHeight(height + 18);
    end

    GameMenuButtonStore:Hide();
    buttonToReanchor:SetPoint("TOP", GameMenuButtonHelp, "BOTTOM", 0, reanchorYOffset);
end)