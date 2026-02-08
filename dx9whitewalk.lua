--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines

local startTime = os.clock()

Config = _G.Config or {
    settings = {
		menu_toggle_keybind = "[F2]";

        maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;

        cache_cleanup_timer = 3;
        master_esp_enabled = true;
    	box_type = 1; -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    };
    players = {
        enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
        color = { 255, 255, 255 };
		distance_limit = math.huge;
    };
	pylons = {
		enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
        color = { 255, 0, 0 };
		distance_limit = math.huge;
	};
	objects = {
        enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
        color = { 0, 255, 0 };
		distance_limit = math.huge;
    };
};
Config.urls = {
    DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
    LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
    repr = "https://raw.githubusercontent.com/Ozzypig/repr/refs/heads/master/repr.lua"
};
_G.Config = Config
Config = _G.Config

if _G.selectedWaypointIndex == nil then
	_G.selectedWaypointIndex = 0
end

if _G.waypointlist == nil then
    _G.waypointlist = {
        -- {
		--     position = my_root_pos;
        --     name = "";
        --     visible = Waypoints.visible.Value;
        --     color = Waypoints.color ~= nil and Waypoints.color.Value or nil;
        --     tracer = Waypoints.tracer ~= nil and Waypoints.tracer.Value or nil;
        --     distance_limit = Waypoints.distance_limit ~= nil and Waypoints.distance_limit.Value or nil;
        --     nametag = Waypoints.nametag ~= nil and Waypoints.nametag.Value or nil;
        --     newwaypointdata.distance = Waypoints.distance ~= nil and Waypoints.distance.Value or nil;
        -- };
    }
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

repr = loadstring(dx9.Get(Config.urls.repr))()
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

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "WHITEWALK | dx9ware | By @Brycki";
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
    players = Interface:AddTab("Players");
    pylons = Interface:AddTab("Pylons");
    objects = Interface:AddTab("Objects");
    waypoints = Interface:AddTab("Waypoints");
}

if _G.FirstScriptLoopRan == nil then
	_G.FirstScriptLoopRan = true
    Tabs.settings:Focus()
end

Groupboxes = {
    debug = Tabs.settings:AddMiddleGroupbox("Debugging");
	master_esp_settings = Tabs.settings:AddMiddleGroupbox("Master ESP");
    players = Tabs.players:AddMiddleGroupbox("Players");
	pylons = Tabs.pylons:AddMiddleGroupbox("Pylons");
	objects = Tabs.objects:AddMiddleGroupbox("Objects");
    waypoints = Tabs.waypoints:AddMiddleGroupbox("Waypoints");
}

---------------------------------------
-- DEBUGGING
---------------------------------------
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
Debugging.resize_keybind = Groupboxes.debug:AddKeybindButton({
    Index = "ResizeWindowKeybindButton";
    Text = "Resize Window Keybind: [F3]";
    Default = "[F3]";
})
Debugging.resize_keybind = Debugging.resize_keybind:OnChanged(function(newKey)
    local oldKey = Debugging.resize_keybind.Key
    Debugging.resize_keybind:SetText("Resize Window Keybind: "..tostring(newKey))
    Lib_ui:Notify("Resize Window Keybind changed from '"..tostring(oldKey).."' to '"..tostring(newKey).."'", 1)
end)
Debugging.resize = Groupboxes.debug:AddButton("Resize Window", function()
    if Interface.Active then
        Interface.Size = {300, 300}
        Lib_ui:Notify("Reset Window Size to the minimum", 1)
    end
end)
Debugging.resize:ConnectKeybindButton(Debugging.resize_keybind)

---------------------------------------
-- MASTER ESP SETTINGS
---------------------------------------
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
end);
Master_esp_settings.box_type = Groupboxes.master_esp_settings:AddDropdown({
    Text = "Box Type";
    Default = Config.settings.box_type;
    Values = { "Corners", "2D Box", "3D Box" };
}):OnChanged(function(value)
    Lib_ui:Notify("[settings] Box Type: " .. value, 1)
end);

if _G.Get_Distance == nil then
	_G.Get_Distance = function(v1, v2)
		local a = (v1.x - v2.x) * (v1.x - v2.x)
		local b = (v1.y - v2.y) * (v1.y - v2.y)
		local c = (v1.z - v2.z) * (v1.z - v2.z)

		return math.floor(math.sqrt(a + b + c) + 0.5)
	end
