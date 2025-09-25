--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

--TODO:
--  finish adding the Other category
--  add teleport support (a Toggle in the Master settings that then shows the teleport panels in each tab)
--  ItemSpawns MAYBE... but I really don't think that is at all necessary if we have Scrap ESP

--If you don't want a super long list, feel free to set _G.Enemiesconfig to your own table before using loadstring on this script
Enemiesconfig = _G.Enemiesconfig or {
    {
		name = "Other";
		Enabled = true;
	};
    {
		name = "Buni";
		Enabled = false;
	};
    {
		name = "PlainsWoof";
		Enabled = false;
	};
    {
		name = "DireBuni";
		Enabled = false;
	};
}
if _G.Enemiesconfig == nil then
	_G.Enemiesconfig = Enemiesconfig
	Enemiesconfig = _G.Enemiesconfig
end

HiddenTabsconfig = _G.HiddenTabsconfig or {
    {
        tab = "players";
        hidden = false;
    };
    {
        tab = "enemies";
        hidden = false;
    };
    {
        tab = "interactables";
        hidden = false;
    };
    {
        tab = "shrines";
        hidden = false;
    };
    {
        tab = "lostshrines";
        hidden = false;
    };
    {
        tab = "others";
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
        Repr = "https://raw.githubusercontent.com/Ozzypig/repr/refs/heads/master/repr.lua"
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
        healthbar = true;
		healthtag = true;
		maxhealthtag = true;
        nametag = true;
        tracer = false;
		color = { 0, 255, 0 };
		distance_limit = 10000;
    };
    enemies = {
		enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 0, 0 };
		distance_limit = 10000;
	};
    interactables = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 50, 255, 255 };
		distance_limit = 10000;
	};
    shrines = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 50, 255, 255 };
		distance_limit = 10000;
	};
    lostshrines = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 50, 255, 255 };
		distance_limit = 10000;
	};
    infusers = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 225, 0, 0 };
		distance_limit = 10000;
	};
    others = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		start_color = { 225, 0, 0 };
        finish_color = { 225, 0, 0 };
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

Repr = loadstring(dx9.Get(Config.urls.Repr))()

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "VoxlBlade | dx9ware | By @Brycki";
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

