--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

--TODO:
--  use ParkourReborn script to reuse PersistentCache

HiddenTabsconfig = _G.HiddenTabsconfig or {
    {
        tab = "players";
        hidden = false;
    };
}
if _G.HiddenTabsconfig == nil then
    _G.HiddenTabsconfig = HiddenTabsconfig
    HiddenTabsconfig = _G.HiddenTabsconfig
end

Config = _G.Config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
        repr = "https://raw.githubusercontent.com/Ozzypig/repr/refs/heads/master/repr.lua"
	};
    settings = {
		menu_toggle_keybind = "[F2]";
		
		master_esp_enabled = true;
    	box_type = 1; -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"

        maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;

        hidden_Tabs = HiddenTabsconfig;
    };
    players = {
        enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
        color = { 0, 225, 0 };
		distance_limit = 10000;
    };
};
if _G.Config == nil then
	_G.Config = Config
	Config = _G.Config
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
CountTableEntries = _G.CountTableEntries

repr = loadstring(dx9.Get(Config.urls.repr))()

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "Doors | dx9ware | By @Brycki";
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

Tabs = {}
Tabs.settings = Interface:AddTab("Settings")

if Lib_ui.FirstRun then
    Tabs.settings:Focus()
end

Groupboxes = {}
Groupboxes.debug = Tabs.settings:AddMiddleGroupbox("Debugging");
Groupboxes.master_esp_settings = Tabs.settings:AddMiddleGroupbox("Master ESP");
Groupboxes.hidden_Tabs = Tabs.settings:AddMiddleGroupbox("Hidden Tabs");

--Workspace.World.Props.Dynamics
--Workspace.World.Props.Animated
--Workspace.World.SwingPoints(Folder of Parts)

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

