--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

--TODO:
--  finish adding the Other category
--  add teleport support (a Toggle in the Master settings that then shows the teleport panels in each tab)
--  ItemSpawns MAYBE... but I really don't think that is at all necessary if we have Scrap ESP
    
--If you don't want a super long list, feel free to set _G.Scrapconfig to your own table before using loadstring on this script
Scrapconfig = _G.Scrapconfig or {
    {
		name = "Other";
		Enabled = false;
	};
	{
		name = "Capacitor";
		Enabled = false;
	};
    {
		name = "PulseGenerator";
		Enabled = false;
	};
    {
		name = "RailTrigger";
		Enabled = false;
	};
    {
		name = "MagnetomotiveCalibrator";
		Enabled = false;
	};
    {
		name = "Battery";
		Enabled = false;
	};
    {
		name = "Scrap";
		Enabled = false;
	};
    {
		name = "BatteryLarge";
		Enabled = false;
	};
    {
		name = "DriveRare";
		Enabled = false;
	};
    {
		name = "Jewelry";
		Enabled = false;
	};
    {
		name = "JewelryRare";
		Enabled = false;
	};
    {
		name = "JewelryUncommon";
		Enabled = false;
	};
    {
		name = "Laptop";
		Enabled = false;
	};
    {
		name = "MobileDevice";
		Enabled = false;
	};
    {
		name = "Thumbdrive";
		Enabled = false;
	};
    {
		name = "ThumbdriveRare";
		Enabled = false;
	};
    {
		name = "Trash";
		Enabled = false;
	};
    {
		name = "DeliveryPackage";
		Enabled = false;
	};
    {
		name = "Cloth";
		Enabled = false;
	};
    {
		name = "DuctTape";
		Enabled = false;
	};
    {
		name = "YankMod1";
		Enabled = false;
	};
    {
		name = "GrapplerCore";
		Enabled = false;
	};
    {
		name = "GrapplerPart3";
		Enabled = false;
	};
    {
		name = "GrapplerPart4";
		Enabled = false;
	};
    {
		name = "YankMod2";
		Enabled = false;
	};
    {
		name = "GrapplerPart1";
		Enabled = false;
	};
    {
		name = "Roll";
		Enabled = false;
	};
    {
		name = "AluminumCasing";
		Enabled = false;
	};
    {
		name = "MagneticCoil";
		Enabled = false;
	};
}
if _G.Scrapconfig == nil then
	_G.Scrapconfig = Scrapconfig
	Scrapconfig = _G.Scrapconfig
end

--If you don't want a super long list, feel free to set _G.Loiterspotsconfig to your own table before using loadstring on this script
Loiterspotsconfig = _G.Loiterspotsconfig or {
    {
		name = "Other";
		Enabled = false;
	};
    {
		name = "SkyarcLayOut";
		Enabled = false;
	};
    {
		name = "DirwickChairSpot";
		Enabled = false;
	};
    {
		name = "Spot";
		Enabled = false;
	};
    {
		name = "Railingspot";
		Enabled = false;
	};
}
if _G.Loiterspotsconfig == nil then
	_G.Loiterspotsconfig = Loiterspotsconfig
	Loiterspotsconfig = _G.Loiterspotsconfig
end

