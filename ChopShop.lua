----************ Hooks ************----

-- Removes shop button from menu bar
hooksecurefunc("UpdateMicroButtons", function(...)
    StoreMicroButton:Hide();
end)
