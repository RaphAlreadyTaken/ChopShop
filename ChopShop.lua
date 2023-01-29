----************ Hooks ************----

-- Removes shop button from menu bar
hooksecurefunc("UpdateMicroButtons", function(...)
    StoreMicroButton:Hide();
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