HiddenTabsconfig = _G.HiddenTabsconfig or {
    {
        tab = "players";
        hidden = false;
    };
    {
        tab = "missions";
        hidden = false;
    };
    {
        tab = "checkpoints";
        hidden = false;
    };
    {
        tab = "xp_multipliers";
        hidden = false;
    };
    {
        tab = "races";
        hidden = true;
    };
    {
        tab = "other";
        hidden = true;
    };
    {
        tab = "item_spawns";
        hidden = true;
    };
    {
        tab = "scrap";
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
        cache_cleanup_timer = 3;

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
    missions = {
		enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 255, 100 };
		distance_limit = 10000;
	};
    antennas = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 50, 255, 255 };
		distance_limit = 10000;
	};
    checkpoints = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 50, 255, 255 };
		distance_limit = 10000;
	};
    routers = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 225, 0, 0 };
		distance_limit = 10000;
	};
    timetrials = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		start_color = { 225, 0, 0 };
        finish_color = { 225, 0, 0 };
		distance_limit = 10000;
	};
    challenges = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		start_color = { 225, 0, 0 };
        finish_color = { 225, 0, 0 };
		distance_limit = 10000;
	};
    secret_runaway_messages = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 225, 0, 0 };
		distance_limit = 10000;
	};
    easter_egg_switch_1 = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 225, 0, 0 };
		distance_limit = 10000;
	};
    loiter_spots = {
        enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 255, 255 };
		distance_limit = 10000;
		entries = Loiterspotsconfig;
	};
    scrap = {
        enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 255, 255 };
		distance_limit = 10000;
		entries = Scrapconfig;
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
	Title = "Parkour Reborn | dx9ware | By @Brycki";
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
Debugging.scrap_cache_cleanup_timer = Groupboxes.debug:AddSlider({
    Default = Config.settings.cache_cleanup_timer;
    Text = "ScrapCache Cleanup Timer";
    Min = 0;
    Max = 10;
    Rounding = 1;
});
Debugging.scrap_cache_size = Groupboxes.debug:AddLabel("Scrap Cache Size: "..tostring(CountTableEntries(_G.ScrapCache or {}) or 0))
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
                    Missionmarkers = {};
                    Respawnantennas = {};
                    Blinkycheckpoints = {};
                    Routers = {};
                    Timetrials = {};
                    Challenges = {};
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
                    Missionmarkers_folder = dx9.FindFirstChild(Workspace, "MissionMarkers")
                    if Missionmarkers_folder ~= nil and Missionmarkers_folder ~= 0 then
                        Missionmarkers_children = dx9.GetChildren(Missionmarkers_folder)
                        if Missionmarkers_children then
                            if type(Missionmarkers_children) == "table" then
                                for i,v in ipairs(Missionmarkers_children) do
                                    if dx9.GetType(v) == "Part" then
                                        local vaddress = tostring(v)
                                        local vname = dx9.GetName(v)
                                        local vpos = dx9.GetPosition(v)
                                        local data = {
                                            name = vname;
                                            pos = vpos;
                                        }
                                        _G.PersistentCache.Missionmarkers[vaddress] = data
                                    end
                                end
                            end
                        end
                    end

                    Respawnantennas_folder = dx9.FindFirstChild(Workspace, "RespawnAntennas")
                    if Respawnantennas_folder ~= nil and Respawnantennas_folder ~= 0 then
                        Respawnantennas_children = dx9.GetChildren(Respawnantennas_folder)
                        if Respawnantennas_children then
                            if type(Respawnantennas_children) == "table" then
                                for i,v in ipairs(Respawnantennas_children) do
                                    if dx9.GetType(v) == "Model" then
                                        local model = dx9.FindFirstChild(v, "Model")
                                        if model ~= nil and model ~= 0 then
                                            if dx9.GetType(model) == "Model" then
                                                local part = dx9.FindFirstChild(model, "Part")
                                                if part ~= nil and part ~= 0 then
                                                    if dx9.GetType(part) == "Part" then
                                                        local vaddress = tostring(v)
                                                        local vname = dx9.GetName(v)
                                                        local partpos = dx9.GetPosition(part)
                                                        local data = {
                                                            name = vname;
                                                            part = part;
                                                            pos = partpos;
                                                        }
                                                        _G.PersistentCache.Respawnantennas[vaddress] = data
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    World_folder = dx9.FindFirstChild(Workspace, "World")
                    if World_folder ~= nil and World_folder ~= 0 then
                        --Workspace.World.Checkpoints.NAME.Model.Blinky
                        Checkpoints_folder = dx9.FindFirstChild(World_folder, "Checkpoints")
                        if Checkpoints_folder ~= nil and Checkpoints_folder ~= 0 then
                            Checkpoints_children = dx9.GetChildren(Checkpoints_folder)
                            if Checkpoints_children then
                                if type(Checkpoints_children) == "table" then
                                    for i,v in ipairs(Checkpoints_children) do
                                        local model = dx9.FindFirstChild(v, "Model")
                                        if model ~= nil and model ~= 0 then
                                            if dx9.GetType(model) == "Model" then
                                                local part = dx9.FindFirstChild(model, "Blinky")
                                                if part ~= nil and part ~= 0 then
                                                    if dx9.GetType(part) == "Part" then
                                                        local vaddress = tostring(v)
                                                        local vname = dx9.GetName(v)
                                                        local partpos = dx9.GetPosition(part)
                                                        local data = {
                                                            name = vname;
                                                            part = part;
                                                            pos = partpos;
                                                        }
                                                        _G.PersistentCache.Blinkycheckpoints[vaddress] = data
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    Routers_folder = dx9.FindFirstChild(Workspace, "Routers")
                    if Routers_folder ~= nil and Routers_folder ~= 0 then
                        Routers_children = dx9.GetChildren(Routers_folder)
                        if Routers_children then
                            if type(Routers_children) == "table" then
                                for i,v in ipairs(Routers_children) do
                                    if dx9.GetType(v) == "Configuration" then
                                        local router_model = dx9.FindFirstChild(v, "RouterModel")
                                        if router_model ~= nil and router_model ~= 0 then
                                            if dx9.GetType(router_model) == "Model" then
                                                local main_part = dx9.FindFirstChild(router_model, "Main")
                                                if main_part ~= nil and main_part ~= 0 then
                                                    if dx9.GetType(main_part) == "Part" then
                                                        local vaddress = tostring(v)
                                                        local vname = dx9.GetName(v)
                                                        local partpos = dx9.GetPosition(main_part)
                                                        local data = {
                                                            name = vname;
                                                            mainpart = main_part;
                                                            pos = partpos;
                                                        }
                                                        _G.PersistentCache.Routers[vaddress] = data
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    Races_folder = dx9.FindFirstChild(Workspace, "Races")
                    if Races_folder ~= nil and Races_folder ~= 0 then
                        --Workspace.Races.TimeTrials.FOLDER.Start_MODEL.Part
                        --Workspace.Races.TimeTrials.FOLDER.Finish_PART
                        Timetrials_folder = dx9.FindFirstChild(Races_folder, "TimeTrials")
                        if Timetrials_folder ~= nil and Timetrials_folder ~= 0 then
                            Timetrials_children = dx9.GetChildren(Timetrials_folder)
                            if Timetrials_children then
                                if type(Timetrials_children) == "table" then
                                    for i,v in ipairs(Timetrials_children) do
                                        local vaddress = nil
                                        local data = nil

                                        local finishpart = dx9.FindFirstChild(v, "Finish")
                                        if finishpart ~= nil and finishpart ~= 0 then
                                            if dx9.GetType(finishpart) == "Part" then
                                                if data == nil then
                                                    data = {}
                                                end
                                                if data.name == nil then
                                                    local vname = dx9.GetName(v)
                                                    data.name = vname
                                                end
                                                if vaddress == nil then
                                                    vaddress = tostring(v)
                                                end
                                                local pos = dx9.GetPosition(finishpart)
                                                data.finishpos = pos
                                                data.finishpart = finishpart
                                            end
                                        end
                                        local startmodel = dx9.FindFirstChild(v, "Start")
                                        if startmodel ~= nil and startmodel ~= 0 then
                                            if dx9.GetType(startmodel) == "Model" then
                                                local startpart = dx9.FindFirstChild(startmodel, "Part")
                                                if startpart ~= nil and startpart ~= 0 then
                                                    if dx9.GetType(startpart) == "Part" then
                                                        if data == nil then
                                                            data = {}
                                                        end
                                                        if data.name == nil then
                                                            local vname = dx9.GetName(v)
                                                            data.name = vname
                                                        end
                                                        if vaddress == nil then
                                                            vaddress = tostring(v)
                                                        end
                                                        local pos = dx9.GetPosition(startpart)
                                                        data.startpos = pos
                                                        data.startpart = startpart
                                                    end
                                                end
                                            end
                                        end
                                        if vaddress then
                                            _G.PersistentCache.Timetrials[vaddress] = data
                                        end
                                    end
                                end
                            end
                        end
                        Challenges_folder = dx9.FindFirstChild(Races_folder, "Challenges")
                        if Challenges_folder ~= nil and Challenges_folder ~= 0 then
                            Challenges_children = dx9.GetChildren(Challenges_folder)
                            if Challenges_children then
                                if type(Challenges_children) == "table" then
                                    for i,v in ipairs(Challenges_children) do
                                        local vaddress = nil
                                        local data = nil

                                        local finishpart = dx9.FindFirstChild(v, "Finish")
                                        if finishpart ~= nil and finishpart ~= 0 then
                                            if dx9.GetType(finishpart) == "Part" then
                                                if data == nil then
                                                    data = {}
                                                end
                                                if data.name == nil then
                                                    local vname = dx9.GetName(v)
                                                    data.name = vname
                                                end
                                                if vaddress == nil then
                                                    vaddress = tostring(v)
                                                end
                                                local pos = dx9.GetPosition(finishpart)
                                                data.finishpos = pos
                                                data.finishpart = finishpart
                                            end
                                        end
                                        local startmodel = dx9.FindFirstChild(v, "Start")
                                        if startmodel ~= nil and startmodel ~= 0 then
                                            if dx9.GetType(startmodel) == "Model" then
                                                local startpart = dx9.FindFirstChild(startmodel, "Part")
                                                if startpart ~= nil and startpart ~= 0 then
                                                    if dx9.GetType(startpart) == "Part" then
                                                        if data == nil then
                                                            data = {}
                                                        end
                                                        if data.name == nil then
                                                            local vname = dx9.GetName(v)
                                                            data.name = vname
                                                        end
                                                        if vaddress == nil then
                                                            vaddress = tostring(v)
                                                        end
                                                        local pos = dx9.GetPosition(startpart)
                                                        data.startpos = pos
                                                        data.startpart = startpart
                                                    end
                                                end
                                            end
                                        end
                                        if vaddress then
                                            _G.PersistentCache.Challenges[vaddress] = data
                                        end
                                    end
                                end
                            end
                        end
                    end
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