Master_esp_settings = {
	enabled = Groupboxes.master_esp_settings
		:AddToggle({
			Default = Config.settings.master_esp_enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Master ESP" or "[settings] Disabled Master ESP", 1)
		end);

	box_type = Groupboxes.master_esp_settings
		:AddDropdown({
			Text = "Box Type";
			Default = Config.settings.box_type;
			Values = { "Corners", "2D Box", "3D Box" };
		})
		:OnChanged(function(value)
			Lib_ui:Notify("[settings] Box Type: " .. value, 1)
		end);

	tracer_type = Groupboxes.master_esp_settings
		:AddDropdown({
			Text = "Tracer Type";
			Default = Config.settings.tracer_type;
			Values = { "Near-Bottom", "Bottom", "Top", "Mouse" };
		})
		:OnChanged(function(value)
			Lib_ui:Notify("[settings] Tracer Type: " .. value, 1)
		end);
}

Hidden_Tabs = {}
for index, data in ipairs(HiddenTabsconfig) do
    local name = data.tab
    local defaultHidden = data.hidden
	Hidden_Tabs[name] = Groupboxes.hidden_Tabs
		:AddToggle({
			Default = defaultHidden;
			Text = name.." Tab Hidden";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Hidden "..name.." Tab" or "[settings] Showed "..name.." Tab", 1)
		end)
end

if _G.Get_Distance == nil then
	_G.Get_Distance = function(v1, v2)
		local a = (v1.x - v2.x) * (v1.x - v2.x)
		local b = (v1.y - v2.y) * (v1.y - v2.y)
		local c = (v1.z - v2.z) * (v1.z - v2.z)

		return math.floor(math.sqrt(a + b + c) + 0.5)
	end
end

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

Datamodel = dx9.GetDatamodel()
Workspace = dx9.FindFirstChild(Datamodel, "Workspace")
Services = {
	players = dx9.FindFirstChild(Datamodel, "Players");
}

local reprSettings = {
	pretty = true;              -- print with \n and indentation?
	semicolons = true;          -- when printing tables, use semicolons (;) instead of commas (,)?
	sortKeys = false;             -- when printing dictionary tables, sort keys alphabetically?
	spaces = 2;                  -- when pretty printing, use how many spaces to indent?
	Tabs = false;                -- when pretty printing, use Tabs instead of spaces?
	robloxFullName = false;      -- when printing Roblox objects, print full name or just name? 
	robloxProperFullName = false; -- when printing Roblox objects, print a proper* full name?
	robloxClassName = false;      -- when printing Roblox objects, also print class name in parens?
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

Current_tracer_type = _G.Get_Index("tracer", Master_esp_settings.tracer_type.Value)
Current_box_type = _G.Get_Index("box", Master_esp_settings.box_type.Value)

if Local_player == nil then
	for _, player in ipairs(dx9.GetChildren(Services.players)) do
		local pgui = dx9.FindFirstChild(player, "PlayerGui")
		if pgui ~= nil and pgui ~= 0 then
			Local_player = player
			break
		end
	end
end

if Local_player == nil or Local_player == 0 then
	Local_player = dx9.get_localplayer()
end

function Get_local_player_name()
	if dx9.GetType(Local_player) == "Player" then
		return dx9.GetName(Local_player)
	else
		return Local_player.Info.Name
	end
end

Local_player_name = Get_local_player_name()

My_player = dx9.FindFirstChild(Services.players, Local_player_name)
My_character = nil
My_head = nil
My_root = nil
My_humanoid = nil

if My_player == nil or My_player == 0 then
	return
elseif My_player ~= nil and My_player ~= 0 then
    My_character = dx9.FindFirstChild(Workspace, Local_player_name)
end

if My_character == nil or My_character == 0 then
	return
elseif My_character ~= nil and My_character ~= 0 then
	My_head = dx9.FindFirstChild(My_character, "Head")
	My_root = dx9.FindFirstChild(My_character, "HumanoidRootPart")
	My_humanoid = dx9.FindFirstChild(My_character, "Humanoid")
end

if My_root == nil or My_root == 0 then
    return
end

if My_head == nil or My_head == 0 then
    return
end

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

if Hidden_Tabs.players.Value == false then
    Tabs.players = Interface:AddTab("Players")
    Groupboxes.players = Tabs.players:AddMiddleGroupbox("Players");
    Players = {
        enabled = Groupboxes.players
            :AddToggle({
                Default = Config.players.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[players] Enabled ESP" or "[players] Disabled ESP", 1)
            end);

        distance = Groupboxes.players
            :AddToggle({
                Default = Config.players.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[players] Enabled Distance" or "[players] Disabled Distance", 1)
            end);
        
        nametag = Groupboxes.players
            :AddToggle({
                Default = Config.players.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[players] Enabled Nametag" or "[players] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.players
            :AddToggle({
                Default = Config.players.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[players] Enabled Tracer" or "[players] Disabled Tracer", 1)
            end);

        color = Groupboxes.players:AddColorPicker({
            Default = Config.players.color;
            Text = "Color";
        });

        distance_limit = Groupboxes.players:AddSlider({
            Default = Config.players.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }
    if Master_esp_settings.enabled.Value then
        if Players.enabled.Value then
            if _G.PlayerTask == nil then
                _G.PlayerTask = function()
                    for _, player in ipairs(dx9.GetChildren(Services.players)) do
                        local playerName = dx9.GetName(player)
                        if playerName and playerName ~= Local_player_name then
                            local playerColor = Players.color.Value
                            
                            local character = dx9.FindFirstChild(Workspace, playerName)
                            if character and character ~= 0 then
                                local root = dx9.FindFirstChild(character, "HumanoidRootPart")
                                local head = dx9.FindFirstChild(character, "Head")
                                local humanoid = dx9.FindFirstChild(character, "Humanoid")

                                if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
                                    local my_root_pos = dx9.GetPosition(My_root)
                                    local root_pos = dx9.GetPosition(root)
                                    local head_pos = dx9.GetPosition(head)
                                    local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                                    local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                                    local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

                                    local screen_pos = root_screen_pos

                                    if _G.IsOnScreen(screen_pos) then
                                        if root_distance < Players.distance_limit.Value then
                                            Lib_esp.draw({
                                                target = character,
                                                color = playerColor,
                                                healthbar = false,
                                                nametag = Players.nametag.Value,
                                                distance = Players.distance.Value,
                                                custom_distance = ""..root_distance,
                                                tracer = Players.tracer.Value,
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
            if _G.PlayerTask then
                _G.PlayerTask()
            end
        end
    end
end

if _G.Rescanning == nil then
    _G.Rescanning = false
end
if _G.Rescan == nil then
    _G.Rescan = function()
        if _G.Rescanning == false then
            _G.Rescanning = true

            if _G.PersistentCache == nil then
                _G.PersistentCache = {
                    Category = {};
                }
            else
                for categoryk,categoryv in pairs(_G.PersistentCache) do
                    for k,v in ipairs(categoryv) do
                        categoryv[k] = nil
                    end
                    _G.PersistentCache[categoryk] = categoryv
                end
            end
            
            if _G.PersistentCache ~= nil then
                if type(_G.PersistentCache) == "table" then
                    --Scan folders
                end
            end

            if _G.consoleEnabled then
                print(repr(_G.PersistentCache, reprSettings))
            end

            _G.Rescanning = false
        end
    end
    _G.Rescan()
end

Debugging.rescan_keybind = Groupboxes.debug:AddKeybindButton({
    Index = "RescanKeybindButton";
    Text = "Rescan Keybind: [F4]";
    Default = "[F4]";
})
Debugging.rescan_keybind = Debugging.rescan_keybind:OnChanged(function(newKey)
    local oldKey = Debugging.rescan_keybind.Key
	Debugging.rescan_keybind:SetText("Rescan Keybind: "..tostring(newKey))
	Lib_ui:Notify("Rescan Keybind changed from '"..tostring(oldKey).."' to '"..tostring(newKey).."'", 1)
end)
Debugging.rescan = Groupboxes.debug:AddButton("Rescan", function()
    if _G.Rescanning == false then
        Lib_ui:Notify("Rescanning...", 1)
        _G.Rescan()
        Lib_ui:Notify("Rescanning completed!", 1)
    else
        Lib_ui:Notify("Rescanning in progress! Please be patient!", 1)
    end
end)
Debugging.rescan:ConnectKeybindButton(Debugging.rescan_keybind)

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= Config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end