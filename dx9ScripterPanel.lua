--indent size 4
local startTime = os.clock()

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/B0NBunny/DXLibUI/refs/heads/personaldev/main.lua";
        LibESP = "https://raw.githubusercontent.com/B0NBunny/DXLibESP/refs/heads/main/main.lua";
	};
	settings = {
		menu_toggle_keybind = "[F2]";

		maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;
	};
}
if _G.config == nil then
	_G.config = config
	config = _G.config
end

if _G.averageHz == nil then
	_G.averageHz = 0
end

if _G.averageSec == nil then
	_G.averageSec = 0
end

if _G.clearedConsole == nil then
	_G.clearedConsole = false
end

if _G.consoleEnabled == nil then
	_G.consoleEnabled = false
end

if _G.clearedConsole == true then
	_G.clearedConsole = false
end

if _G.lastElapsedCycleTimesCache == nil then
	_G.lastElapsedCycleTimesCache = {}
elseif _G.lastElapsedCycleTimesCache ~= nil then
	local cache_entries = #_G.lastElapsedCycleTimesCache
	if cache_entries >= 1 then
		local sum = 0
		for index, elapsedCycleTime in ipairs(_G.lastElapsedCycleTimesCache) do
			sum = sum + elapsedCycleTime
		end
		local averageSeconds = sum / cache_entries
		local Sec_precision = 10 ^ config.settings.Sec_precision
		local flooredSec = math.floor(averageSeconds * Sec_precision) / Sec_precision
		_G.averageSec = flooredSec or 0
		if averageSeconds > 0 and averageSeconds < math.huge then
			local averageHertz = 1 / averageSeconds
			local Hz_precision = 10 ^ config.settings.Hz_precision
			local flooredHertz = math.floor(averageHertz * Hz_precision) / Hz_precision
			_G.averageHz = flooredHertz or 0
		else
			_G.averageHz = 0
		end
	end
end

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

lib_esp = loadstring(dx9.Get(config.urls.LibESP))()

interface = lib_ui:CreateWindow({
	Title = "Scripter Panel | dx9ware | By @Brycki";
	Size = { 500, 500 };
	Resizable = true;

	ToggleKey = config.settings.menu_toggle_keybind;

	FooterToggle = true;
	FooterRGB = true;
	FontColor = { 255, 255, 255 };
	MainColor = { 25, 25, 25 };
	BackgroundColor = { 20, 20, 20 };
	AccentColor = { 255, 50, 255 };
	OutlineColor = { 40, 40, 40 };
})

tabs = {}
tabs.debug = interface:AddTab("Debug")
tabs.deepsearch = interface:AddTab("Deep Search")

groupboxes = {}
groupboxes.debug = tabs.debug:AddMiddleGroupbox("Debugging")
groupboxes.deepsearch = tabs.deepsearch:AddMiddleGroupbox("Deep Search")

debugging = {}
debugging.console = groupboxes.debug:AddToggle({
		Default = false;
		Text = "Console Enabled";
	}):OnChanged(function(value)
		lib_ui:Notify(value and "[Debug] Enabled Console" or "[Debug] Disabled Console", 1)
		if value then
			_G.consoleEnabled = true
			dx9.ClearConsole()
			dx9.ShowConsole(true)
		else
			_G.consoleEnabled = false
			dx9.ClearConsole()
			dx9.ShowConsole(false)
		end
	end)
debugging.sec = groupboxes.debug:AddLabel("Avg. Program Cycle: ".._G.averageSec.." s")
debugging.hz = groupboxes.debug:AddLabel("Avg. Program Cycle: ".._G.averageHz.." Hz")
debugging.clock = groupboxes.debug:AddLabel("Clock: "..os.clock())

deepsearch = {}
deepsearch.exactmatch = groupboxes.deepsearch:AddToggle({
	Index = "deepsearch_exactmatch";
	Text = "Exact Match";
	Default = false;
}):AddTooltip("Whether Or Not The Instance Name You Search For Has To Be An Exact Match"):OnChanged(function(value)
	lib_ui:Notify("Toggled Exact Match to "..tostring(value), 1)
end)
deepsearch.searchbox = groupboxes.deepsearch:AddTextBox({
	Index = "deepsearch_searchbox";
	Placeholder = ">>INSTANCE NAME HERE<<";
}):AddTooltip("Search For All Instances With This Name")
deepsearch.searchbutton = groupboxes.deepsearch:AddButton( "Search" , function()
	lib_ui:Notify("Searching...", 1)
end):AddTooltip("Click To Start A Search")

--[[ USE THIS CODE FOR STUFF LATER, IT'S GREAT
scripting.test_keybinder = groupboxes.scripting:AddKeybindButton({
	Index = "Test_Keybinder_1";
	Text = "Test Keybind: [F4]";
	Default = "[F4]";
}):AddTooltip("Tooltip Text")
scripting.test_keybinder = scripting.test_keybinder:OnChanged(function(newKey)
	local oldText = scripting.test_keybinder.Text
	scripting.test_keybinder:SetText("Test Keybind: "..tostring(newKey))
	lib_ui:Notify("Test Keybind Text set from '"..tostring(oldText).."' to '"..tostring(newKey).."'", 1)
end)

scripting.test_button = groupboxes.scripting:AddButton( "Test Button" , function()
	lib_ui:Notify("Test Button Pressed!", 1)
end):AddTooltip("Tooltip Text")
scripting.test_button:ConnectKeybindButton(scripting.test_keybinder)

scripting.test_toggle = groupboxes.scripting:AddToggle({
	Index = "Test_Toggle_1";
	Text = "Test Toggle";
	Default = false;
}):AddTooltip("Tooltip Text"):OnChanged(function(value)
	lib_ui:Notify("Toggled Test Toggle to "..tostring(value), 1)
end)
scripting.test_toggle:ConnectKeybindButton(scripting.test_keybinder)
]]

if _G.Get_Distance == nil then
	_G.Get_Distance = function(v1, v2)
		local a = (v1.x - v2.x)
		local b = (v1.y - v2.y)
		local c = (v1.z - v2.z)

		return math.sqrt(a^2 + b^2 + c^2)
	end
end

if _G.Get_Index == nil then
	_G.Get_Index = function(type, value)
		local table = nil
		if type == "game" then
			table = { "Blade Ball", "Death Ball" }
		end

		if table then
			for index, item in pairs(table) do
				if item == value then
					return index
				end
			end
		end

		return nil
	end
end

datamodel = dx9.GetDatamodel()
workspace = dx9.FindFirstChild(datamodel, "Workspace")
services = {
	players = dx9.FindFirstChild(datamodel, "Players");
}

local_player = nil
local_player_table = dx9.get_localplayer()
current_fps = game_settings.fps and game_settings.fps.Value and tonumber(game_settings.fps.Value) or 60

if local_player == nil then
	for _, player in pairs(dx9.GetChildren(services.players)) do
		local pgui = dx9.FindFirstChild(player, "PlayerGui")
		if pgui ~= nil and pgui ~= 0 then
			local_player = player
			break
		end
	end
end

function get_local_player_name()
	if local_player ~= nil and local_player ~= 0 and dx9.GetType(local_player) == "Player" then
		return dx9.GetName(local_player)
	else
		local_player_table = dx9.get_localplayer()
		return local_player_table.Info.Name
	end
end

local_player_name = get_local_player_name()

my_player = dx9.FindFirstChild(services.players, local_player_name)

if my_player ~= nil and my_player ~= 0 then
    --do stuff
end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end