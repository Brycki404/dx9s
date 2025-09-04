--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

Config = _G.Config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
        Repr = "https://raw.githubusercontent.com/Ozzypig/Repr/refs/heads/master/Repr.lua";
	};
    settings = {
		menu_toggle_keybind = "[F2]";
		
		master_esp_enabled = true;
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"

        maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;
    };
};
if _G.Config == nil then
	_G.Config = Config
	Config = _G.Config
end

if _G.selectedWaypointIndex == nil then
	_G.selectedWaypointIndex = 0
end

if _G.waypointlist == nil then
    _G.waypointlist = {}
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
		local Sec_precision = 10 ^ Config.settings.Sec_precision
		local flooredSec = math.floor(averageSeconds * Sec_precision) / Sec_precision
		_G.averageSec = flooredSec or 0
		if averageSeconds > 0 and averageSeconds < math.huge then
			local averageHertz = 1 / averageSeconds
			local Hz_precision = 10 ^ Config.settings.Hz_precision
			local flooredHertz = math.floor(averageHertz * Hz_precision) / Hz_precision
			_G.averageHz = flooredHertz or 0
		else
			_G.averageHz = 0
		end
	end
end

if _G.CountTableEntries == nil then
	_G.CountTableEntries = function(t)
		local count = 0
		if t then
			for _ in pairs(t) do
				count = count + 1
			end
		end
		return count
	end
end

if _G.GetWaypointSelectionOptions == nil then
	_G.GetWaypointSelectionOptions = function()
		local list = {}

		if _G.waypointlist ~= nil and type(_G.waypointlist) == "table" and #_G.waypointlist > 0 then
			for index, data in ipairs(_G.waypointlist) do
				list[index] = tostring(index) .. " - '" .. data.name .. "'"
			end
		end

		return list
	end
end

if _G.GetWaypointDropdownSelectionOptions == nil then
	_G.GetWaypointDropdownSelectionOptions = function(waypointSelectionOptions)
		local list = {
			"0 - [Create a New Waypoint]";
		}

		if waypointSelectionOptions ~= nil and type(waypointSelectionOptions) == "table" and #waypointSelectionOptions >= 1 then
			for index, text in ipairs(waypointSelectionOptions) do
				list[index + 1] = text
			end
		end

		return list
	end
end

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

--Repr = loadstring(dx9.Get(Config.urls.Repr))()
local ReprSettings = {
	pretty = true;              -- print with \n and indentation?
	semicolons = true;          -- when printing tables, use semicolons (;) instead of commas (,)?
	sortKeys = false;             -- when printing dictionary tables, sort keys alphabetically?
	spaces = 2;                  -- when pretty printing, use how many spaces to indent?
	Tabs = false;                -- when pretty printing, use Tabs instead of spaces?
	robloxFullName = false;      -- when printing Roblox objects, print full name or just name? 
	robloxProperFullName = false; -- when printing Roblox objects, print a proper* full name?
	robloxClassName = false;      -- when printing Roblox objects, also print class name in parens?
}

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "Universal Waypoints | dx9ware | By @Brycki";
	Size = { 500, 500 };
	Resizable = true;

	ToggleKey = Config.settings.menu_toggle_keybind;

	FooterToggle = true;
	FooterRGB = true;
	FontColor = { 255, 255, 255 };
	MainColor = { 25, 25, 25 };
	BackgroundColor = { 20, 20, 20 };
	AccentColor = { 255, 50, 255 };
	OutlineColor = { 40, 40, 40 };
})

Tabs = {
	settings = Interface:AddTab("Settings");
	waypoints = Interface:AddTab("Waypoints");
}

if _G.FirstScriptLoopRan == nil then
	_G.FirstScriptLoopRan = true
    Tabs.settings:Focus()
end

Groupboxes = {
    debug = Tabs.settings:AddMiddleGroupbox("Debugging");
	master_esp_settings = Tabs.settings:AddMiddleGroupbox("Master ESP");
	waypoints = Tabs.waypoints:AddMiddleGroupbox("Waypoints");
}