end

----------------------------------------
-- PLAYERS
----------------------------------------
Players = {}
Players.enabled = Groupboxes.players:AddToggle({
    Default = Config.players.enabled;
    Text = "Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[players] Enabled ESP" or "[players] Disabled ESP", 1)
end);
Players.distance = Groupboxes.players:AddToggle({
    Default = Config.players.distance;
    Text = "Distance";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[players] Enabled Distance" or "[players] Disabled Distance", 1)
end);
Players.nametag = Groupboxes.players:AddToggle({
    Default = Config.players.nametag;
    Text = "Nametag";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[players] Enabled Nametag" or "[players] Disabled Nametag", 1)
end);
Players.tracer = Groupboxes.players:AddToggle({
    Default = Config.players.tracer;
    Text = "Tracer";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[players] Enabled Tracer" or "[players] Disabled Tracer", 1)
end);
Players.distance_limit = Groupboxes.players:AddSlider({
    Default = Config.players.distance_limit;
    Text = "ESP Distance Limit";
    Min = 0;
    Max = 2500000;
    Rounding = 50;
});

-------------------------------------
-- PYLONS
-------------------------------------
Pylons = {}
Pylons.enabled = Groupboxes.pylons:AddToggle({
    Default = Config.pylons.enabled;
    Text = "Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[pylons] Enabled ESP" or "[pylons] Disabled ESP", 1)
end);
Pylons.distance = Groupboxes.pylons:AddToggle({
    Default = Config.pylons.distance;
    Text = "Distance";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[pylons] Enabled Distance" or "[pylons] Disabled Distance", 1)
end);
Pylons.nametag = Groupboxes.pylons:AddToggle({
    Default = Config.pylons.nametag;
    Text = "Nametag";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[pylons] Enabled Nametag" or "[pylons] Disabled Nametag", 1)
end);
Pylons.tracer = Groupboxes.pylons:AddToggle({
    Default = Config.pylons.tracer;
    Text = "Tracer";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[pylons] Enabled Tracer" or "[pylons] Disabled Tracer", 1)
end);
Pylons.distance_limit = Groupboxes.pylons:AddSlider({
    Default = Config.pylons.distance_limit;
    Text = "ESP Distance Limit";
    Min = 0;
    Max = 2500000;
    Rounding = 50;
});

-------------------------------------
-- OBJECTS
-------------------------------------
Objects = {}
Objects.enabled = Groupboxes.objects:AddToggle({
    Default = Config.objects.enabled;
    Text = "Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[objects] Enabled ESP" or "[objects] Disabled ESP", 1)
end);
Objects.distance = Groupboxes.objects:AddToggle({
    Default = Config.objects.distance;
    Text = "Distance";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[objects] Enabled Distance" or "[objects] Disabled Distance", 1)
end);
Objects.nametag = Groupboxes.objects:AddToggle({
    Default = Config.objects.nametag;
    Text = "Nametag";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[objects] Enabled Nametag" or "[objects] Disabled Nametag", 1)
end);
Objects.tracer = Groupboxes.objects:AddToggle({
    Default = Config.objects.tracer;
    Text = "Tracer";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[objects] Enabled Tracer" or "[objects] Disabled Tracer", 1)
end);
Objects.distance_limit = Groupboxes.objects:AddSlider({
    Default = Config.objects.distance_limit;
    Text = "ESP Distance Limit";
    Min = 0;
    Max = 2500000;
    Rounding = 50;
});

--------------------------------------
-- WAYPOINTS
--------------------------------------
dx9.ShowConsole(true)
Waypoints = {}
Waypoints.selector = Groupboxes.waypoints:AddDropdown({
	Index = "WaypointSelectorDropdown";
	Default = 1;
	Text = "Waypoint";
	Values = {"0 - [Create New Waypoint]"};
})
print("Here 1")
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
print("Here 2")
_G.selectedWaypointIndex = Waypoints.selector.ValueIndex - 1
print("Here 3")
if _G.selectedWaypointIndex >= 1 and _G.selectedWaypointIndex <= #_G.waypointlist then
    print("Waypoint Data: "..repr(_G.waypointlist[_G.selectedWaypointIndex], ReprSettings))
	local waypointdata = _G.waypointlist[_G.selectedWaypointIndex]
	Groupboxes.waypoints:AddLabel("Position: { x: "..tostring(math.floor(waypointdata.position.x)).." , y: "..tostring(math.floor(waypointdata.position.y)).." , z: "..tostring(math.floor(waypointdata.position.z)).." }")
else
    print("No Waypoint Selected, showing local player position instead")
	local my_root_pos = Get_local_player_position()
	if my_root_pos ~= nil and type(my_root_pos) == "table" and my_root_pos.x and my_root_pos.y and my_root_pos.z then
		Groupboxes.waypoints:AddLabel("Position: { x: "..tostring(math.floor(my_root_pos.x)).." , y: "..tostring(math.floor(my_root_pos.y)).." , z: "..tostring(math.floor(my_root_pos.z)).." }")
	end
end
print("Here 4")
Groupboxes.waypoints:AddTitle("Waypoint Settings")
Groupboxes.waypoints:AddLabel("Text Boxes do not yet have a cursor, so when typing, follow the instructions below:")
Groupboxes.waypoints:AddLabel("[LEFT SHIFT] and [RIGHT SHIFT] to toggle capslock")
Groupboxes.waypoints:AddLabel("[SUBTRACT] on your NumPad to type dashes and underscores")
Groupboxes.waypoints:AddLabel("[ENTER/RETURN] to stop typing")
Groupboxes.waypoints:AddLabel("[SPACEBAR] to type a space")
Groupboxes.waypoints:AddLabel("[BACKSPACE] to delete the last character")
Waypoints.nametextbox = Groupboxes.waypoints:AddTextBox({
	Index = "WaypointNameTextBox";
	Placeholder = "Name";
	Default = "New Waypoint";
})
Groupboxes.waypoints:AddLabel(Waypoints.nametextbox.Capslock and "Capslock: ENABLED" or "Capslock: DISABLED", Waypoints.nametextbox.Capslock and {0, 255, 0} or {255, 0, 0})
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

if _G.Get_Index == nil then
	_G.Get_Index = function(type, value)
		local table = nil
		if type == "tracer" then
			table = { "Near-Bottom", "Bottom", "Top", "Mouse" }
		elseif type == "box" then
			table = { "Corners", "2D Box", "3D Box" }
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

Current_tracer_type = _G.Get_Index("tracer", Master_esp_settings.tracer_type.Value)
Current_box_type = _G.Get_Index("box", Master_esp_settings.box_type.Value)

Datamodel = dx9.GetDatamodel()
Workspace = dx9.FindFirstChild(Datamodel, "Workspace")
PapersFolder = dx9.FindFirstChild(Workspace, "Papers")
PylonsFolder = dx9.FindFirstChild(Workspace, "Pylons")
ObjectsFolder = dx9.FindFirstChild(Workspace, "Objects")
Services = {
	players = dx9.FindFirstChild(Datamodel, "Players");
}

Local_player_table = dx9.get_localplayer()
for _, player in ipairs(dx9.GetChildren(Services.players)) do
	local pgui = dx9.FindFirstChildOfClass(player, "PlayerGui")
	if pgui ~= nil and pgui ~= 0 then
		Local_player = player
		break
	end
end

function Get_local_player_name()
	if type(Local_player_table) == "table" then
		return Local_player_table.Info.Name
	elseif type(Local_player) == "number" and dx9.GetType(Local_player) == "Player" then
		return dx9.GetName(Local_player)
	else
		print("WARNING | Get_local_player_name returned nil")
		return nil
	end
end

Local_player_name = Local_player_name ~= nil and Local_player_name or Local_player_name == nil and Get_local_player_name()

My_player = Local_player or dx9.FindFirstChild(Services.players, Local_player_name)

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

if My_player ~= nil and My_player ~= 0 then
    My_character = dx9.FindFirstChild(Workspace, Local_player_name)
end

if My_character ~= nil and My_character ~= 0 then
	My_head = dx9.FindFirstChild(My_character, "Head")
	My_root = dx9.FindFirstChild(My_character, "HumanoidRootPart")
	My_humanoid = dx9.FindFirstChild(My_character, "Humanoid")
end

if not _G.Get_local_player_position then
    _G.Get_local_player_position = function()
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
end

if _G.IsOnScreen == nil then
	_G.IsOnScreen = function(screen_pos)
		Screen_size = dx9.size()
		if screen_pos and screen_pos ~= 0 and screen_pos.x > 0 and screen_pos.y > 0 and screen_pos.x < Screen_size.width and screen_pos.y < Screen_size.height then
			return true
		end
		return false
	end
end

if _G.CleanCacheTimeout == nil then
	_G.CleanCacheTimeout = 3
end

if _G.PlayerCache == nil then
	_G.PlayerCache = {}
else
	for i, cached_tab in pairs(_G.PlayerCache) do
		if not cached_tab.last_update or (os.clock() - cached_tab.last_update) > _G.CleanCacheTimeout then
			_G.PlayerCache[i] = nil
		end
	end
end

if _G.PlayerTask == nil then
	_G.PlayerTask = function()
		if Players.enabled.Value and Master_esp_settings.enabled.Value then
			for _, player in ipairs(dx9.GetChildren(Services.players)) do
				local cached_tab = _G.PlayerCache[tostring(player)]
				if not cached_tab then
					local playerName = dx9.GetName(player)
					if playerName and type(playerName) == "string" and playerName ~= "" and playerName ~= Local_player_name then
						_G.PlayerCache[tostring(player)] = {
							player = player;
							playerName = playerName;
							last_update = os.clock();
						}
					end
				end
				if cached_tab then
					local character = dx9.FindFirstChild(Workspace, cached_tab.playerName)
					if character and character ~= 0 then
						local root = dx9.FindFirstChild(character, "HumanoidRootPart")
						local humanoid = dx9.FindFirstChild(character, "Humanoid")

						if root and root ~= 0 and humanoid and humanoid ~= 0 then
							local my_root_pos = My_root ~= nil and My_root ~= 0 and dx9.GetPosition(My_root) or {x=0, y=0, z=0}
							local root_pos = dx9.GetPosition(root)
							local root_distance = _G.Get_Distance(my_root_pos, root_pos)
							local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})

							local screen_pos = root_screen_pos

							if _G.IsOnScreen(screen_pos) then								
                                if root_distance < Players.distance_limit.Value then
                                    Lib_esp.draw({
                                        target = character,
                                        color = Config.players.color,
                                        healthbar = false,
                                        nametag = Players.nametag.Value,
                                        custom_nametag = cached_tab.playerName,
                                        distance = My_root ~= nil and My_root ~= 0 and Players.distance.Value or false,
                                        custom_distance = ""..root_distance,
                                        tracer = Players.tracer.Value,
                                        tracer_type = Current_tracer_type,
                                        box_type = Current_box_type,
                                    })
                                    _G.PlayerCache[tostring(player)].last_update = os.clock()
                                end
							end
						end
					end
				end
			end
		end
	end
end
if _G.PlayerTask then
	_G.PlayerTask()
end

if _G.PylonCache == nil then
	_G.PylonCache = {}
end

if _G.PylonTask == nil then
	_G.PylonTask = function()
		if Pylons.enabled.Value and Master_esp_settings.enabled.Value then
			for _, pylonModel in ipairs(dx9.GetChildren(PylonsFolder)) do
                local memadd = tostring(pylonModel)
				local cached_tab = _G.PylonCache[memadd]
				if not cached_tab then
                    local pylonName = dx9.GetName(pylonModel)
					if pylonName and type(pylonName) == "string" and pylonName ~= "" then
                        local gemModel = nil;
                        local mainPart = nil;
                        local pos = nil;
                        gemModel = dx9.FindFirstChild(pylonModel, "Gem")
                        if not gemModel or gemModel == 0 then gemModel = nil end
                        if gemModel and gemModel ~= 0 then
                            mainPart = dx9.FindFirstChild(gemModel, "Main")
                            if not mainPart or mainPart == 0 then mainPart = nil end
                            if mainPart and mainPart ~= 0 then
                                pos = dx9.GetPosition(mainPart)
                            end
                        end
						_G.PylonCache[memadd] = {
                            pylonModel = pylonModel;
                            mainPart = mainPart;
                            pos = pos;
							pylonName = pylonName;
						}
					end
				end
				if cached_tab then
                    local mainPart = cached_tab.mainPart
                    local name = cached_tab.pylonName
                    local root_pos = cached_tab.pos

                    if mainPart and mainPart ~= 0 then
                        local my_root_pos = My_root ~= nil and My_root ~= 0 and dx9.GetPosition(My_root) or {x=0, y=0, z=0}
                        local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                        local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})

                        local screen_pos = root_screen_pos

                        if _G.IsOnScreen(screen_pos) then			
                            if root_distance < Pylons.distance_limit.Value then
                                Lib_esp.draw({
                                    esp_type = "misc",
                                    target = mainPart,
                                    color = Config.pylons.color,
                                    healthbar = false,
                                    nametag = Pylons.nametag.Value,
                                    custom_nametag = name,
                                    distance = My_root ~= nil and My_root ~= 0 and Pylons.distance.Value or false,
                                    custom_distance = ""..root_distance,
                                    tracer = Pylons.tracer.Value,
                                    tracer_type = Current_tracer_type,
                                    box_type = Current_box_type,
                                })
                            end
                        end
                    end
				end
			end
		end
	end
end
if _G.PylonTask then
	_G.PylonTask()
end

if _G.ObjectCache == nil then
    _G.ObjectCache = {}
end

if _G.ObjectTask == nil then
    _G.ObjectTask = function()
        if Objects.enabled.Value and Master_esp_settings.enabled.Value then
            for _, object in ipairs(dx9.GetChildren(ObjectsFolder)) do
                local memadd = tostring(object)
                local cached_tab = _G.ObjectCache[memadd]
                if not cached_tab then
                    local objectName = dx9.GetName(object)
                    if objectName and type(objectName) == "string" and objectName ~= "" then
                        local instanceType = dx9.GetType(object)
                        local hrp = dx9.FindFirstChild(object, "HumanoidRootPart")
                        local pos = nil;
                        if hrp and hrp ~= 0 then
                            pos = dx9.GetPosition(hrp)
                        else
                            hrp = nil
                            if instanceType == "Part" or instanceType == "MeshPart" or instanceType == "UnionOperation" then
                                pos = dx9.GetPosition(object)
                            end
                        end
                        if pos ~= nil then
                            _G.ObjectCache[memadd] = {
                                object = object;
                                instanceType = instanceType;
                                hrp = hrp;
                                pos = pos;
                                objectName = objectName;
                            }
                        end
                    end
                end
                if cached_tab then
                    local object = cached_tab.object
                    local name = cached_tab.objectName
                    local root_pos = cached_tab.pos

                    if object and object ~= 0 then
                        local my_root_pos = My_root ~= nil and My_root ~= 0 and dx9.GetPosition(My_root) or {x=0, y=0, z=0}
                        local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                        local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})

                        local screen_pos = root_screen_pos

                        local espType = cached_tab.hrp ~= nil and nil or "misc"

                        print("Object: "..name.." | Position: "..root_pos.x..", "..root_pos.y..", "..root_pos.z)

                        if _G.IsOnScreen(screen_pos) then								
                            if root_distance < Objects.distance_limit.Value then
                                Lib_esp.draw({
                                    esp_type = espType,
                                    target = object,
                                    color = Config.objects.color,
                                    healthbar = false,
                                    nametag = Objects.nametag.Value,
                                    custom_nametag = name,
                                    distance = My_root ~= nil and My_root ~= 0 and Objects.distance.Value or false,
                                    custom_distance = ""..root_distance,
                                    tracer = Objects.tracer.Value,
                                    tracer_type = Current_tracer_type,
                                    box_type = Current_box_type,
                                })
                            end
                        end
                    end
                end
            end
        end
    end
end
if _G.ObjectTask then
	_G.ObjectTask()
end

-- if _G.WaypointTask == nil then
-- 	_G.WaypointTask = function()
-- 		for index, data in ipairs(_G.waypointlist) do
-- 			if data.visible then
-- 				local my_root_pos = Get_local_player_position()
-- 				local pos = data.position
-- 				local distance = _G.Get_Distance(my_root_pos, pos) or 0
-- 				local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
				
-- 				local isOnScreen = _G.IsOnScreen(screen_pos) and true or false
-- 				local isInRange = distance < data.distance_limit and true or false
-- 				if isOnScreen then
-- 					if isInRange then
-- 						Lib_esp.ground_circle({
-- 							position = pos,
-- 							color = data.color,
-- 							nametag = data.nametag,
-- 							custom_nametag = data.name,
-- 							distance = data.distance,
-- 							custom_distance = distance,
-- 							tracer = data.tracer,
-- 							tracer_type = Master_esp_settings.tracer_type.ValueIndex
-- 						})
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end
-- if _G.WaypointTask then
-- 	_G.WaypointTask()
-- end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= Config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end