--Tabs.other = Interface:AddTab("Other")
--Tabs.item_spawns = Interface:AddTab("Item Spawns")

--Groupboxes.secret_runaway_messages = Tabs.other:AddMiddleGroupbox("Secret Runaway Messages");
    --Workspace.World.SecretRunawayMessages.PART
--Groupboxes.easter_egg_switch_1 = Tabs.other:AddMiddleGroupbox("Easter Egg Switch 1");
    --Workspace.World.EasterEggSwitch1.Part
--Groupboxes.loiter_spots = Tabs.other:AddMiddleGroupbox("Loiter Spots");
    --Workspace.World.LoiterSpots.Spots.MODEL.Root
--Groupboxes.loiter_spots_config = Tabs.other:AddMiddleGroupbox("Loiter Spots Config");
    --SkyarcLayOut, DirwickChairSpot, Spot, Railingspot
--Groupboxes.collectible_spawns = Tabs.item_spawns:AddMiddleGroupbox("Collectibles");
    --Workspace.World.ItemSpawns.Collectibles --IDK YET? Empty?
--Groupboxes.delivery_spawns = Tabs.item_spawns:AddMiddleGroupbox("Deliveries");
    --Workspace.World.ItemSpawns.Deliveries.DeliverySpawn_PART
--Groupboxes.valuable_spawns = Tabs.item_spawns:AddMiddleGroupbox("Valuables");
    --Workspace.World.ItemSpawns.Valuables.MODEL.PARTS_MESHPARTS_UNIONS

