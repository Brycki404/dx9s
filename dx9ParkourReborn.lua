--indent size 4
local startTime = os.clock()

--TODO:
--  add hiding tabs support (Toggles in Master settings to hide tabs that you want hidden)
--  split timetrials and challenges into starts and finishes
--  finish adding the Other category
--  add teleport support (a Toggle in the Master settings that then shows the teleport panels in each tab)
--  CACHE ALL FOLDERS AND CHILDREN TABLES THAT ARE PERMANENT AND DON'T CHANGE FOR SPEED OPTIMIZATION
--  ItemSpawns MAYBE... but I really don't think that is at all necessary if we have Scrap ESP
    
--If you don't want a super long list, feel free to set _G.scrapconfig to your own table before using loadstring on this script
scrapconfig = _G.scrapconfig or {
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
if _G.scrapconfig == nil then
	_G.scrapconfig = scrapconfig
	scrapconfig = _G.scrapconfig
end

--If you don't want a super long list, feel free to set _G.loiterspotsconfig to your own table before using loadstring on this script
loiterspotsconfig = _G.loiterspotsconfig or {
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
if _G.loiterspotsconfig == nil then
	_G.loiterspotsconfig = loiterspotsconfig
	loiterspotsconfig = _G.loiterspotsconfig
end

config = _G.config or {
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
		entries = loiterspotsconfig;
	};
    scrap = {
        enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 255, 255 };
		distance_limit = 10000;
		entries = scrapconfig;
	};
};
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

if _G.countTableEntries == nil then
	_G.countTableEntries = function(t)
		local count = 0
		if t then
			for _ in pairs(t) do
				count = count + 1
			end
		end
		return count
	end
end
countTableEntries = _G.countTableEntries

repr = loadstring(dx9.Get(config.urls.repr))()

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

lib_esp = loadstring(dx9.Get(config.urls.LibESP))()

