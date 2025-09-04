--[[ USE THIS CODE FOR STUFF LATER, IT'S GREAT
scripting.test_keybinder = Groupboxes.scripting:AddKeybindButton({
	Index = "Test_Keybinder_1";
	Text = "Test Keybind: [F4]";
	Default = "[F4]";
}):AddTooltip("Tooltip Text")
scripting.test_keybinder = scripting.test_keybinder:OnChanged(function(newKey)
	local oldText = scripting.test_keybinder.Text
	scripting.test_keybinder:SetText("Test Keybind: "..tostring(newKey))
	Lib_ui:Notify("Test Keybind Text set from '"..tostring(oldText).."' to '"..tostring(newKey).."'", 1)
end)

scripting.test_button = Groupboxes.scripting:AddButton( "Test Button" , function()
	Lib_ui:Notify("Test Button Pressed!", 1)
end):AddTooltip("Tooltip Text")
scripting.test_button:ConnectKeybindButton(scripting.test_keybinder)

scripting.test_toggle = Groupboxes.scripting:AddToggle({
	Index = "Test_Toggle_1";
	Text = "Test Toggle";
	Default = false;
}):AddTooltip("Tooltip Text"):OnChanged(function(value)
	Lib_ui:Notify("Toggled Test Toggle to "..tostring(value), 1)
end)
scripting.test_toggle:ConnectKeybindButton(scripting.test_keybinder)
]]