--[[
secret_runaway_messages = {
	enabled = Groupboxes.secret_runaway_messages
		:AddToggle({
			Default = Config.secret_runaway_messages.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[secret runaway messages] Enabled ESP" or "[secret runaway messages] Disabled ESP", 1)
		end);

	distance = Groupboxes.secret_runaway_messages
		:AddToggle({
			Default = Config.secret_runaway_messages.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[secret runaway messages] Enabled Distance" or "[secret runaway messages] Disabled Distance", 1)
		end);

	nametag = Groupboxes.secret_runaway_messages
		:AddToggle({
			Default = Config.secret_runaway_messages.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[secret runaway messages] Enabled Nametag" or "[secret runaway messages] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.secret_runaway_messages
		:AddToggle({
			Default = Config.secret_runaway_messages.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[secret runaway messages] Enabled Tracer" or "[secret runaway messages] Disabled Tracer", 1)
		end);

    color = Groupboxes.secret_runaway_messages:AddColorPicker({
		Default = Config.secret_runaway_messages.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.secret_runaway_messages:AddSlider({
		Default = Config.secret_runaway_messages.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

easter_egg_switch_1 = {
	enabled = Groupboxes.easter_egg_switch_1
		:AddToggle({
			Default = Config.easter_egg_switch_1.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[easter egg switch 1] Enabled ESP" or "[easter egg switch 1] Disabled ESP", 1)
		end);

	distance = Groupboxes.easter_egg_switch_1
		:AddToggle({
			Default = Config.easter_egg_switch_1.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[easter egg switch 1] Enabled Distance" or "[easter egg switch 1] Disabled Distance", 1)
		end);

	nametag = Groupboxes.easter_egg_switch_1
		:AddToggle({
			Default = Config.easter_egg_switch_1.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[easter egg switch 1] Enabled Nametag" or "[easter egg switch 1] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.easter_egg_switch_1
		:AddToggle({
			Default = Config.easter_egg_switch_1.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[easter egg switch 1] Enabled Tracer" or "[easter egg switch 1] Disabled Tracer", 1)
		end);

    color = Groupboxes.easter_egg_switch_1:AddColorPicker({
		Default = Config.easter_egg_switch_1.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.easter_egg_switch_1:AddSlider({
		Default = Config.easter_egg_switch_1.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

loiter_spots = {
	enabled = Groupboxes.loiter_spots
		:AddToggle({
			Default = Config.loiter_spots.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[loiter spots] Enabled ESP" or "[loiter spots] Disabled ESP", 1)
		end);

	distance = Groupboxes.loiter_spots
		:AddToggle({
			Default = Config.loiter_spots.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[loiter spots] Enabled Distance" or "[loiter spots] Disabled Distance", 1)
		end);

	nametag = Groupboxes.loiter_spots
		:AddToggle({
			Default = Config.loiter_spots.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[loiter spots] Enabled Nametag" or "[loiter spots] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.loiter_spots
		:AddToggle({
			Default = Config.loiter_spots.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[loiter spots] Enabled Tracer" or "[loiter spots] Disabled Tracer", 1)
		end);

    color = Groupboxes.loiter_spots:AddColorPicker({
		Default = Config.loiter_spots.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.loiter_spots:AddSlider({
		Default = Config.loiter_spots.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

loiter_spots_config = {}
for _, tab in pairs(Config.loiter_spots.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	loiter_spots_config[name.."_enabled"] = Groupboxes.loiter_spots_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[loiter spots] Enabled "..name.." ESP" or "[loiter spots] Disabled "..name.." ESP", 1)
		end)
end
]]

if Hidden_Tabs.missions.Value == false then
    Tabs.missions = Interface:AddTab("Missions")
    Groupboxes.missions = Tabs.missions:AddMiddleGroupbox("Missions");
    Missions = {
        enabled = Groupboxes.missions
            :AddToggle({
                Default = Config.missions.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[missions] Enabled ESP" or "[missions] Disabled ESP", 1)
            end);

        distance = Groupboxes.missions
            :AddToggle({
                Default = Config.missions.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[missions] Enabled Distance" or "[missions] Disabled Distance", 1)
            end);

        nametag = Groupboxes.missions
            :AddToggle({
                Default = Config.missions.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[missions] Enabled Nametag" or "[missions] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.missions
            :AddToggle({
                Default = Config.missions.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[missions] Enabled Tracer" or "[missions] Disabled Tracer", 1)
            end);

        color = Groupboxes.missions:AddColorPicker({
            Default = Config.missions.color;
            Text = "Color";
        });

        distance_limit = Groupboxes.missions:AddSlider({
            Default = Config.missions.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }
    if Master_esp_settings.enabled.Value then
        if Missions.enabled.Value then
            if _G.MissionMarkersTask == nil then
                _G.MissionMarkersTask = function()
                    if _G.PersistentCache.Missionmarkers then
                        if type(_G.PersistentCache.Missionmarkers) == "table" then
                            for v, vdata in pairs(_G.PersistentCache.Missionmarkers) do
                                local name = vdata.name
                                local pos = vdata.pos
                                        
                                local my_root_pos = dx9.GetPosition(My_root)
                                local distance = _G.Get_Distance(my_root_pos, pos)
                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                
                                if distance < Missions.distance_limit.Value then
                                    if _G.IsOnScreen(screen_pos) then
                                        Lib_esp.draw({
                                            esp_type = "misc",
                                            target = tonumber(v),
                                            color = Missions.color.Value,
                                            healthbar = false,
                                            nametag = Missions.nametag.Value,
                                            custom_nametag = name,
                                            distance = Missions.distance.Value,
                                            custom_distance = ""..distance,
                                            tracer = Missions.tracer.Value,
                                            tracer_type = Current_tracer_type,
                                            box_type = Current_box_type
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if _G.MissionMarkersTask then
                _G.MissionMarkersTask()
            end
        end
    end
end

if Hidden_Tabs.checkpoints.Value == false then
    Tabs.checkpoints = Interface:AddTab("Checkpoints")
    Groupboxes.antennas = Tabs.checkpoints:AddMiddleGroupbox("Respawn Antennas");
    --Groupboxes.checkpoints = Tabs.checkpoints:AddMiddleGroupbox("Blinky Checkpoints");
    Antennas = {
        enabled = Groupboxes.antennas
            :AddToggle({
                Default = Config.antennas.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[antennas] Enabled ESP" or "[antennas] Disabled ESP", 1)
            end);

        distance = Groupboxes.antennas
            :AddToggle({
                Default = Config.antennas.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[antennas] Enabled Distance" or "[antennas] Disabled Distance", 1)
            end);

        nametag = Groupboxes.antennas
            :AddToggle({
                Default = Config.antennas.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[antennas] Enabled Nametag" or "[antennas] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.antennas
            :AddToggle({
                Default = Config.antennas.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[antennas] Enabled Tracer" or "[antennas] Disabled Tracer", 1)
            end);

        color = Groupboxes.antennas:AddColorPicker({
            Default = Config.antennas.color;
            Text = "Color";
        });

        distance_limit = Groupboxes.antennas:AddSlider({
            Default = Config.antennas.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }
    --[[Checkpoints = {
        enabled = Groupboxes.checkpoints
            :AddToggle({
                Default = Config.checkpoints.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[checkpoints] Enabled ESP" or "[checkpoints] Disabled ESP", 1)
            end);

        distance = Groupboxes.checkpoints
            :AddToggle({
                Default = Config.checkpoints.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[checkpoints] Enabled Distance" or "[checkpoints] Disabled Distance", 1)
            end);

        nametag = Groupboxes.checkpoints
            :AddToggle({
                Default = Config.checkpoints.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[checkpoints] Enabled Nametag" or "[checkpoints] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.checkpoints
            :AddToggle({
                Default = Config.checkpoints.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[checkpoints] Enabled Tracer" or "[checkpoints] Disabled Tracer", 1)
            end);

        color = Groupboxes.checkpoints:AddColorPicker({
            Default = Config.checkpoints.color;
            Text = "Color";
        });

        distance_limit = Groupboxes.checkpoints:AddSlider({
            Default = Config.checkpoints.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }]]
    if Master_esp_settings.enabled.Value then
        if Antennas.enabled.Value then
            if _G.RespawnAntennasTask == nil then
                _G.RespawnAntennasTask = function()
                    if _G.PersistentCache.Respawnantennas then
                        if type(_G.PersistentCache.Respawnantennas) == "table" then
                            for v, vdata in pairs(_G.PersistentCache.Respawnantennas) do
                                local name = vdata.name
                                local part = vdata.part
                                local pos = vdata.pos

                                local my_root_pos = dx9.GetPosition(My_root)
                                local distance = _G.Get_Distance(my_root_pos, pos)
                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                                        
                                if _G.IsOnScreen(screen_pos) then
                                    if distance < Antennas.distance_limit.Value then
                                        Lib_esp.draw({
                                            esp_type = "misc",
                                            target = part,
                                            color = Antennas.color.Value,
                                            healthbar = false,
                                            nametag = Antennas.nametag.Value,
                                            custom_nametag = name,
                                            distance = Antennas.distance.Value,
                                            custom_distance = ""..distance,
                                            tracer = Antennas.tracer.Value,
                                            tracer_type = Current_tracer_type,
                                            box_type = Current_box_type
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if _G.RespawnAntennasTask then
                _G.RespawnAntennasTask()
            end
        end
        --[[
        if Checkpoints.enabled.Value then
            if _G.BlinkyCheckpointsTask == nil then
                _G.BlinkyCheckpointsTask = function()
                    if _G.PersistentCache.Blinkycheckpoints then
                        if type(_G.PersistentCache.Blinkycheckpoints) == "table" then
                            for v, vdata in pairs(_G.PersistentCache.Blinkycheckpoints) do
                                local name = vdata.name
                                local part = vdata.part
                                local pos = vdata.pos

                                local my_root_pos = dx9.GetPosition(My_root)
                                local distance = _G.Get_Distance(my_root_pos, pos)
                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                
                                if distance < Checkpoints.distance_limit.Value then
                                    if _G.IsOnScreen(screen_pos) then
                                        Lib_esp.draw({
                                            esp_type = "misc",
                                            target = part,
                                            color = Checkpoints.color.Value,
                                            healthbar = false,
                                            nametag = Checkpoints.nametag.Value,
                                            custom_nametag = name,
                                            distance = Checkpoints.distance.Value,
                                            custom_distance = ""..distance,
                                            tracer = Checkpoints.tracer.Value,
                                            tracer_type = Current_tracer_type,
                                            box_type = Current_box_type
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if _G.BlinkyCheckpointsTask then
                _G.BlinkyCheckpointsTask()
            end
        end
        ]]
    end
end

if Hidden_Tabs.xp_multipliers.Value == false then
    Tabs.xp_multipliers = Interface:AddTab("XP Multipliers")
    Groupboxes.routers = Tabs.xp_multipliers:AddMiddleGroupbox("Routers")
    Routers = {
        enabled = Groupboxes.routers
            :AddToggle({
                Default = Config.routers.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[routers] Enabled ESP" or "[routers] Disabled ESP", 1)
            end);

        distance = Groupboxes.routers
            :AddToggle({
                Default = Config.routers.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[routers] Enabled Distance" or "[routers] Disabled Distance", 1)
            end);

        nametag = Groupboxes.routers
            :AddToggle({
                Default = Config.routers.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[routers] Enabled Nametag" or "[routers] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.routers
            :AddToggle({
                Default = Config.routers.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[routers] Enabled Tracer" or "[routers] Disabled Tracer", 1)
            end);

        color = Groupboxes.routers:AddColorPicker({
            Default = Config.routers.color;
            Text = "Color";
        });

        distance_limit = Groupboxes.routers:AddSlider({
            Default = Config.routers.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }
    if Master_esp_settings.enabled.Value then
        if Routers.enabled.Value then
            if _G.RoutersTask == nil then
                _G.RoutersTask = function()
                    if _G.PersistentCache.Routers then
                        if type(_G.PersistentCache.Routers) == "table" then
                            for v, vdata in pairs(_G.PersistentCache.Routers) do
                                local name = vdata.name
                                local main_part = vdata.mainpart
                                local pos = vdata.pos

                                local my_root_pos = dx9.GetPosition(My_root)
                                local distance = _G.Get_Distance(my_root_pos, pos)
                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                
                                if _G.IsOnScreen(screen_pos) then
                                    if distance < Routers.distance_limit.Value then
                                        Lib_esp.draw({
                                            esp_type = "misc",
                                            target = main_part,
                                            color = Routers.color.Value,
                                            healthbar = false,
                                            nametag = Routers.nametag.Value,
                                            custom_nametag = name,
                                            distance = Routers.distance.Value,
                                            custom_distance = ""..distance,
                                            tracer = Routers.tracer.Value,
                                            tracer_type = Current_tracer_type,
                                            box_type = Current_box_type
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if _G.RoutersTask then
                _G.RoutersTask()
            end
        end
    end
end

if Hidden_Tabs.races.Value == false then
    Tabs.races = Interface:AddTab("Races")
    Groupboxes.timetrials = Tabs.races:AddLeftGroupbox("Time Trials");
    Groupboxes.challenges = Tabs.races:AddRightGroupbox("Challenges");
    Timetrials = {
        enabled = Groupboxes.timetrials
            :AddToggle({
                Default = Config.timetrials.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[timetrials] Enabled ESP" or "[timetrials] Disabled ESP", 1)
            end);

        distance = Groupboxes.timetrials
            :AddToggle({
                Default = Config.timetrials.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[timetrials] Enabled Distance" or "[timetrials] Disabled Distance", 1)
            end);

        nametag = Groupboxes.timetrials
            :AddToggle({
                Default = Config.timetrials.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[timetrials] Enabled Nametag" or "[timetrials] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.timetrials
            :AddToggle({
                Default = Config.timetrials.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[timetrials] Enabled Tracer" or "[timetrials] Disabled Tracer", 1)
            end);

        start_color = Groupboxes.timetrials:AddColorPicker({
            Default = Config.timetrials.start_color;
            Text = "Start Color";
        });

        finish_color = Groupboxes.timetrials:AddColorPicker({
            Default = Config.timetrials.finish_color;
            Text = "Finish Color";
        });

        distance_limit = Groupboxes.timetrials:AddSlider({
            Default = Config.timetrials.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }
    Challenges = {
        enabled = Groupboxes.challenges
            :AddToggle({
                Default = Config.challenges.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[challenges] Enabled ESP" or "[challenges] Disabled ESP", 1)
            end);

        distance = Groupboxes.challenges
            :AddToggle({
                Default = Config.challenges.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[challenges] Enabled Distance" or "[challenges] Disabled Distance", 1)
            end);

        nametag = Groupboxes.challenges
            :AddToggle({
                Default = Config.challenges.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[challenges] Enabled Nametag" or "[challenges] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.challenges
            :AddToggle({
                Default = Config.challenges.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[challenges] Enabled Tracer" or "[challenges] Disabled Tracer", 1)
            end);

        start_color = Groupboxes.challenges:AddColorPicker({
            Default = Config.challenges.start_color;
            Text = "Start Color";
        });
        
        finish_color = Groupboxes.challenges:AddColorPicker({
            Default = Config.challenges.finish_color;
            Text = "Finish Color";
        });

        distance_limit = Groupboxes.challenges:AddSlider({
            Default = Config.challenges.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }
    if Timetrials.enabled.Value then
        if _G.TimeTrialsTask == nil then
            _G.TimeTrialsTask = function()
                if _G.PersistentCache.Timetrials then
                    if type(_G.PersistentCache.Timetrials) == "table" then
                        for v, vdata in pairs(_G.PersistentCache.Timetrials) do
                            local vname = vdata.name
                            local finishpos = vdata.finishpos
                            local finishpart = vdata.finishpart
                            local startpos = vdata.startpos
                            local startpart = vdata.startpart

                            local my_root_pos = dx9.GetPosition(My_root)
                            local finishpart_distance = _G.Get_Distance(my_root_pos, finishpos)
                            local finishpart_screen_pos = dx9.WorldToScreen({finishpos.x, finishpos.y, finishpos.z})
                            local startpart_distance = _G.Get_Distance(my_root_pos, startpos)
                            local startpart_screen_pos = dx9.WorldToScreen({startpos.x, startpos.y, startpos.z})
                            
                            if finishpart_distance < Timetrials.distance_limit.Value then
                                if _G.IsOnScreen(finishpart_screen_pos) then
                                    Lib_esp.draw({
                                        esp_type = "misc",
                                        target = finishpart,
                                        color = Timetrials.finish_color.Value,
                                        healthbar = false,
                                        nametag = Timetrials.nametag.Value,
                                        custom_nametag = vname.." Finish",
                                        distance = Timetrials.distance.Value,
                                        custom_distance = ""..finishpart_distance,
                                        tracer = Timetrials.tracer.Value,
                                        tracer_type = Current_tracer_type,
                                        box_type = Current_box_type
                                    })
                                end
                            end
                            
                            if startpart_distance < Timetrials.distance_limit.Value then
                                if _G.IsOnScreen(startpart_screen_pos) then
                                    Lib_esp.draw({
                                        esp_type = "misc",
                                        target = startpart,
                                        color = Timetrials.start_color.Value,
                                        healthbar = false,
                                        nametag = Timetrials.nametag.Value,
                                        custom_nametag = vname.." Start",
                                        distance = Timetrials.distance.Value,
                                        custom_distance = ""..startpart_distance,
                                        tracer = Timetrials.tracer.Value,
                                        tracer_type = Current_tracer_type,
                                        box_type = Current_box_type
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end
        if _G.TimeTrialsTask then
            _G.TimeTrialsTask()
        end
    end
    if Challenges.enabled.Value then
        if _G.ChallengesTask == nil then
            _G.ChallengesTask = function()
                if _G.PersistentCache.Challenges then
                    if type(_G.PersistentCache.Challenges) == "table" then
                        for v, vdata in pairs(_G.PersistentCache.Challenges) do
                            local vname = vdata.name
                            local finishpos = vdata.finishpos
                            local finishpart = vdata.finishpart
                            local startpos = vdata.startpos
                            local startpart = vdata.startpart

                            local my_root_pos = dx9.GetPosition(My_root)
                            local finishpart_distance = _G.Get_Distance(my_root_pos, finishpos)
                            local finishpart_screen_pos = dx9.WorldToScreen({finishpos.x, finishpos.y, finishpos.z})
                            local startpart_distance = _G.Get_Distance(my_root_pos, startpos)
                            local startpart_screen_pos = dx9.WorldToScreen({startpos.x, startpos.y, startpos.z})
                            
                            if finishpart_distance < Challenges.distance_limit.Value then
                                if _G.IsOnScreen(finishpart_screen_pos) then
                                    Lib_esp.draw({
                                        esp_type = "misc",
                                        target = finishpart,
                                        color = Challenges.finish_color.Value,
                                        healthbar = false,
                                        nametag = Challenges.nametag.Value,
                                        custom_nametag = vname.." Finish",
                                        distance = Challenges.distance.Value,
                                        custom_distance = ""..finishpart_distance,
                                        tracer = Challenges.tracer.Value,
                                        tracer_type = Current_tracer_type,
                                        box_type = Current_box_type
                                    })
                                end
                            end
                            
                            if startpart_distance < Challenges.distance_limit.Value then
                                if _G.IsOnScreen(startpart_screen_pos) then
                                    Lib_esp.draw({
                                        esp_type = "misc",
                                        target = startpart,
                                        color = Challenges.start_color.Value,
                                        healthbar = false,
                                        nametag = Challenges.nametag.Value,
                                        custom_nametag = vname.." Start",
                                        distance = Challenges.distance.Value,
                                        custom_distance = ""..startpart_distance,
                                        tracer = Challenges.tracer.Value,
                                        tracer_type = Current_tracer_type,
                                        box_type = Current_box_type
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end
        if _G.ChallengesTask then
            _G.ChallengesTask()
        end
    end
end

if Hidden_Tabs.scrap.Value == false then
    Tabs.scrap = Interface:AddTab("Scrap")
    Groupboxes.scrap = Tabs.scrap:AddMiddleGroupbox("Scrap");
    Groupboxes.scrap_config = Tabs.scrap:AddMiddleGroupbox("Scrap Config");
    Scrap = {
        enabled = Groupboxes.scrap
            :AddToggle({
                Default = Config.scrap.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[scrap] Enabled ESP" or "[scrap] Disabled ESP", 1)
            end);

        distance = Groupboxes.scrap
            :AddToggle({
                Default = Config.scrap.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[scrap] Enabled Distance" or "[scrap] Disabled Distance", 1)
            end);

        nametag = Groupboxes.scrap
            :AddToggle({
                Default = Config.scrap.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[scrap] Enabled Nametag" or "[scrap] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.scrap
            :AddToggle({
                Default = Config.scrap.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[scrap] Enabled Tracer" or "[scrap] Disabled Tracer", 1)
            end);

        color = Groupboxes.scrap:AddColorPicker({
            Default = Config.scrap.color;
            Text = "Color";
        });

        distance_limit = Groupboxes.scrap:AddSlider({
            Default = Config.scrap.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }
    Scrap_config = {}
    for _, tab in ipairs(Config.scrap.entries) do
        local name = tab.name
        local Enabled = tab.Enabled

        Scrap_config[name.."_enabled"] = Groupboxes.scrap_config
            :AddToggle({
                Default = Enabled;
                Text = name.." ESP Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[scrap] Enabled "..name.." ESP" or "[scrap] Disabled "..name.." ESP", 1)
            end)
    end

    if _G.ScrapCache == nil then
        _G.ScrapCache = {}
    else
        for i, cached_tab in pairs(_G.ScrapCache) do
            if not cached_tab.last_update or (os.clock() - cached_tab.last_update) > Debugging.scrap_cache_cleanup_timer.Value then
                _G.ScrapCache[i] = nil
            end
        end
    end

    if Scrap.enabled.Value then
        Raycastignore_folder = dx9.FindFirstChild(Workspace, "RaycastIgnore")
        if Raycastignore_folder ~= nil and Raycastignore_folder ~= 0 then
            if _G.GetScrapNameFromModel == nil then
                _G.GetScrapNameFromModel = function(v)
                    local name = nil

                    local model = dx9.FindFirstChild(v, "Model")
                    if model ~= nil and model ~= 0 then
                        --Capacitor
                        local cube006 = dx9.FindFirstChild(model, "Cube.006")
                        local cables = dx9.FindFirstChild(model, "cables")
                        local port = dx9.FindFirstChild(model, "port")
                        if cube006 ~= nil and cube006 ~= 0 then
                            name = "Capacitor"
                            return name
                        end
                        if cables ~= nil and cables ~= 0 then
                            name = "Capacitor"
                            return name
                        end
                        if port ~= nil and port ~= 0 then
                            name = "Capacitor"
                            return name
                        end

                        --PulseGenerator
                        local rod003 = dx9.FindFirstChild(model, "rod.003")
                        local neon002 = dx9.FindFirstChild(model, "neon.002")
                        if rod003 ~= nil and rod003 ~= 0 then
                            name = "PulseGenerator"
                            return name
                        end
                        if neon002 ~= nil and neon002 ~= 0 then
                            name = "PulseGenerator"
                            return name
                        end

                        --RailTrigger
                        local cylinder023 = dx9.FindFirstChild(model, "rod.003")
                        local cylinder041 = dx9.FindFirstChild(model, "rod.003")
                        if cylinder023 ~= nil and cylinder023 ~= 0 then
                            name = "RailTrigger"
                            return name
                        end
                        if cylinder041 ~= nil and cylinder041 ~= 0 then
                            name = "RailTrigger"
                            return name
                        end

                        --MagnetomotiveCalibrator
                        local buttons = dx9.FindFirstChild(model, "buttons")
                        local body002 = dx9.FindFirstChild(model, "body.002")
                        if buttons ~= nil and buttons ~= 0 then
                            name = "MagnetomotiveCalibrator"
                            return name
                        end
                        if body002 ~= nil and body002 ~= 0 then
                            name = "MagnetomotiveCalibrator"
                            return name
                        end
                    end

                    --Battery
                    local body004 = dx9.FindFirstChild(v, "body.004")
                    if body004 ~= nil and body004 ~= 0 then
                        name = "Battery"
                        return name
                    end

                    --Scrap
                    local cog_lp = dx9.FindFirstChild(v, "cog_lp")
                    local pipe = dx9.FindFirstChild(v, "pipe")
                    if cog_lp ~= nil and cog_lp ~= 0 then
                        name = "Scrap"
                        return name
                    end
                    if pipe ~= nil and pipe ~= 0 then
                        name = "Scrap"
                        return name
                    end

                    --BatteryLarge
                    local top = dx9.FindFirstChild(v, "top")
                    local body005 = dx9.FindFirstChild(v, "body.005")
                    if top ~= nil and top ~= 0 then
                        name = "BatteryLarge"
                        return name
                    end
                    if body005 ~= nil and body005 ~= 0 then
                        name = "BatteryLarge"
                        return name
                    end

                    --DriveRare
                    local port = dx9.FindFirstChild(v, "port")
                    local body006 = dx9.FindFirstChild(v, "body.006")
                    local neon001 = dx9.FindFirstChild(v, "neon.001")
                    if port ~= nil and port ~= 0 then
                        name = "DriveRare"
                        return name
                    end
                    if body006 ~= nil and body006 ~= 0 then
                        name = "DriveRare"
                        return name
                    end
                    if neon001 ~= nil and neon001 ~= 0 then
                        name = "DriveRare"
                        return name
                    end

                    --Jewelry
                    local gildedbracelet = dx9.FindFirstChild(v, "gilded bracelet")
                    if gildedbracelet ~= nil and gildedbracelet ~= 0 then
                        name = "Jewelry"
                        return name
                    end

                    --JewelryRare
                    local studdedbracelet = dx9.FindFirstChild(v, "studdedbracelet")
                    if studdedbracelet ~= nil and studdedbracelet ~= 0 then
                        name = "JewelryRare"
                        return name
                    end

                    --JewelryUncommon
                    local silverbracelet = dx9.FindFirstChild(v, "silver bracelet")
                    if silverbracelet ~= nil and silverbracelet ~= 0 then
                        name = "JewelryUncommon"
                        return name
                    end

                    --Laptop
                    local stand_lp = dx9.FindFirstChild(v, "stand_lp")
                    local frame = dx9.FindFirstChild(v, "frame")
                    local screen = dx9.FindFirstChild(v, "screen")
                    if stand_lp ~= nil and stand_lp ~= 0 then
                        name = "Laptop"
                        return name
                    end
                    if frame ~= nil and frame ~= 0 then
                        name = "Laptop"
                        return name
                    end
                    if screen ~= nil and screen ~= 0 then
                        name = "Laptop"
                        return name
                    end

                    --MobilePhone, Tablet, Phone
                    local body = dx9.FindFirstChild(v, "body")
                    local screen001 = dx9.FindFirstChild(v, "screen.001")
                    if body ~= nil and body ~= 0 then
                        name = "MobileDevice"
                        return name
                    end
                    if screen001 ~= nil and screen001 ~= 0 then
                        name = "MobileDevice"
                        return name
                    end

                    --Thumbdrive
                    local body003 = dx9.FindFirstChild(v, "body.003")
                    local neon = dx9.FindFirstChild(v, "neon")
                    local usb001 = dx9.FindFirstChild(v, "USB.001")
                    if body003 ~= nil and body003 ~= 0 then
                        name = "Thumbdrive"
                        return name
                    end
                    if neon ~= nil and neon ~= 0 then
                        name = "Thumbdrive"
                        return name
                    end
                    if usb001 ~= nil and usb001 ~= 0 then
                        name = "Thumbdrive"
                        return name
                    end

                    --ThumbdriveRare
                    local enc = dx9.FindFirstChild(v, "enc")
                    if enc ~= nil and enc ~= 0 then
                        name = "ThumbdriveRare"
                        return name
                    end

                    --Trash
                    local milkcarton2 = dx9.FindFirstChild(v, "Milk Carton 2")
                    local crushedsodacan1 = dx9.FindFirstChild(v, "Crushed Soda Can 1")
                    local sodacup1 = dx9.FindFirstChild(v, "Soda Cup 1")
                    if milkcarton2 ~= nil and milkcarton2 ~= 0 then
                        name = "Trash"
                        return name
                    end
                    if crushedsodacan1 ~= nil and crushedsodacan1 ~= 0 then
                        name = "Trash"
                        return name
                    end
                    if sodacup1 ~= nil and sodacup1 ~= 0 then
                        name = "Trash"
                        return name
                    end

                    --DeliveryPackage
                    local detail_low = dx9.FindFirstChild(v, "detail_low")
                    local inside_low = dx9.FindFirstChild(v, "inside_low")
                    local metal_low = dx9.FindFirstChild(v, "metal_low")
                    local topfront = dx9.FindFirstChild(v, "topfront")
                    local top_low = dx9.FindFirstChild(v, "top_low")
                    if detail_low ~= nil and detail_low ~= 0 then
                        name = "DeliveryPackage"
                        return name
                    end
                    if inside_low ~= nil and inside_low ~= 0 then
                        name = "DeliveryPackage"
                        return name
                    end
                    if metal_low ~= nil and metal_low ~= 0 then
                        name = "DeliveryPackage"
                        return name
                    end
                    if topfront ~= nil and topfront ~= 0 then
                        name = "DeliveryPackage"
                        return name
                    end
                    if top_low ~= nil and top_low ~= 0 then
                        name = "DeliveryPackage"
                        return name
                    end

                    --Cloth
                    local clothmesh = dx9.FindFirstChild(v, "ClothMesh")
                    if clothmesh ~= nil and clothmesh ~= 0 then
                        name = "Cloth"
                        return name
                    end

                    --DuctTape
                    local meshblock = dx9.FindFirstChild(v, "meshblock")
                    if meshblock ~= nil and meshblock ~= 0 then
                        name = "DuctTape"
                        return name
                    end

                    --YankMod1
                    local main = dx9.FindFirstChild(v, "main")
                    local misc = dx9.FindFirstChild(v, "misc")
                    local wire = dx9.FindFirstChild(v, "wire")
                    if main ~= nil and main ~= 0 then
                        name = "YankMod1"
                        return name
                    end
                    if misc ~= nil and misc ~= 0 then
                        name = "YankMod1"
                        return name
                    end
                    if wire ~= nil and wire ~= 0 then
                        name = "YankMod1"
                        return name
                    end

                    --GrapplerCore
                    local winchmountdisplay = dx9.FindFirstChild(v, "winchmountdisplay")
                    if winchmountdisplay ~= nil and winchmountdisplay ~= 0 then
                        name = "GrapplerCore"
                        return name
                    end

                    --GrapplerPart3
                    local magalloyhookDISP = dx9.FindFirstChild(v, "magalloyhookDISP")
                    if magalloyhookDISP ~= nil and magalloyhookDISP ~= 0 then
                        name = "GrapplerPart3"
                        return name
                    end

                    --GrapplerPart4
                    local cube001 = dx9.FindFirstChild(v, "Cube.001")
                    local cylinder015 = dx9.FindFirstChild(v, "Cylinder.015")
                    local corethingwhat = dx9.FindFirstChild(v, "core thing what")
                    if cube001 ~= nil and cube001 ~= 0 then
                        name = "GrapplerPart4"
                        return name
                    end
                    if cylinder015 ~= nil and cylinder015 ~= 0 then
                        name = "GrapplerPart4"
                        return name
                    end
                    if corethingwhat ~= nil and corethingwhat ~= 0 then
                        name = "GrapplerPart4"
                        return name
                    end

                    --YankMod2
                    local emag = dx9.FindFirstChild(v, "emag")
                    if emag ~= nil and emag ~= 0 then
                        name = "YankMod2"
                        return name
                    end

                    --GrapplerPart1
                    local meshesnuts2 = dx9.FindFirstChild(v, "Meshes/Nuts (2)")
                    if meshesnuts2 ~= nil and meshesnuts2 ~= 0 then
                        name = "GrapplerPart1"
                        return name
                    end

                    --GripTape, SlickWrap
                    local roll = dx9.FindFirstChild(v, "roll")
                    if roll ~= nil and roll ~= 0 then
                        name = "Roll"
                        return name
                    end

                    --AluminumCasing
                    local aluminumcasing = dx9.FindFirstChild(v, "AluminumCasing")
                    if aluminumcasing ~= nil and aluminumcasing ~= 0 then
                        name = "AluminumCasing"
                        return name
                    end

                    --MagneticCoil
                    local cylinder038 = dx9.FindFirstChild(v, "Cylinder.038")
                    local cylinder032 = dx9.FindFirstChild(v, "Cylinder.032")
                    if cylinder038 ~= nil and cylinder038 ~= 0 then
                        name = "MagneticCoil"
                        return name
                    end
                    if cylinder032 ~= nil and cylinder032 ~= 0 then
                        name = "MagneticCoil"
                        return name
                    end

                    return name
                end
            end

            if _G.RaycastIgnoreTask == nil then
                _G.RaycastIgnoreTask = function()
                    Raycastignore_children = dx9.GetChildren(Raycastignore_folder)
                    if Raycastignore_children then
                        if type(Raycastignore_children) == "table" then
                            for i,v in ipairs(Raycastignore_children) do
                                local cached_tab = _G.ScrapCache[tostring(v)]
                                if not cached_tab then
                                    if dx9.GetType(v) == "Model" then                    
                                        local part = dx9.FindFirstChild(v, "Part")
                                        if part == nil or part == 0 then
                                            part = dx9.FindFirstChild(v, "Main")
                                        end
                                        if part ~= nil and part ~= 0 then
                                            if dx9.GetType(part) == "Part" then
                                                local name = _G.GetScrapNameFromModel(v) or "Other"
                                                _G.ScrapCache[tostring(v)] = {
                                                    part = part;
                                                    name = name;
                                                    last_update = os.clock();
                                                }
                                            end
                                        end
                                    end
                                elseif cached_tab then
                                    _G.ScrapCache[tostring(v)].last_update = os.clock()
                                end
                            end
                        end
                    end
                    for i,t in pairs(_G.ScrapCache) do
                        local skipThis = true
                        local isType = 0

                        if skipThis == true then
                            local scrap_config_tab = Scrap_config[t.name.."_enabled"]
                            if scrap_config_tab then
                                isType = 1
                                if scrap_config_tab.Value then
                                    skipThis = false
                                end
                            end
                        end

                        local typeTab = nil
                        local typeConfigSettings = nil
                        local typeConfig = nil
                        if isType == 1 then
                            typeTab = Scrap
                            typeConfigSettings = Config.scrap
                            typeConfig = Scrap_config
                        elseif isType == 0 then
                            if _G.consoleEnabled == true then
                                print("Unknown Scrap Found: '"..t.name.."'")
                            end
                            typeTab = Scrap
                            typeConfigSettings = Config.scrap
                            typeConfig = Scrap_config
                            skipThis = false
                        end

                        if not skipThis and typeTab and typeConfigSettings and typeConfig then
                            local my_root_pos = dx9.GetPosition(My_root)
                            local pos = dx9.GetPosition(t.part)
                            local distance = _G.Get_Distance(my_root_pos, pos)
                            local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                            
                            if _G.IsOnScreen(screen_pos) then
                                if distance < Scrap.distance_limit.Value then
                                    Lib_esp.draw({
                                        esp_type = "misc",
                                        target = t.part,
                                        color = Scrap.color.Value,
                                        healthbar = false,
                                        nametag = Scrap.nametag.Value,
                                        custom_nametag = t.name,
                                        distance = Scrap.distance.Value,
                                        custom_distance = ""..distance,
                                        tracer = Scrap.tracer.Value,
                                        tracer_type = Current_tracer_type,
                                        box_type = Current_box_type
                                    })
                                end
                            end
                        end
                    end
                end
            end
            if _G.RaycastIgnoreTask then
                _G.RaycastIgnoreTask()
            end
        end
    end
end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= Config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end