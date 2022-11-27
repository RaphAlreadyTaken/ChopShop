-- Buttons should be stacked (true) or not
local stacked = false;

----************ Local functions ************----

-- Repositions Character button (first button) with offsets
function reanchorCharacterMicroButton(xOffset, yOffset)
    CharacterMicroButton:ClearAllPoints();
    CharacterMicroButton:SetPoint('BOTTOMLEFT', CharacterMicroButton:GetParent(), 'BOTTOMLEFT', xOffset, yOffset);
end

----************ Hooks ************----

-- Removes shop button from menu bar
hooksecurefunc("UpdateMicroButtons", function(...)
    StoreMicroButton:Hide();

    MainMenuMicroButton:ClearAllPoints();
    MainMenuMicroButton:SetPoint("TOPLEFT", EJMicroButton, "TOPRIGHT", 1, 0);

    if not stacked then
        reanchorCharacterMicroButton(27, 6);
    end
end)

-- Repositions buttons on layout changes (enter/exit pet battle or vehicle)
hooksecurefunc("MoveMicroButtons", function(_, _, _, _, _, isStacked)
    stacked = isStacked;
    local xOffset, yOffset = 27, 6;

    if stacked then
        if (HasVehicleActionBar()) then
            xOffset, yOffset = OverrideActionBarMixin:GetMicroButtonAnchor();
        elseif (HasOverrideActionBar()) then
            xOffset, yOffset = OverrideActionBarMixin:GetMicroButtonAnchor();
            xOffset = xOffset - 4;
        else
            xOffset, yOffset = 9, 26;
        end
    end

    reanchorCharacterMicroButton(xOffset, yOffset);
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