interface = lib_ui:CreateWindow({
	Title = "Parkour Reborn | dx9ware | By @Brycki";
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
	players = interface:AddTab("Players");
    missions = interface:AddTab("Missions");
    checkpoints = interface:AddTab("Checkpoints");
	xp_multipliers = interface:AddTab("XP Multipliers");
    races = interface:AddTab("Races");
    other = interface:AddTab("Other");
    --item_spawns = interface:AddTab("Item Spawns");
    scrap = interface:AddTab("Scrap");
}

if lib_ui.FirstRun then
    tabs.settings:Focus()
end

groupboxes = {
    debug = tabs.settings:AddMiddleGroupbox("Debugging");
	master_esp_settings = tabs.settings:AddMiddleGroupbox("Master ESP");
	players = tabs.players:AddMiddleGroupbox("Players");
    missions = tabs.missions:AddMiddleGroupbox("Missions");
    antennas = tabs.checkpoints:AddMiddleGroupbox("Respawn Antennas");
    checkpoints = tabs.checkpoints:AddMiddleGroupbox("Blinky Checkpoints");
    routers = tabs.xp_multipliers:AddMiddleGroupbox("Routers");
    timetrials = tabs.races:AddLeftGroupbox("Time Trials");
    challenges = tabs.races:AddRightGroupbox("Challenges");
    --secret_runaway_messages = tabs.other:AddMiddleGroupbox("Secret Runaway Messages");
        --Workspace.World.SecretRunawayMessages.PART
    --easter_egg_switch_1 = tabs.other:AddMiddleGroupbox("Easter Egg Switch 1");
        --Workspace.World.EasterEggSwitch1.Part
    --loiter_spots = tabs.other:AddMiddleGroupbox("Loiter Spots");
        --Workspace.World.LoiterSpots.Spots.MODEL.Root
    --loiter_spots_config = tabs.other:AddMiddleGroupbox("Loiter Spots Config");
        --SkyarcLayOut, DirwickChairSpot, Spot, Railingspot
    --collectible_spawns = tabs.item_spawns:AddMiddleGroupbox("Collectibles");
        --Workspace.World.ItemSpawns.Collectibles --IDK YET? Empty?
    --delivery_spawns = tabs.item_spawns:AddMiddleGroupbox("Deliveries");
        --Workspace.World.ItemSpawns.Deliveries.DeliverySpawn_PART
    --valuable_spawns = tabs.item_spawns:AddMiddleGroupbox("Valuables");
        --Workspace.World.ItemSpawns.Valuables.MODEL.PARTS_MESHPARTS_UNIONS
	scrap = tabs.scrap:AddMiddleGroupbox("Scrap");
	scrap_config = tabs.scrap:AddMiddleGroupbox("Scrap Config");
}

--Workspace.World.Props.Dynamics
--Workspace.World.Props.Animated
--Workspace.World.SwingPoints(Folder of Parts)

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
debugging.scrap_cache_cleanup_timer = groupboxes.debug:AddSlider({
    Default = config.settings.cache_cleanup_timer;
    Text = "ScrapCache Cleanup Timer";
    Min = 0;
    Max = 10;
    Rounding = 1;
});
debugging.scrap_cache_size = groupboxes.debug:AddLabel("Scrap Cache Size: "..tostring(countTableEntries(_G.ScrapCache or {}) or 0))

master_esp_settings = {
	enabled = groupboxes.master_esp_settings
		:AddToggle({
			Default = config.settings.master_esp_enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Master ESP" or "[settings] Disabled Master ESP", 1)
		end);

	box_type = groupboxes.master_esp_settings
		:AddDropdown({
			Text = "Box Type";
			Default = config.settings.box_type;
			Values = { "Corners", "2D Box", "3D Box" };
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Box Type: " .. value, 1)
		end);

	tracer_type = groupboxes.master_esp_settings
		:AddDropdown({
			Text = "Tracer Type";
			Default = config.settings.tracer_type;
			Values = { "Near-Bottom", "Bottom", "Top", "Mouse" };
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Tracer Type: " .. value, 1)
		end);
}

players = {
	enabled = groupboxes.players
		:AddToggle({
			Default = config.players.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled ESP" or "[players] Disabled ESP", 1)
		end);

	distance = groupboxes.players
		:AddToggle({
			Default = config.players.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled Distance" or "[players] Disabled Distance", 1)
		end);
    
	nametag = groupboxes.players
		:AddToggle({
			Default = config.players.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled Nametag" or "[players] Disabled Nametag", 1)
		end);

	tracer = groupboxes.players
		:AddToggle({
			Default = config.players.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled Tracer" or "[players] Disabled Tracer", 1)
		end);

	color = groupboxes.players:AddColorPicker({
		Default = config.players.color;
		Text = "Color";
	});

    distance_limit = groupboxes.players:AddSlider({
		Default = config.players.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

missions = {
	enabled = groupboxes.missions
		:AddToggle({
			Default = config.missions.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[missions] Enabled ESP" or "[missions] Disabled ESP", 1)
		end);

	distance = groupboxes.missions
		:AddToggle({
			Default = config.missions.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[missions] Enabled Distance" or "[missions] Disabled Distance", 1)
		end);

	nametag = groupboxes.missions
		:AddToggle({
			Default = config.missions.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[missions] Enabled Nametag" or "[missions] Disabled Nametag", 1)
		end);

	tracer = groupboxes.missions
		:AddToggle({
			Default = config.missions.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[missions] Enabled Tracer" or "[missions] Disabled Tracer", 1)
		end);

    color = groupboxes.missions:AddColorPicker({
		Default = config.missions.color;
		Text = "Color";
	});

	distance_limit = groupboxes.missions:AddSlider({
		Default = config.missions.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

antennas = {
	enabled = groupboxes.antennas
		:AddToggle({
			Default = config.antennas.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[antennas] Enabled ESP" or "[antennas] Disabled ESP", 1)
		end);

	distance = groupboxes.antennas
		:AddToggle({
			Default = config.antennas.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[antennas] Enabled Distance" or "[antennas] Disabled Distance", 1)
		end);

	nametag = groupboxes.antennas
		:AddToggle({
			Default = config.antennas.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[antennas] Enabled Nametag" or "[antennas] Disabled Nametag", 1)
		end);

	tracer = groupboxes.antennas
		:AddToggle({
			Default = config.antennas.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[antennas] Enabled Tracer" or "[antennas] Disabled Tracer", 1)
		end);

    color = groupboxes.antennas:AddColorPicker({
		Default = config.antennas.color;
		Text = "Color";
	});

	distance_limit = groupboxes.antennas:AddSlider({
		Default = config.antennas.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

checkpoints = {
	enabled = groupboxes.checkpoints
		:AddToggle({
			Default = config.checkpoints.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[checkpoints] Enabled ESP" or "[checkpoints] Disabled ESP", 1)
		end);

	distance = groupboxes.checkpoints
		:AddToggle({
			Default = config.checkpoints.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[checkpoints] Enabled Distance" or "[checkpoints] Disabled Distance", 1)
		end);

	nametag = groupboxes.checkpoints
		:AddToggle({
			Default = config.checkpoints.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[checkpoints] Enabled Nametag" or "[checkpoints] Disabled Nametag", 1)
		end);

	tracer = groupboxes.checkpoints
		:AddToggle({
			Default = config.checkpoints.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[checkpoints] Enabled Tracer" or "[checkpoints] Disabled Tracer", 1)
		end);

    color = groupboxes.checkpoints:AddColorPicker({
		Default = config.checkpoints.color;
		Text = "Color";
	});

	distance_limit = groupboxes.checkpoints:AddSlider({
		Default = config.checkpoints.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

routers = {
	enabled = groupboxes.routers
		:AddToggle({
			Default = config.routers.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[routers] Enabled ESP" or "[routers] Disabled ESP", 1)
		end);

	distance = groupboxes.routers
		:AddToggle({
			Default = config.routers.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[routers] Enabled Distance" or "[routers] Disabled Distance", 1)
		end);

	nametag = groupboxes.routers
		:AddToggle({
			Default = config.routers.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[routers] Enabled Nametag" or "[routers] Disabled Nametag", 1)
		end);

	tracer = groupboxes.routers
		:AddToggle({
			Default = config.routers.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[routers] Enabled Tracer" or "[routers] Disabled Tracer", 1)
		end);

    color = groupboxes.routers:AddColorPicker({
		Default = config.routers.color;
		Text = "Color";
	});

	distance_limit = groupboxes.routers:AddSlider({
		Default = config.routers.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

timetrials = {
	enabled = groupboxes.timetrials
		:AddToggle({
			Default = config.timetrials.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[timetrials] Enabled ESP" or "[timetrials] Disabled ESP", 1)
		end);

	distance = groupboxes.timetrials
		:AddToggle({
			Default = config.timetrials.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[timetrials] Enabled Distance" or "[timetrials] Disabled Distance", 1)
		end);

	nametag = groupboxes.timetrials
		:AddToggle({
			Default = config.timetrials.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[timetrials] Enabled Nametag" or "[timetrials] Disabled Nametag", 1)
		end);

	tracer = groupboxes.timetrials
		:AddToggle({
			Default = config.timetrials.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[timetrials] Enabled Tracer" or "[timetrials] Disabled Tracer", 1)
		end);

    start_color = groupboxes.timetrials:AddColorPicker({
		Default = config.timetrials.start_color;
		Text = "Start Color";
	});

    finish_color = groupboxes.timetrials:AddColorPicker({
		Default = config.timetrials.finish_color;
		Text = "Finish Color";
	});

	distance_limit = groupboxes.timetrials:AddSlider({
		Default = config.timetrials.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

challenges = {
	enabled = groupboxes.challenges
		:AddToggle({
			Default = config.challenges.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[challenges] Enabled ESP" or "[challenges] Disabled ESP", 1)
		end);

	distance = groupboxes.challenges
		:AddToggle({
			Default = config.challenges.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[challenges] Enabled Distance" or "[challenges] Disabled Distance", 1)
		end);

	nametag = groupboxes.challenges
		:AddToggle({
			Default = config.challenges.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[challenges] Enabled Nametag" or "[challenges] Disabled Nametag", 1)
		end);

	tracer = groupboxes.challenges
		:AddToggle({
			Default = config.challenges.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[challenges] Enabled Tracer" or "[challenges] Disabled Tracer", 1)
		end);

    start_color = groupboxes.challenges:AddColorPicker({
		Default = config.challenges.start_color;
		Text = "Start Color";
	});
    
    finish_color = groupboxes.challenges:AddColorPicker({
		Default = config.challenges.finish_color;
		Text = "Finish Color";
	});

	distance_limit = groupboxes.challenges:AddSlider({
		Default = config.challenges.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

--[[
secret_runaway_messages = {
	enabled = groupboxes.secret_runaway_messages
		:AddToggle({
			Default = config.secret_runaway_messages.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[secret runaway messages] Enabled ESP" or "[secret runaway messages] Disabled ESP", 1)
		end);

	distance = groupboxes.secret_runaway_messages
		:AddToggle({
			Default = config.secret_runaway_messages.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[secret runaway messages] Enabled Distance" or "[secret runaway messages] Disabled Distance", 1)
		end);

	nametag = groupboxes.secret_runaway_messages
		:AddToggle({
			Default = config.secret_runaway_messages.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[secret runaway messages] Enabled Nametag" or "[secret runaway messages] Disabled Nametag", 1)
		end);

	tracer = groupboxes.secret_runaway_messages
		:AddToggle({
			Default = config.secret_runaway_messages.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[secret runaway messages] Enabled Tracer" or "[secret runaway messages] Disabled Tracer", 1)
		end);

    color = groupboxes.secret_runaway_messages:AddColorPicker({
		Default = config.secret_runaway_messages.color;
		Text = "Color";
	});

	distance_limit = groupboxes.secret_runaway_messages:AddSlider({
		Default = config.secret_runaway_messages.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

easter_egg_switch_1 = {
	enabled = groupboxes.easter_egg_switch_1
		:AddToggle({
			Default = config.easter_egg_switch_1.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[easter egg switch 1] Enabled ESP" or "[easter egg switch 1] Disabled ESP", 1)
		end);

	distance = groupboxes.easter_egg_switch_1
		:AddToggle({
			Default = config.easter_egg_switch_1.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[easter egg switch 1] Enabled Distance" or "[easter egg switch 1] Disabled Distance", 1)
		end);

	nametag = groupboxes.easter_egg_switch_1
		:AddToggle({
			Default = config.easter_egg_switch_1.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[easter egg switch 1] Enabled Nametag" or "[easter egg switch 1] Disabled Nametag", 1)
		end);

	tracer = groupboxes.easter_egg_switch_1
		:AddToggle({
			Default = config.easter_egg_switch_1.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[easter egg switch 1] Enabled Tracer" or "[easter egg switch 1] Disabled Tracer", 1)
		end);

    color = groupboxes.easter_egg_switch_1:AddColorPicker({
		Default = config.easter_egg_switch_1.color;
		Text = "Color";
	});

	distance_limit = groupboxes.easter_egg_switch_1:AddSlider({
		Default = config.easter_egg_switch_1.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

loiter_spots = {
	enabled = groupboxes.loiter_spots
		:AddToggle({
			Default = config.loiter_spots.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[loiter spots] Enabled ESP" or "[loiter spots] Disabled ESP", 1)
		end);

	distance = groupboxes.loiter_spots
		:AddToggle({
			Default = config.loiter_spots.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[loiter spots] Enabled Distance" or "[loiter spots] Disabled Distance", 1)
		end);

	nametag = groupboxes.loiter_spots
		:AddToggle({
			Default = config.loiter_spots.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[loiter spots] Enabled Nametag" or "[loiter spots] Disabled Nametag", 1)
		end);

	tracer = groupboxes.loiter_spots
		:AddToggle({
			Default = config.loiter_spots.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[loiter spots] Enabled Tracer" or "[loiter spots] Disabled Tracer", 1)
		end);

    color = groupboxes.loiter_spots:AddColorPicker({
		Default = config.loiter_spots.color;
		Text = "Color";
	});

	distance_limit = groupboxes.loiter_spots:AddSlider({
		Default = config.loiter_spots.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

loiter_spots_config = {}
for _, tab in pairs(config.loiter_spots.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	loiter_spots_config[name.."_enabled"] = groupboxes.loiter_spots_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[loiter spots] Enabled "..name.." ESP" or "[loiter spots] Disabled "..name.." ESP", 1)
		end)
end
]]

scrap = {
	enabled = groupboxes.scrap
		:AddToggle({
			Default = config.scrap.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[scrap] Enabled ESP" or "[scrap] Disabled ESP", 1)
		end);

	distance = groupboxes.scrap
		:AddToggle({
			Default = config.scrap.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[scrap] Enabled Distance" or "[scrap] Disabled Distance", 1)
		end);

	nametag = groupboxes.scrap
		:AddToggle({
			Default = config.scrap.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[scrap] Enabled Nametag" or "[scrap] Disabled Nametag", 1)
		end);

	tracer = groupboxes.scrap
		:AddToggle({
			Default = config.scrap.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[scrap] Enabled Tracer" or "[scrap] Disabled Tracer", 1)
		end);

    color = groupboxes.scrap:AddColorPicker({
		Default = config.scrap.color;
		Text = "Color";
	});

	distance_limit = groupboxes.scrap:AddSlider({
		Default = config.scrap.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

scrap_config = {}
for _, tab in pairs(config.scrap.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	scrap_config[name.."_enabled"] = groupboxes.scrap_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[scrap] Enabled "..name.." ESP" or "[scrap] Disabled "..name.." ESP", 1)
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
		elseif type == "aimbot_type" then
			table = { "Closest to mouse", "Distance" }
		elseif type == "aimbot_part" then
			table = { "Head", "HumanoidRootPart" }
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

current_tracer_type = _G.Get_Index("tracer", master_esp_settings.tracer_type.Value)
current_box_type = _G.Get_Index("box", master_esp_settings.box_type.Value)

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
	local_player = dx9.get_localplayer()
end

function get_local_player_name()
	if dx9.GetType(local_player) == "Player" then
		return dx9.GetName(local_player)
	else
		return local_player.Info.Name
	end
end

local_player_name = get_local_player_name()

my_player = dx9.FindFirstChild(services.players, local_player_name)
my_character = nil
my_head = nil
my_root = nil
my_humanoid = nil

if my_player == nil or my_player == 0 then
	return
elseif my_player ~= nil and my_player ~= 0 then
    my_character = dx9.FindFirstChild(workspace, local_player_name)
end

if my_character == nil or my_character == 0 then
	return
elseif my_character ~= nil and my_character ~= 0 then
	my_head = dx9.FindFirstChild(my_character, "Head")
	my_root = dx9.FindFirstChild(my_character, "HumanoidRootPart")
	my_humanoid = dx9.FindFirstChild(my_character, "Humanoid")
end

if my_root == nil or my_root == 0 then
    return
end

if my_head == nil or my_head == 0 then
    return
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

if players.enabled.Value then
    if _G.PlayerTask == nil then
        _G.PlayerTask = function()
            for _, player in pairs(dx9.GetChildren(services.players)) do
                local playerName = dx9.GetName(player)
                if playerName and playerName ~= local_player_name then
                    local playerColor = players.color.Value
                    
                    local character = dx9.FindFirstChild(workspace, playerName)
                    if character and character ~= 0 then
                        local root = dx9.FindFirstChild(character, "HumanoidRootPart")
                        local head = dx9.FindFirstChild(character, "Head")
                        local humanoid = dx9.FindFirstChild(character, "Humanoid")

                        if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
                            local my_root_pos = dx9.GetPosition(my_root)
                            local root_pos = dx9.GetPosition(root)
                            local head_pos = dx9.GetPosition(head)
                            local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                            local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                            local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

                            local screen_pos = root_screen_pos

                            if _G.IsOnScreen(screen_pos) then
                                if root_distance < players.distance_limit.Value then
                                    lib_esp.draw({
                                        target = character,
                                        color = playerColor,
                                        healthbar = false,
                                        nametag = players.nametag.Value,
                                        distance = players.distance.Value,
                                        custom_distance = ""..root_distance,
                                        tracer = players.tracer.Value,
                                        tracer_type = current_tracer_type,
                                        box_type = current_box_type,
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

if missions.enabled.Value then
    missionmarkers_folder = dx9.FindFirstChild(workspace, "MissionMarkers")
    if missionmarkers_folder ~= nil and missionmarkers_folder ~= 0 then
        if _G.MissionMarkersTask == nil then
            _G.MissionMarkersTask = function()
                missionmarkers_children = dx9.GetChildren(missionmarkers_folder)
                if missionmarkers_children then
                    if type(missionmarkers_children) == "table" then
                        for i,v in pairs(missionmarkers_children) do
                            if dx9.GetType(v) == "Part" then
                                local my_root_pos = dx9.GetPosition(my_root)
                                local name = dx9.GetName(v)
                                local pos = dx9.GetPosition(v)
                                local distance = _G.Get_Distance(my_root_pos, pos)
                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                
                                if _G.IsOnScreen(screen_pos) then
                                    if distance < missions.distance_limit.Value then
                                        lib_esp.draw({
                                            esp_type = "misc",
                                            target = v,
                                            color = missions.color.Value,
                                            healthbar = false,
                                            nametag = missions.nametag.Value,
                                            custom_nametag = name,
                                            distance = missions.distance.Value,
                                            custom_distance = ""..distance,
                                            tracer = missions.tracer.Value,
                                            tracer_type = current_tracer_type,
                                            box_type = current_box_type
                                        })
                                    end
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

if antennas.enabled.Value then
    respawnantennas_folder = dx9.FindFirstChild(workspace, "RespawnAntennas")
    if respawnantennas_folder ~= nil and respawnantennas_folder ~= 0 then
        if _G.RespawnAntennasTask == nil then
            _G.RespawnAntennasTask = function()
                respawnantennas_children = dx9.GetChildren(respawnantennas_folder)
                if respawnantennas_children then
                    if type(respawnantennas_children) == "table" then
                        for i,v in pairs(respawnantennas_children) do
                            if dx9.GetType(v) == "Model" then
                                local model = dx9.FindFirstChild(v, "Model")
                                if model ~= nil and model ~= 0 then
                                    if dx9.GetType(model) == "Model" then
                                        local part = dx9.FindFirstChild(model, "Part")
                                        if part ~= nil and part ~= 0 then
                                            if dx9.GetType(part) == "Part" then
                                                local my_root_pos = dx9.GetPosition(my_root)
                                                local name = dx9.GetName(v)
                                                local pos = dx9.GetPosition(part)
                                                local distance = _G.Get_Distance(my_root_pos, pos)
                                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                                
                                                if _G.IsOnScreen(screen_pos) then
                                                    if distance < antennas.distance_limit.Value then
                                                        lib_esp.draw({
                                                            esp_type = "misc",
                                                            target = part,
                                                            color = antennas.color.Value,
                                                            healthbar = false,
                                                            nametag = antennas.nametag.Value,
                                                            custom_nametag = name,
                                                            distance = antennas.distance.Value,
                                                            custom_distance = ""..distance,
                                                            tracer = antennas.tracer.Value,
                                                            tracer_type = current_tracer_type,
                                                            box_type = current_box_type
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
                end
            end
        end
        if _G.RespawnAntennasTask then
            _G.RespawnAntennasTask()
        end
    end
end

local world_folder = nil
if checkpoints.enabled.Value then
    if world_folder == nil then
        world_folder = dx9.FindFirstChild(workspace, "World")
    end
    if world_folder ~= nil and world_folder ~= 0 then
        --Workspace.World.Checkpoints.NAME.Model.Blinky
        checkpoints_folder = dx9.FindFirstChild(world_folder, "Checkpoints")
        if checkpoints_folder ~= nil and checkpoints_folder ~= 0 then
            if _G.BlinkyCheckpointsTask == nil then
                _G.BlinkyCheckpointsTask = function()
                    checkpoints_children = dx9.GetChildren(checkpoints_folder)
                    if checkpoints_children then
                        if type(checkpoints_children) == "table" then
                            for i,v in pairs(checkpoints_children) do
                                local model = dx9.FindFirstChild(v, "Model")
                                if model ~= nil and model ~= 0 then
                                    if dx9.GetType(model) == "Model" then
                                        local part = dx9.FindFirstChild(model, "Blinky")
                                        if part ~= nil and part ~= 0 then
                                            if dx9.GetType(part) == "Part" then
                                                local my_root_pos = dx9.GetPosition(my_root)
                                                local name = dx9.GetName(v)
                                                local pos = dx9.GetPosition(part)
                                                local distance = _G.Get_Distance(my_root_pos, pos)
                                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                                
                                                if _G.IsOnScreen(screen_pos) then
                                                    if distance < checkpoints.distance_limit.Value then
                                                        lib_esp.draw({
                                                            esp_type = "misc",
                                                            target = part,
                                                            color = checkpoints.color.Value,
                                                            healthbar = false,
                                                            nametag = checkpoints.nametag.Value,
                                                            custom_nametag = name,
                                                            distance = checkpoints.distance.Value,
                                                            custom_distance = ""..distance,
                                                            tracer = checkpoints.tracer.Value,
                                                            tracer_type = current_tracer_type,
                                                            box_type = current_box_type
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
                end
            end
            if _G.BlinkyCheckpointsTask then
                _G.BlinkyCheckpointsTask()
            end
        end
    end
end

if routers.enabled.Value then
    routers_folder = dx9.FindFirstChild(workspace, "Routers")
    if routers_folder ~= nil and routers_folder ~= 0 then
        if _G.RoutersTask == nil then
            _G.RoutersTask = function()
                routers_children = dx9.GetChildren(routers_folder)
                if routers_children then
                    if type(routers_children) == "table" then
                        for i,v in pairs(routers_children) do
                            if dx9.GetType(v) == "Configuration" then
                                local router_model = dx9.FindFirstChild(v, "RouterModel")
                                if router_model ~= nil and router_model ~= 0 then
                                    if dx9.GetType(router_model) == "Model" then
                                        local main_part = dx9.FindFirstChild(router_model, "Main")
                                        if main_part ~= nil and main_part ~= 0 then
                                            if dx9.GetType(main_part) == "Part" then
                                                local my_root_pos = dx9.GetPosition(my_root)
                                                local name = dx9.GetName(v)
                                                local pos = dx9.GetPosition(main_part)
                                                local distance = _G.Get_Distance(my_root_pos, pos)
                                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                                
                                                if _G.IsOnScreen(screen_pos) then
                                                    if distance < routers.distance_limit.Value then
                                                        lib_esp.draw({
                                                            esp_type = "misc",
                                                            target = main_part,
                                                            color = routers.color.Value,
                                                            healthbar = false,
                                                            nametag = routers.nametag.Value,
                                                            custom_nametag = name,
                                                            distance = routers.distance.Value,
                                                            custom_distance = ""..distance,
                                                            tracer = routers.tracer.Value,
                                                            tracer_type = current_tracer_type,
                                                            box_type = current_box_type
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
                end
            end
        end
        if _G.RoutersTask then
            _G.RoutersTask()
        end
    end
end

local races_folder = nil
if timetrials.enabled.Value then
    if races_folder == nil then
        races_folder = dx9.FindFirstChild(workspace, "Races")
    end
    if races_folder ~= nil and races_folder ~= 0 then
        --Workspace.Races.TimeTrials.FOLDER.Start_MODEL.Part
        --Workspace.Races.TimeTrials.FOLDER.Finish_PART
        local timetrials_folder = dx9.FindFirstChild(races_folder, "TimeTrials")
        if timetrials_folder ~= nil and timetrials_folder ~= 0 then
             if _G.TimeTrialsTask == nil then
                _G.TimeTrialsTask = function()
                    timetrials_children = dx9.GetChildren(timetrials_folder)
                    if timetrials_children then
                        if type(timetrials_children) == "table" then
                            for i,v in pairs(timetrials_children) do
                                local vname = nil
                                local finishpart = dx9.FindFirstChild(v, "Finish")
                                if finishpart ~= nil and finishpart ~= 0 then
                                    if dx9.GetType(finishpart) == "Part" then
                                        local my_root_pos = dx9.GetPosition(my_root)
                                        if vname == nil then
                                            vname = dx9.GetName(v)
                                        end
                                        local pos = dx9.GetPosition(finishpart)
                                        local distance = _G.Get_Distance(my_root_pos, pos)
                                        local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                        
                                        if _G.IsOnScreen(screen_pos) then
                                            if distance < timetrials.distance_limit.Value then
                                                lib_esp.draw({
                                                    esp_type = "misc",
                                                    target = finishpart,
                                                    color = timetrials.finish_color.Value,
                                                    healthbar = false,
                                                    nametag = timetrials.nametag.Value,
                                                    custom_nametag = vname.." Finish",
                                                    distance = timetrials.distance.Value,
                                                    custom_distance = ""..distance,
                                                    tracer = timetrials.tracer.Value,
                                                    tracer_type = current_tracer_type,
                                                    box_type = current_box_type
                                                })
                                            end
                                        end
                                    end
                                end
                                local startmodel = dx9.FindFirstChild(v, "Start")
                                if startmodel ~= nil and startmodel ~= 0 then
                                    if dx9.GetType(startmodel) == "Model" then
                                        local startpart = dx9.FindFirstChild(startmodel, "Part")
                                        if startpart ~= nil and startpart ~= 0 then
                                            if dx9.GetType(startpart) == "Part" then
                                                local my_root_pos = dx9.GetPosition(my_root)
                                                if vname == nil then
                                                    vname = dx9.GetName(v)
                                                end
                                                local pos = dx9.GetPosition(startpart)
                                                local distance = _G.Get_Distance(my_root_pos, pos)
                                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                                
                                                if _G.IsOnScreen(screen_pos) then
                                                    if distance < timetrials.distance_limit.Value then
                                                        lib_esp.draw({
                                                            esp_type = "misc",
                                                            target = startpart,
                                                            color = timetrials.start_color.Value,
                                                            healthbar = false,
                                                            nametag = timetrials.nametag.Value,
                                                            custom_nametag = vname.." Start",
                                                            distance = timetrials.distance.Value,
                                                            custom_distance = ""..distance,
                                                            tracer = timetrials.tracer.Value,
                                                            tracer_type = current_tracer_type,
                                                            box_type = current_box_type
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
                end
            end
            if _G.TimeTrialsTask then
                _G.TimeTrialsTask()
            end
        end
    end
end

if challenges.enabled.Value then
    if races_folder == nil then
        races_folder = dx9.FindFirstChild(workspace, "Races")
    end
    if races_folder ~= nil and races_folder ~= 0 then
        local challenges_folder = dx9.FindFirstChild(races_folder, "Challenges")
        if challenges_folder ~= nil and challenges_folder ~= 0 then
             if _G.ChallengesTask == nil then
                _G.ChallengesTask = function()
                    challenges_children = dx9.GetChildren(challenges_folder)
                    if challenges_children then
                        if type(challenges_children) == "table" then
                            for i,v in pairs(challenges_children) do
                                local vname = nil
                                local finishpart = dx9.FindFirstChild(v, "Finish")
                                if finishpart ~= nil and finishpart ~= 0 then
                                    if dx9.GetType(finishpart) == "Part" then
                                        local my_root_pos = dx9.GetPosition(my_root)
                                        if vname == nil then
                                            vname = dx9.GetName(v)
                                        end
                                        local pos = dx9.GetPosition(finishpart)
                                        local distance = _G.Get_Distance(my_root_pos, pos)
                                        local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                        
                                        if _G.IsOnScreen(screen_pos) then
                                            if distance < challenges.distance_limit.Value then
                                                lib_esp.draw({
                                                    esp_type = "misc",
                                                    target = finishpart,
                                                    color = challenges.finish_color.Value,
                                                    healthbar = false,
                                                    nametag = challenges.nametag.Value,
                                                    custom_nametag = vname.." Finish",
                                                    distance = challenges.distance.Value,
                                                    custom_distance = ""..distance,
                                                    tracer = challenges.tracer.Value,
                                                    tracer_type = current_tracer_type,
                                                    box_type = current_box_type
                                                })
                                            end
                                        end
                                    end
                                end
                                local startmodel = dx9.FindFirstChild(v, "Start")
                                if startmodel ~= nil and startmodel ~= 0 then
                                    if dx9.GetType(startmodel) == "Model" then
                                        local startpart = dx9.FindFirstChild(startmodel, "Part")
                                        if startpart ~= nil and startpart ~= 0 then
                                            if dx9.GetType(startpart) == "Part" then
                                                local my_root_pos = dx9.GetPosition(my_root)
                                                if vname == nil then
                                                    vname = dx9.GetName(v)
                                                end
                                                local pos = dx9.GetPosition(startpart)
                                                local distance = _G.Get_Distance(my_root_pos, pos)
                                                local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                                                
                                                if _G.IsOnScreen(screen_pos) then
                                                    if distance < challenges.distance_limit.Value then
                                                        lib_esp.draw({
                                                            esp_type = "misc",
                                                            target = startpart,
                                                            color = challenges.start_color.Value,
                                                            healthbar = false,
                                                            nametag = challenges.nametag.Value,
                                                            custom_nametag = vname.." Start",
                                                            distance = challenges.distance.Value,
                                                            custom_distance = ""..distance,
                                                            tracer = challenges.tracer.Value,
                                                            tracer_type = current_tracer_type,
                                                            box_type = current_box_type
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
                end
            end
            if _G.ChallengesTask then
                _G.ChallengesTask()
            end
        end
    end
end

if _G.ScrapCache == nil then
    _G.ScrapCache = {}
else
    for i, cached_tab in pairs(_G.ScrapCache) do
        if not cached_tab.last_update or (os.clock() - cached_tab.last_update) > debugging.scrap_cache_cleanup_timer.Value then
            _G.ScrapCache[i] = nil
        end
    end
end

if scrap.enabled.Value then
    raycastignore_folder = dx9.FindFirstChild(workspace, "RaycastIgnore")
    if raycastignore_folder ~= nil and raycastignore_folder ~= 0 then
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
                raycastignore_children = dx9.GetChildren(raycastignore_folder)
                if raycastignore_children then
                    if type(raycastignore_children) == "table" then
                        for i,v in pairs(raycastignore_children) do
                            local cached_tab = _G.ScrapCache[tostring(v)]
                            if not cached_tab then
                                if dx9.GetType(v) == "Model" then                    
                                    local part = dx9.FindFirstChild(v, "Part")
                                    if part == nil or part == 0 then
                                        part = dx9.FindFirstChild(v, "Main")
                                    end
                                    if part ~= nil and part ~= 0 then
                                        if dx9.GetType(part) == "Part" then
                                            local cached_tab = _G.ScrapCache[tostring(v)]
                                            local name = (cached_tab and cached_tab.name) or _G.GetScrapNameFromModel(v) or "Other"
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
                        local scrap_config_tab = scrap_config[t.name.."_enabled"]
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
                        typeTab = scrap
                        typeConfigSettings = config.scrap
                        typeConfig = scrap_config
                    elseif isType == 0 then
                        if _G.consoleEnabled == true then
                            print("Unknown Scrap Found: '"..t.name.."'")
                        end
                        typeTab = scrap
                        typeConfigSettings = config.scrap
                        typeConfig = scrap_config
                        skipThis = false
                    end

                    if not skipThis and typeTab and typeConfigSettings and typeConfig then
                        local my_root_pos = dx9.GetPosition(my_root)
                        local pos = dx9.GetPosition(t.part)
                        local distance = _G.Get_Distance(my_root_pos, pos)
                        local screen_pos = dx9.WorldToScreen({pos.x, pos.y, pos.z})
                        
                        if _G.IsOnScreen(screen_pos) then
                            if distance < scrap.distance_limit.Value then
                                lib_esp.draw({
                                    esp_type = "misc",
                                    target = t.part,
                                    color = scrap.color.Value,
                                    healthbar = false,
                                    nametag = scrap.nametag.Value,
                                    custom_nametag = t.name,
                                    distance = scrap.distance.Value,
                                    custom_distance = ""..distance,
                                    tracer = scrap.tracer.Value,
                                    tracer_type = current_tracer_type,
                                    box_type = current_box_type
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

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end