Debugging = {}
Debugging.console = Groupboxes.debug:AddToggle({
	Default = false;
	Text = "Console Enabled";
}):OnChanged(function(value)
	Lib_ui:Notify(value and "[Debug] Enabled Console" or "[Debug] Disabled Console", 1)
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
Debugging.sec = Groupboxes.debug:AddLabel("Avg. Program Cycle: ".._G.averageSec.." s")
Debugging.hz = Groupboxes.debug:AddLabel("Avg. Program Cycle: ".._G.averageHz.." Hz")
Debugging.clock = Groupboxes.debug:AddLabel("Clock: "..os.clock())
Debugging.resize = Groupboxes.debug:AddButton("Resize Window", function()
    Interface.Size = {500, 500}
    Lib_ui:Notify("Reset Window Size to 500x500", 1)
end)

Master_esp_settings = {}
Master_esp_settings.enabled = Groupboxes.master_esp_settings:AddToggle({
	Default = Config.settings.master_esp_enabled;
	Text = "Enabled";
}):OnChanged(function(value)
	Lib_ui:Notify(value and "[settings] Enabled Master ESP" or "[settings] Disabled Master ESP", 1)
end);
Master_esp_settings.tracer_type = Groupboxes.master_esp_settings:AddDropdown({
	Text = "Tracer Type";
	Default = Config.settings.tracer_type;
	Values = { "Near-Bottom", "Bottom", "Top", "Mouse" };
}):OnChanged(function(value)
	Lib_ui:Notify("[settings] Tracer Type: " .. value, 1)
end)

if _G.Get_Distance == nil then
	_G.Get_Distance = function(v1, v2)
		local a = (v1.x - v2.x) * (v1.x - v2.x)
		local b = (v1.y - v2.y) * (v1.y - v2.y)
		local c = (v1.z - v2.z) * (v1.z - v2.z)

		return math.floor(math.sqrt(a + b + c) + 0.5)
	end
end

Datamodel = dx9.GetDatamodel()
Workspace = dx9.FindFirstChild(Datamodel, "Workspace")
Services = {
	players = dx9.FindFirstChild(Datamodel, "Players");
}

Local_player = nil
Mouse = nil

if _G.Update_Mouse == nil then
	_G.Update_Mouse = function()
		Mouse = dx9.GetMouse()
	end
end

_G.Update_Mouse()

if _G.Get_Distance_From_Mouse == nil then
	_G.Get_Distance_From_Mouse = function(pos)
		_G.Update_Mouse()
		local a = (Mouse.x - pos.x) * (Mouse.x - pos.x)
		local b = (Mouse.y - pos.y) * (Mouse.y - pos.y)
		
		return math.floor(math.sqrt(a + b) + 0.5)
	end
end

Local_player_table = dx9.get_localplayer()

if Local_player == nil then
	for _, player in pairs(dx9.GetChildren(Services.players)) do
		local pgui = dx9.FindFirstChild(player, "PlayerGui")
		if pgui ~= nil and pgui ~= 0 then
			Local_player = player
			break
		end
	end
end

if Local_player == nil or Local_player == 0 then
	Local_player = Local_player_table
end

function Get_local_player_name()
	if dx9.GetType(Local_player) == "Player" then
		return dx9.GetName(Local_player)
	else
		return Local_player.Info.Name or Local_player_table.Info.Name
	end
end

Local_player_name = Get_local_player_name()

My_player = dx9.FindFirstChild(Services.players, Local_player_name)
My_character = nil
My_head = nil
My_root = nil
My_humanoid = nil

if My_player ~= nil and My_player ~= 0 then
    My_character = dx9.FindFirstChild(Workspace, Local_player_name)
end

if My_character ~= nil and My_character ~= 0 then
	My_head = dx9.FindFirstChild(My_character, "Head")
	My_root = dx9.FindFirstChild(My_character, "HumanoidRootPart")
	My_humanoid = dx9.FindFirstChild(My_character, "Humanoid")
end

function Get_local_player_position()
	if dx9.GetType(Local_player) == "Player" then
		if My_root then
			local my_root_pos = dx9.GetPosition(My_root)
			return my_root_pos
		elseif Local_player_table then
			return Local_player_table.Position
		end
	else
		return Local_player.Position or Local_player_table.Position
	end
end

Waypoints = {}
Waypoints.selector = Groupboxes.waypoints:AddDropdown({
	Index = "WaypointSelectorDropdown";
	Default = 1;
	Text = "Waypoint";
	Values = {"0 - [Create New Waypoint]"};
})
Waypoints.selector = Waypoints.selector:OnChanged(function(value)
	_G.selectedWaypointIndex = Waypoints.selector.ValueIndex - 1
	if _G.selectedWaypointIndex >= 1 and _G.selectedWaypointIndex <= #_G.waypointlist then
		local waypointdata = _G.waypointlist[selectedWaypointIndex]
		print(waypointdata or tostring(waypointdata))
		if waypointdata ~= nil and type(waypointdata) == "table" then
			local quickTools = Lib_ui.Windows["Universal Waypoints | dx9ware | By @Brycki"].Tabs["Waypoints"].Groupboxes["Waypoints"].Tools
			quickTools["WaypointNameTextBox"]:SetValue(waypointdata.name)
			quickTools["WaypointVisibleToggle"]:SetValue(waypointdata.visible)
			quickTools["WaypointColorPicker"]:SetValue(waypointdata.color)
			quickTools["WaypointTracerToggle"]:SetValue(waypointdata.tracer)
			quickTools["WaypointDistanceLimitSlider"]:SetValue(waypointdata.distance_limit)
			quickTools["WaypointNametagToggle"]:SetValue(waypointdata.nametag)
			quickTools["WaypointDistanceToggle"]:SetValue(waypointdata.distance)
			Lib_ui:Notify("[Waypoints] Selected Waypoint: "..tostring(value).." - '"..waypointdata.name.."'", 1)
		end
	end
end)
_G.selectedWaypointIndex = Waypoints.selector.ValueIndex - 1

if _G.selectedWaypointIndex >= 1 and _G.selectedWaypointIndex <= #_G.waypointlist then
	local waypointdata = _G.waypointlist[_G.selectedWaypointIndex]
	Groupboxes.waypoints:AddLabel("Position: { x: "..tostring(math.floor(waypointdata.position.x)).." , y: "..tostring(math.floor(waypointdata.position.y).." , z: "..tostring(math.floor(waypointdata.position.z)).." }"))
else
	local my_root_pos = Get_local_player_position()
	if my_root_pos ~= nil and type(my_root_pos) == "table" and my_root_pos.x and my_root_pos.y and my_root_pos.z then
		Groupboxes.waypoints:AddLabel("Position: { x: "..tostring(math.floor(my_root_pos.x)).." , y: "..tostring(math.floor(my_root_pos.y).." , z: "..tostring(math.floor(my_root_pos.z)).." }"))
	end
end

Groupboxes.waypoints:AddTitle("Waypoint Settings")
Waypoints.nametextbox = Groupboxes.waypoints:AddTextBox({
	Index = "WaypointNameTextBox";
	Placeholder = "Name";
	Default = "New Waypoint";
})
Waypoints.visible = Groupboxes.waypoints:AddToggle({
	Index = "WaypointVisibleToggle";
	Default = true;
	Text = "ESP Visible";
})
Waypoints.color = Groupboxes.waypoints:AddColorPicker({
	Index = "WaypointColorPicker";
	Default = {255, 255, 255};
	Text = "ESP Color";
})
Waypoints.tracer = Groupboxes.waypoints:AddToggle({
	Index = "WaypointTracerToggle";
	Default = false;
	Text = "Tracer";
})
Waypoints.distance_limit = Groupboxes.waypoints:AddSlider({
	Index = "WaypointDistanceLimitSlider";
	Default = 9999;
	Text = "ESP Distance Limit";
	Min = 1;
	Max = 9999;
	Rounding = 0;
})
Waypoints.nametag = Groupboxes.waypoints:AddToggle({
	Index = "WaypointNametagToggle";
	Default = true;
	Text = "ESP Nametag Visible";
})
Waypoints.distance = Groupboxes.waypoints:AddToggle({
	Index = "WaypointDistanceToggle";
	Default = true;
	Text = "ESP Distance Visible";
})
Groupboxes.waypoints:AddTitle("Functions")
Waypoints.savewaypoint = Groupboxes.waypoints:AddButton("Save Waypoint Settings", function()
	if _G.selectedWaypointIndex >= 1 and _G.selectedWaypointIndex <= #_G.waypointlist then
		local waypointdata = _G.waypointlist[_G.selectedWaypointIndex]

		waypointdata.name = Waypoints.nametextbox:GetValue()
		waypointdata.visible = Waypoints.visible.Value
		waypointdata.color = Waypoints.color ~= nil and Waypoints.color.Value or nil
		waypointdata.tracer = Waypoints.tracer ~= nil and Waypoints.tracer.Value or nil
		waypointdata.distance_limit = Waypoints.distance_limit ~= nil and Waypoints.distance_limit.Value or nil
		waypointdata.nametag = Waypoints.nametag ~= nil and Waypoints.nametag.Value or nil
		waypointdata.distance = Waypoints.distance ~= nil and Waypoints.distance.Value or nil

		_G.waypointlist[_G.selectedWaypointIndex] = waypointdata
	else
		local newwaypointdata = {}

		local my_root_pos = Get_local_player_position()
		newwaypointdata.position = my_root_pos
		newwaypointdata.name = Waypoints.nametextbox:GetValue()
		newwaypointdata.visible = Waypoints.visible.Value
		newwaypointdata.color = Waypoints.color ~= nil and Waypoints.color.Value or nil
		newwaypointdata.tracer = Waypoints.tracer ~= nil and Waypoints.tracer.Value or nil
		newwaypointdata.distance_limit = Waypoints.distance_limit ~= nil and Waypoints.distance_limit.Value or nil
		newwaypointdata.nametag = Waypoints.nametag ~= nil and Waypoints.nametag.Value or nil
		newwaypointdata.distance = Waypoints.distance ~= nil and Waypoints.distance.Value or nil

		table.insert(_G.waypointlist, newwaypointdata)
	end

	local waypointSelectionOptions = _G.GetWaypointSelectionOptions()
	local waypointDropdownSelectionOptions = _G.GetWaypointDropdownSelectionOptions(waypointSelectionOptions)

	Waypoints.selector:SetValues(waypointDropdownSelectionOptions)
end)
Waypoints.teleporttowaypoint = Groupboxes.waypoints:AddButton("Teleport to Waypoint", function()
	if _G.selectedWaypointIndex >= 1 and _G.selectedWaypointIndex <= #_G.waypointlist then
		local waypointdata = _G.waypointlist[_G.selectedWaypointIndex]
		local positiondata = waypointdata.position
		dx9.Teleport(My_character, {positiondata.x, positiondata.y, positiondata.z})
	end
end)
Waypoints.deletewaypoint = Groupboxes.waypoints:AddButton("Delete Waypoint", function()
	if _G.selectedWaypointIndex >= 1 and _G.selectedWaypointIndex <= #_G.waypointlist then
		table.remove(_G.waypointlist, _G.selectedWaypointIndex)

		_G.selectedWaypointIndex = 1
		Waypoints.selector:SetValue(1)
		_G.selectedWaypointIndex = 1

		local waypointSelectionOptions = _G.GetWaypointSelectionOptions()
		local waypointDropdownSelectionOptions = _G.GetWaypointDropdownSelectionOptions(waypointSelectionOptions)

		Waypoints.selector:SetValues(waypointDropdownSelectionOptions)
	end
end)

Screen_size = nil

if _G.IsOnScreen == nil then
	_G.IsOnScreen = function(screen_pos)
		Screen_size = dx9.size()
		if screen_pos and screen_pos ~= 0 and screen_pos.x > 0 and screen_pos.y > 0 and screen_pos.x < Screen_size.width and screen_pos.y < Screen_size.height then
			return true
		end
		return false
	end
end

if not Master_esp_settings.enabled.Value then
	return
end

if _G.WaypointTask == nil then
	_G.WaypointTask = function()
		for index, data in ipairs(_G.waypointlist) do
			if data.visible then
				local my_root_pos = Get_local_player_position()
				local pos = data.position
				local distance = _G.Get_Distance(my_root_pos, pos) or 0
				local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
				
				local isOnScreen = _G.IsOnScreen(screen_pos) and true or false
				local isInRange = distance < data.distance_limit and true or false
				if isOnScreen then
					if isInRange then
						Lib_esp.ground_circle({
							position = pos,
							color = data.color,
							nametag = data.nametag,
							custom_nametag = data.name,
							distance = data.distance,
							custom_distance = distance,
							tracer = data.tracer,
							tracer_type = Master_esp_settings.tracer_type.ValueIndex
						})
					end
				end
			end
		end
	end
end
if _G.WaypointTask then
	_G.WaypointTask()
end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= Config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end