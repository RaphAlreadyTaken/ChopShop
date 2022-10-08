--  List of buttons to process after shop removal
local MICRO_BUTTONS = {
    CharacterMicroButton,
    SpellbookMicroButton,
    TalentMicroButton,
    AchievementMicroButton,
    QuestLogMicroButton,
    GuildMicroButton,
    LFDMicroButton,
    CollectionsMicroButton,
    EJMicroButton,
    MainMenuMicroButton,
    HelpMicroButton,
}

-- Buttons should be stacked (true) or not
local stacked = false;


----************ Local functions ************----

-- Positions buttons next to one another with an x offset
function positionButtons(buttonList, xOffset)
    local currentButton = buttonList[1];

    for i = 2, #buttonList do
        buttonList[i]:ClearAllPoints();
        buttonList[i]:SetPoint("BOTTOMLEFT", currentButton, "BOTTOMRIGHT", xOffset, 0);
        currentButton = buttonList[i]
    end
end

-- Distributes remaining buttons in MicroButtonAndBagsBar (main layout)
function spaceButtonsOut(buttonList)
    positionButtons(buttonList, 1);
end

-- Stacks buttons in MicroButtonAndBagsBar (vehicle and pet battle layouts)
function stackButtons(buttonList)
    positionButtons(buttonList, -2);

    -- LFDMicroButton is the first button of the second row
    LFDMicroButton:ClearAllPoints();
    LFDMicroButton:SetPoint("TOPLEFT", CharacterMicroButton, "BOTTOMLEFT", 0, -1);
end


----************ Hooks ************----

-- Removes shop button from menu bar
hooksecurefunc("UpdateMicroButtons", function(...)
    StoreMicroButton:Hide();

    if not stacked then
        spaceButtonsOut(MICRO_BUTTONS);
    end
end)

-- Repositions buttons on layout changes
hooksecurefunc("MoveMicroButtons", function(_, _, _, _, _, isStacked)
    stacked = isStacked;

    if stacked then
        stackButtons(MICRO_BUTTONS);
    else
        spaceButtonsOut(MICRO_BUTTONS);
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