-- Removes shop button from menu bar
hooksecurefunc("UpdateMicroButtons", function(...)
    if StoreMicroButton then
        StoreMicroButton:Hide();
		MainMenuMicroButton:SetAllPoints(StoreMicroButton);
    end
end)

-- Removes shop button from escape menu
hooksecurefunc("GameMenuFrame_UpdateVisibleButtons", function(...)
    local height = 292;
	GameMenuButtonUIOptions:SetPoint("TOP", GameMenuButtonOptions, "BOTTOM", 0, -1);

	local buttonToReanchor = GameMenuButtonWhatsNew;
	local reanchorYOffset = -1;

	if IsCharacterNewlyBoosted() or not C_SplashScreen.CanViewSplashScreen()  then
		GameMenuButtonWhatsNew:Hide();
		height = height - 20;
		buttonToReanchor = GameMenuButtonOptions;
		reanchorYOffset = -16;
		GameMenuFrame:SetHeight(height + 16);
	else
		GameMenuButtonWhatsNew:Show();
		GameMenuButtonOptions:SetPoint("TOP", GameMenuButtonWhatsNew, "BOTTOM", 0, -16);
		GameMenuFrame:SetHeight(height + 18);
	end

    GameMenuButtonStore:Hide();
    buttonToReanchor:SetPoint("TOP", GameMenuButtonHelp, "BOTTOM", 0, reanchorYOffset);
end)
