--indent size 4
local startTime = os.clock()

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
        repr = "https://raw.githubusercontent.com/Ozzypig/repr/refs/heads/master/repr.lua"
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
if _G.config == nil then
	_G.config = config
	config = _G.config
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

		for index, data in ipairs(_G.waypointlist) do
			list[index] = tostring(index) .. " - '" .. data.name .. "'"
		end

		return list
	end
end

if _G.GetWaypointDropdownSelectionOptions == nil then
	_G.GetWaypointDropdownSelectionOptions = function(waypointSelectionOptions)
		local list = {
			[1] = "0 - [Create a New Waypoint]";
		}

		if type(waypointSelectionOptions) == "table" then
			for index, text in ipairs(waypointSelectionOptions) do
				list[index + 1] = text
			end
		end

		return list
	end
end

repr = loadstring(dx9.Get(config.urls.repr))()

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

lib_esp = loadstring(dx9.Get(config.urls.LibESP))()

interface = lib_ui:CreateWindow({
	Title = "Waypoints | dx9ware | By @Brycki";
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

tabs = {
	settings = interface:AddTab("Settings");
	waypoints = interface:AddTab("Waypoints");
}

if lib_ui.FirstRun then
    tabs.settings:Focus()
end

groupboxes = {
    debug = tabs.settings:AddMiddleGroupbox("Debugging");
	master_esp_settings = tabs.settings:AddMiddleGroupbox("Master ESP");
	waypoints = tabs.waypoints:AddMiddleGroupbox("Waypoints");
}

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
debugging.resize = groupboxes.debug:AddButton("Resize Window", function()
    interface.Size = {500, 500}
    lib_ui:Notify("Reset Window Size to 500x500", 1)
end)

master_esp_settings = {}
master_esp_settings.enabled = groupboxes.master_esp_settings:AddToggle({
	Default = config.settings.master_esp_enabled;
	Text = "Enabled";
}):OnChanged(function(value)
	lib_ui:Notify(value and "[settings] Enabled Master ESP" or "[settings] Disabled Master ESP", 1)
end);
master_esp_settings.tracer_type = groupboxes.master_esp_settings:AddDropdown({
	Text = "Tracer Type";
	Default = config.settings.tracer_type;
	Values = { "Near-Bottom", "Bottom", "Top", "Mouse" };
}):OnChanged(function(value)
	lib_ui:Notify("[settings] Tracer Type: " .. value, 1)
end)

if _G.Get_Distance == nil then
	_G.Get_Distance = function(v1, v2)
		local a = (v1.x - v2.x) * (v1.x - v2.x)
		local b = (v1.y - v2.y) * (v1.y - v2.y)
		local c = (v1.z - v2.z) * (v1.z - v2.z)

		return math.floor(math.sqrt(a + b + c) + 0.5)
	end
end

datamodel = dx9.GetDatamodel()
workspace = dx9.FindFirstChild(datamodel, "Workspace")
services = {
	players = dx9.FindFirstChild(datamodel, "Players");
}

local reprSettings = {
	pretty = true;              -- print with \n and indentation?
	semicolons = true;          -- when printing tables, use semicolons (;) instead of commas (,)?
	sortKeys = false;             -- when printing dictionary tables, sort keys alphabetically?
	spaces = 2;                  -- when pretty printing, use how many spaces to indent?
	tabs = false;                -- when pretty printing, use tabs instead of spaces?
	robloxFullName = false;      -- when printing Roblox objects, print full name or just name? 
	robloxProperFullName = false; -- when printing Roblox objects, print a proper* full name?
	robloxClassName = false;      -- when printing Roblox objects, also print class name in parens?
}

local_player = nil
mouse = nil

if _G.Update_Mouse == nil then
	_G.Update_Mouse = function()
		mouse = dx9.GetMouse()
	end
end

_G.Update_Mouse()

if _G.Get_Distance_From_Mouse == nil then
	_G.Get_Distance_From_Mouse = function(pos)
		_G.Update_Mouse()
		local a = (mouse.x - pos.x) * (mouse.x - pos.x)
		local b = (mouse.y - pos.y) * (mouse.y - pos.y)
		
		return math.floor(math.sqrt(a + b) + 0.5)
	end
end

current_tracer_type = master_esp_settings.tracer_type.ValueIndex

local_player_table = dx9.get_localplayer()

if local_player == nil then
	for _, player in pairs(dx9.GetChildren(services.players)) do
		local pgui = dx9.FindFirstChild(player, "PlayerGui")
		if pgui ~= nil and pgui ~= 0 then
			local_player = player
			break
		end
	end
end

if local_player == nil or local_player == 0 then
	local_player = local_player_table
end

function get_local_player_name()
	if dx9.GetType(local_player) == "Player" then
		return dx9.GetName(local_player)
	else
		return local_player.Info.Name or local_player_table.Info.Name
	end
end

local_player_name = get_local_player_name()

my_player = dx9.FindFirstChild(services.players, local_player_name)
my_character = nil
my_head = nil
my_root = nil
my_humanoid = nil

if my_player ~= nil and my_player ~= 0 then
    my_character = dx9.FindFirstChild(workspace, local_player_name)
end

if my_character ~= nil and my_character ~= 0 then
	my_head = dx9.FindFirstChild(my_character, "Head")
	my_root = dx9.FindFirstChild(my_character, "HumanoidRootPart")
	my_humanoid = dx9.FindFirstChild(my_character, "Humanoid")
end

function get_local_player_position()
	if dx9.GetType(local_player) == "Player" then
		if my_root then
			local my_root_pos = dx9.GetPosition(my_root)
			return my_root_pos
		elseif local_player_table then
			return local_player_table.Position
		end
	else
		return local_player.Position or local_player_table.Position
	end
end

waypoints = {}
waypoints.selector = groupboxes.waypoints:AddDropdown({
	Text = "Select a Waypoint";
	Default = 1;
	Values = {"0 - [Create a New Waypoint]"};
}):OnChanged(function(value)
	lib_ui:Notify("[waypoints] Selected Waypoint: "..value, 1)
end)
local waypointlistindex = waypoints.selector.ValueIndex and waypoints.selector.ValueIndex - 1 or 1
if waypoints.selector.ValueIndex and waypoints.selector.ValueIndex > 1 and waypointlistindex > 0 and waypointlistindex <= #_G.waypointlist then
	local waypointdata = _G.waypointlist[waypointlistindex]

	groupboxes.waypoints:AddLabel("Position: { x: "..tostring(math.floor(waypointdata.position.x)).." , y: "..tostring(math.floor(waypointdata.position.y).." , z: "..tostring(math.floor(waypointdata.position.z)).." }"))
	
	groupboxes.waypoints:AddTitle("Waypoint Settings")
	waypoints.nametextbox = groupboxes.waypoints:AddTextBox({
		Index = "WaypointNameTextBox";
		Placeholder = "Name";
		Default = waypointdata.name;
	}):AddTooltip("The name of the waypoint")
	waypoints.visible = groupboxes.waypoints:AddToggle({
		Default = waypointdata.visible;
		Text = "ESP Visible";
	})
	if waypoints.visible.Value then
		waypoints.color = groupboxes.waypoints:AddColorPicker({
			Default = waypointdata.color;
			Text = "ESP Color";
		}):AddTooltip("The color of the waypoint")
		waypoints.tracer = groupboxes.waypoints:AddToggle({
			Default = waypointdata.tracer;
			Text = "Tracer";
		}):AddTooltip("Whether or not this waypoint has a tracer showing you to it")
		waypoints.distance_limit = groupboxes.waypoints:AddSlider({
			Default = waypointdata.distance_limit;
			Text = "ESP Distance Limit";
			Min = 0;
			Max = 10000;
			Rounding = 0;
		}):AddTooltip("How far away a waypoint must be for it to not show")
		waypoints.nametag = groupboxes.waypoints:AddToggle({
			Default = waypointdata.nametag;
			Text = "ESP Nametag Visible";
		}):AddTooltip("Whether or not the nametag is displayed on this waypoint")
		if waypoints.nametag.Value then
			waypoints.distance = groupboxes.waypoints:AddToggle({
				Default = waypointdata.distance;
				Text = "ESP Distance Visible";
			}):AddTooltip("Whether or not the distance is displayed on this waypoint")
		end
	end
else
	local my_root_pos = get_local_player_position()
	groupboxes.waypoints:AddLabel("Position: { x: "..tostring(math.floor(my_root_pos.x)).." , y: "..tostring(math.floor(my_root_pos.y).." , z: "..tostring(math.floor(my_root_pos.z)).." }"))
	
	groupboxes.waypoints:AddTitle("Waypoint Settings")
	waypoints.nametextbox = groupboxes.waypoints:AddTextBox({
		Index = "WaypointNameTextBox";
		Placeholder = "Name";
		Default = "New Waypoint";
	}):AddTooltip("The name of the waypoint")
	waypoints.visible = groupboxes.waypoints:AddToggle({
		Default = true;
		Text = "ESP Visible";
	})
	if waypoints.visible.Value then
		waypoints.color = groupboxes.waypoints:AddColorPicker({
			Default = {255, 255, 255};
			Text = "ESP Color";
		})
		waypoints.tracer = groupboxes.waypoints:AddToggle({
			Default = false;
			Text = "Tracer";
		}):AddTooltip("Whether or not this waypoint has a tracer showing you to it")
		waypoints.distance_limit = groupboxes.waypoints:AddSlider({
			Default = 10000;
			Text = "ESP Distance Limit";
			Min = 0;
			Max = 10000;
			Rounding = 0;
		}):AddTooltip("How far away a waypoint must be for it to not show")
		waypoints.nametag = groupboxes.waypoints:AddToggle({
			Default = true;
			Text = "ESP Nametag Visible";
		}):AddTooltip("Whether or not the nametag is displayed on this waypoint")
		if waypoints.nametag.Value then
			waypoints.distance = groupboxes.waypoints:AddToggle({
				Default = true;
				Text = "ESP Distance Visible";
			}):AddTooltip("Whether or not the distance is displayed on this waypoint")
		end
	end
end

groupboxes.waypoints:AddTitle("Functions")
waypoints.savewaypoint = groupboxes.waypoints:AddButton("Save Waypoint Settings", function()
	print(tostring(waypoints.selector.ValueIndex))
	if waypoints.selector.ValueIndex and waypoints.selector.ValueIndex > 1 then
		local waypointlistindex = waypoints.selector.ValueIndex - 1
		local waypointdata = _G.waypointlist[waypointlistindex]

		waypointdata.name = waypoints.nametextbox:GetValue()
		waypointdata.visible = waypoints.visible.Value
		waypointdata.color = waypoints.color and waypoints.color.Value or nil
		waypointdata.tracer = waypoints.tracer and waypoints.tracer.Value or nil
		waypointdata.nametag = waypoints.nametag and waypoints.nametag.Value or nil
		waypointdata.distance = waypoints.distance and waypoints.distance.Value or nil

		_G.waypointlist[waypointlistindex] = waypointdata
	else
		local newwaypointdata = {}

		local my_root_pos = get_local_player_position()
		newwaypointdata.position = my_root_pos
		newwaypointdata.name = waypoints.nametextbox:GetValue()
		newwaypointdata.visible = waypoints.visible.Value
		newwaypointdata.color = waypoints.color and waypoints.color.Value or nil
		newwaypointdata.tracer = waypoints.tracer and waypoints.tracer.Value or nil
		newwaypointdata.nametag = waypoints.nametag and waypoints.nametag.Value or nil
		newwaypointdata.distance = waypoints.distance and waypoints.distance.Value or nil

		table.insert(_G.waypointlist, newwaypointdata)
	end

	local newSelectionOptions = _G.GetWaypointSelectionOptions()
	local newDropdownOptions = _G.GetWaypointDropdownSelectionOptions(newSelectionOptions)

	waypoints.selector:Hide()
	waypoints.selector:SetValues(newDropdownOptions)

	print(repr(waypoints.selector.Values, reprSettings))
end)
if waypoints.selector.ValueIndex then
	if waypoints.selector.ValueIndex > 1 then
		waypoints.teleporttowaypoint = groupboxes.waypoints:AddButton("Teleport to Waypoint", function()
			if waypoints.selector.ValueIndex then
				if waypoints.selector.ValueIndex > 1 then
					local waypointlistindex = waypoints.selector.ValueIndex - 1
					local waypointdata = _G.waypointlist[waypointlistindex]
					local positiondata = waypointdata.position
					waypoints.selector:Hide()
					dx9.Teleport(my_character, {positiondata.x, positiondata.y, positiondata.z})
				end
			end
		end)
		waypoints.deletewaypoint = groupboxes.waypoints:AddButton("Delete Waypoint", function()
			if waypoints.selector.ValueIndex then
				if waypoints.selector.ValueIndex > 1 then
					local waypointlistindex = waypoints.selector.ValueIndex - 1
					table.remove(_G.waypointlist, waypointlistindex)

					local newSelectionOptions = _G.GetWaypointSelectionOptions()
					local newDropdownOptions = _G.GetWaypointDropdownSelectionOptions(newSelectionOptions)

					waypoints.selector:Hide()
					waypoints.selector:SetValue(1)
					waypoints.selector:SetValues(newDropdownOptions)
					waypoints.selector:SetValue(1)
				end
			end
		end)
	end
end

screen_size = nil

if _G.IsOnScreen == nil then
	_G.IsOnScreen = function(screen_pos)
		screen_size = dx9.size()
		if screen_pos and screen_pos ~= 0 and screen_pos.x > 0 and screen_pos.y > 0 and screen_pos.x < screen_size.width and screen_pos.y < screen_size.height then
			return true
		end
		return false
	end
end

if not master_esp_settings.enabled.Value then
	return
end

if _G.WaypointTask == nil then
	_G.WaypointTask = function()
		for index, data in ipairs(_G.waypointlist) do
			if data.visible then
				local skipThis = true

				if skipThis == true then
					if data.visible then
						skipThis = false
					end
				end

				if not skipThis then
					local my_root_pos = get_local_player_position()
					local pos = data.position
					local distance = _G.Get_Distance(my_root_pos, pos)
					local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
					
					if _G.IsOnScreen(screen_pos) then
						if distance < scrap.distance_limit.Value then
							lib_esp.ground_circle({
								position = {pos.x, pos.y, pos.z},
								color = scrap.color.Value,
								nametag = scrap.nametag.Value,
								custom_nametag = data.name,
								distance = scrap.distance.Value,
								custom_distance = distance,
								tracer = scrap.tracer.Value,
								tracer_type = current_tracer_type
							})
						end
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
	if #_G.lastElapsedCycleTimesCache >= config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end