ReprSettings = {
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
                Lib_ui:Notify(value and "[Players] Enabled ESP" or "[Players] Disabled ESP", 1)
            end);

        distance = Groupboxes.players
            :AddToggle({
                Default = Config.players.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Players] Enabled Distance" or "[Players] Disabled Distance", 1)
            end);

        healthbar = Groupboxes.players:AddToggle({
                Default = Config.players.healthbar;
                Text = "HealthBar";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Players] Enabled HealthBar" or "[Players] Disabled HealthBar", 1)
            end);

        healthtag = Groupboxes.players:AddToggle({
                Default = Config.players.healthtag;
                Text = "HealthTag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Players] Enabled HealthTag" or "[Players] Disabled HealthTag", 1)
            end);

        maxhealthtag = Groupboxes.players:AddToggle({
                Default = Config.players.maxhealthtag;
                Text = "MaxHealthTag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Players] Enabled MaxHealthTag" or "[Players] Disabled MaxHealthTag", 1)
            end);

        nametag = Groupboxes.players
            :AddToggle({
                Default = Config.players.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Players] Enabled Nametag" or "[Players] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.players
            :AddToggle({
                Default = Config.players.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Players] Enabled Tracer" or "[Players] Disabled Tracer", 1)
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
                            local character = dx9.FindFirstChild(Workspace, playerName)
                            if character and character ~= 0 then
                                local root = dx9.FindFirstChild(character, "HumanoidRootPart")
                                local head = dx9.FindFirstChild(character, "Head")
                                local humanoid = dx9.FindFirstChild(character, "Humanoid")

                                if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
                                    local health = dx9.GetHealth(humanoid) or nil
                                    local maxhealth = dx9.GetMaxHealth(humanoid) or nil
                                    if health ~= nil then
                                        health = math.floor(health)
                                    end
                                    if maxhealth ~= nil then
                                        maxhealth = math.floor(maxhealth)
                                    end

                                    local my_root_pos = dx9.GetPosition(My_root)
                                    local root_pos = dx9.GetPosition(root)
                                    --local head_pos = dx9.GetPosition(head)
                                    local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                                    local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                                    --local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

                                    --local screen_pos = root_screen_pos

                                    if _G.IsOnScreen(root_screen_pos) then
                                        if root_distance < Players.distance_limit.Value then
                                            local customName = playerName
                                            if Players.healthtag.Value and Players.maxhealthtag.Value and health ~= nil and maxhealth ~= nil then
                                                customName = playerName .. " | " .. tostring(health) .. "/" .. tostring(maxhealth) .. " hp"
                                            elseif Players.healthtag.Value and health ~= nil then
                                                customName = playerName .. " | " .. tostring(health) .. " hp"
                                            end	
                                            Lib_esp.draw({
                                                target = character;
                                                color = Players.color.Value;
                                                healthbar = Players.healthbar.Value;
                                                nametag = Players.nametag.Value;
                                                custom_nametag = customName;
                                                distance = Players.distance.Value;
                                                custom_distance = ""..root_distance;
                                                tracer = Players.tracer.Value;
                                                tracer_type = Current_tracer_type;
                                                box_type = Current_box_type;
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

if Hidden_Tabs.enemies.Value == false then
    Tabs.enemies = Interface:AddTab("Enemies")
    Groupboxes.enemies = Tabs.enemies:AddMiddleGroupbox("Enemies");
    Enemies = {
        enabled = Groupboxes.enemies
            :AddToggle({
                Default = Config.enemies.enabled;
                Text = "Enabled";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Enemies] Enabled ESP" or "[Enemies] Disabled ESP", 1)
            end);

        distance = Groupboxes.enemies
            :AddToggle({
                Default = Config.enemies.distance;
                Text = "Distance";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Enemies] Enabled Distance" or "[Enemies] Disabled Distance", 1)
            end);
        
        nametag = Groupboxes.enemies
            :AddToggle({
                Default = Config.enemies.nametag;
                Text = "Nametag";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Enemies] Enabled Nametag" or "[Enemies] Disabled Nametag", 1)
            end);

        tracer = Groupboxes.enemies
            :AddToggle({
                Default = Config.enemies.tracer;
                Text = "Tracer";
            })
            :OnChanged(function(value)
                Lib_ui:Notify(value and "[Enemies] Enabled Tracer" or "[Enemies] Disabled Tracer", 1)
            end);

        color = Groupboxes.enemies:AddColorPicker({
            Default = Config.enemies.color;
            Text = "Color";
        });

        distance_limit = Groupboxes.enemies:AddSlider({
            Default = Config.enemies.distance_limit;
            Text = "ESP Distance Limit";
            Min = 0;
            Max = 10000;
            Rounding = 0;
        });
    }
    if Master_esp_settings.enabled.Value then
        if Enemies.enabled.Value then
            if _G.EnemiesTask == nil then
                _G.EnemiesTask = function()
                    NPCS_folder = dx9.FindFirstChild(Workspace, "NPCS")
                    if NPCS_folder and NPCS_folder ~= 0 then
                        NPCS_children = dx9.GetChildren(NPCS_folder)
                        if NPCS_children then
                            if type(NPCS_children) == "table" then
                                for i,root in ipairs(NPCS_children) do
                                    if dx9.GetType(root) == "MeshPart" then
                                        local my_root_pos = dx9.GetPosition(My_root)
                                        local enemy_name = dx9.GetName(root)
                                        local root_pos = dx9.GetPosition(root)
                                        local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                                        local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                                        if _G.IsOnScreen(root_screen_pos) then
                                            if root_distance < Players.distance_limit.Value then
                                                Lib_esp.draw({
                                                    esp_type = "misc",
                                                    target = root,
                                                    color = Enemies.color.Value,
                                                    healthbar = false,
                                                    nametag = Enemies.nametag.Value,
                                                    custom_nametag = enemy_name,
                                                    distance = Enemies.distance.Value,
                                                    custom_distance = ""..root_distance,
                                                    tracer = Enemies.tracer.Value,
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
                end
            end
            if _G.EnemiesTask then
                _G.EnemiesTask()
            end
        end
    end
end

--[[
if _G.Rescanning == nil then
    _G.Rescanning = false
end
if _G.Rescan == nil then
    _G.Rescan = function()
        if _G.Rescanning == false then
            _G.Rescanning = true

            if _G.PersistentCache == nil then
                _G.PersistentCache = {
                    Interactables = {};
                    Shrines = {};
                    Lostshrines = {};
                    Infusers = {};
                    Others = {};
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
                    Interactables_folder = dx9.FindFirstChild(Workspace, "Interactables")
                    if Interactables_folder and Interactables_folder ~= 0 then
                        Interactables_children = dx9.GetChildren(Interactables_children)
                        if Interactables_children then
                            if type(Interactables_children) == "table" then
                                for i,v in ipairs(Interactables_children) do

                                end
                            end
                        end
                    end

                    Shrines_folder = dx9.FindFirstChild(Workspace, "Shrines")


                    Lostshrines_folder = dx9.FindFirstChild(Workspace, "LostShrines")


                    Infusers_folder = dx9.FindFirstChild(Worskpace, "Infusers")


                    Others = dx9.FindFirstChild(Workspace, "Others")



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
                print(Repr(_G.PersistentCache, ReprSettings))
            end

            _G.Rescanning = false
        end
    end
    _G.Rescan()
end
]]

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