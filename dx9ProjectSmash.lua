--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

Config = _G.Config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
	};
    settings = {
		aimbot_enabled = true;
		sticky_aim = false;
		aimbot_part = 1; -- 1 = "Head", 2 = "HumanoidRootPart"
		aimbot_smoothness = 5;

		menu_toggle_keybind = "[F2]";
		
		maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;

		master_esp_enabled = true;
    	box_type = 1; -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    };
	players = {
		enabled = true;
        distance = true;
        nametag = true;
		healthbar = true;
		healthtag = true;
		maxhealthtag = true;
        tracer = false;
        color = { 255, 0, 0 };
		distance_limit = 10000;
	};
}
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

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "Project Smash | dx9ware | By @Brycki";
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
Tabs.debug = Interface:AddTab("Debug")
Tabs.settings = Interface:AddTab("Settings")
Tabs.players = Interface:AddTab("Players")

Groupboxes = {}
Groupboxes.debug = Tabs.debug:AddMiddleGroupbox("Debugging")
Groupboxes.master_esp_settings = Tabs.settings:AddMiddleGroupbox("Master ESP")
Groupboxes.aimbot_settings = Tabs.settings:AddMiddleGroupbox("Aimbot")
Groupboxes.players = Tabs.players:AddMiddleGroupbox("Players ESP")

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
			Text = "ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Global ESP" or "[settings] Disabled Global ESP", 1)
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

Aimbot_settings = {
	enabled = Groupboxes.aimbot_settings
		:AddToggle({
			Default = Config.settings.aimbot_enabled;
			Text = "Aimbot Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Aimbot" or "[settings] Disabled Aimbot", 1)
			if not value then
				_G.Aimbot_target_name = nil
				_G.Aimbot_target_screen_pos = nil
			end
		end);

	sticky_aim = Groupboxes.aimbot_settings
		:AddToggle({
			Default = Config.settings.sticky_aim;
			Text = "Sticky Aim Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Sticky Aim" or "[settings] Disabled Sticky Aim", 1)
		end);

	part = Groupboxes.aimbot_settings
		:AddDropdown({
			Text = "Aimbot Part";
			Default = Config.settings.aimbot_part;
			Values = { "Head", "HumanoidRootPart" };
		})
		:OnChanged(function(value)
			Lib_ui:Notify("[settings] Aimbot Part: " .. value, 1)
		end);

	smoothness = Groupboxes.aimbot_settings:AddSlider({
		Default = Config.settings.aimbot_smoothness;
		Text = "Aimbot Smoothness";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});
}

local Aimbot_target_name = _G.Aimbot_target_name or nil
local Aimbot_target_screen_pos = _G.Aimbot_target_screen_pos or nil

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
	
	healthbar = Groupboxes.players:AddToggle({
			Default = Config.players.healthbar;
			Text = "HealthBar";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[players] Enabled HealthBar" or "[players] Disabled HealthBar", 1)
		end);

	healthtag = Groupboxes.players:AddToggle({
			Default = Config.players.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[players] Enabled HealthTag" or "[players] Disabled HealthTag", 1)
		end);

	maxhealthtag = Groupboxes.players:AddToggle({
			Default = Config.players.maxhealthtag;
			Text = "MaxHealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[players] Enabled MaxHealthTag" or "[players] Disabled MaxHealthTag", 1)
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

    distance_limit = Groupboxes.players:AddSlider({
		Default = Config.players.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 5000;
		Rounding = 0;
	});
}

Allies = {
	enabled = Groupboxes.allies
		:AddToggle({
			Default = Config.allies.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[allies] Enabled ESP" or "[allies] Disabled ESP", 1)
		end);

	distance = Groupboxes.allies
		:AddToggle({
			Default = Config.allies.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[allies] Enabled Distance" or "[allies] Disabled Distance", 1)
		end);
    
	healthbar = Groupboxes.allies:AddToggle({
			Default = Config.allies.healthbar;
			Text = "HealthBar";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[allies] Enabled HealthBar" or "[allies] Disabled HealthBar", 1)
		end);

	healthtag = Groupboxes.allies:AddToggle({
			Default = Config.allies.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[allies] Enabled HealthTag" or "[allies] Disabled HealthTag", 1)
		end);

	maxhealthtag = Groupboxes.allies:AddToggle({
			Default = Config.allies.maxhealthtag;
			Text = "MaxHealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[allies] Enabled MaxHealthTag" or "[allies] Disabled MaxHealthTag", 1)
		end);


	nametag = Groupboxes.allies
		:AddToggle({
			Default = Config.allies.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[allies] Enabled Nametag" or "[allies] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.allies
		:AddToggle({
			Default = Config.allies.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[allies] Enabled Tracer" or "[allies] Disabled Tracer", 1)
		end);

    distance_limit = Groupboxes.allies:AddSlider({
		Default = Config.allies.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 5000;
		Rounding = 0;
	});
}

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
		elseif type == "target_part" then
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

Datamodel = dx9.GetDatamodel()

Worskpace = dx9.FindFirstChildOfClass(Datamodel, "Workspace")

Services = {
	players = dx9.FindFirstChildOfClass(Datamodel, "Players");
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

Current_target_part = _G.Get_Index("target_part", Aimbot_settings.part.Value)
Current_tracer_type = _G.Get_Index("tracer", Master_esp_settings.tracer_type.Value)
Current_box_type = _G.Get_Index("box", Master_esp_settings.box_type.Value)

if Local_player == nil then
	for _, player in pairs(dx9.GetChildren(Services.players)) do
		local pgui = dx9.FindFirstChildOfClass(player, "PlayerGui")
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
	if type(Local_player) == "table" then
		return Local_player.Info.Name
	elseif type(Local_player) == "number" and dx9.GetType(Local_player) == "Player" then
		return dx9.GetName(Local_player)
	else
		print("WARNING | Get_local_player_name returned nil")
		return nil
	end
end

Local_player_name = Get_local_player_name()

My_player = dx9.FindFirstChild(Services.players, Local_player_name)
My_team_name = nil
My_character = nil
My_root = nil

if My_player and My_player ~= 0 then
    My_character = dx9.FindFirstChild(Worskpace, Local_player_name)
	My_team_name = dx9.GetTeam(My_player)
end

if My_character and My_character ~= 0 then
	My_root = dx9.FindFirstChild(My_character, "HumanoidRootPart")
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
		if Players.enabled.Value or Aimbot_settings.enabled.Value then
			local closest_player_name = nil
			local closest_player_value = nil
			local closest_player_screen_pos = nil
			for _, player in pairs(dx9.GetChildren(Services.players)) do
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
					local teamName = dx9.GetTeam(player)
					local playerColor = {255, 255, 255}
					
					local character = dx9.FindFirstChild(Worskpace, cached_tab.playerName)
					if character and character ~= 0 then
						local root = dx9.FindFirstChild(character, "HumanoidRootPart")
						local humanoid = dx9.FindFirstChild(character, "Humanoid")

						if root and root ~= 0 and humanoid and humanoid ~= 0 then
							local my_root_pos = My_root ~= nil and My_root ~= 0 and dx9.GetPosition(My_root) or {x=0, y=0, z=0}
							local root_pos = dx9.GetPosition(root)
							local root_distance = _G.Get_Distance(my_root_pos, root_pos)
							local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
							local health = math.ceil(dx9.GetHealth(humanoid))
							local maxhealth = math.ceil(dx9.GetMaxHealth(humanoid))

							local screen_pos = root_screen_pos

							if _G.IsOnScreen(screen_pos) then
								if Aimbot_settings.enabled.Value then
									if cached_tab.playerName == Aimbot_target_name then
										Aimbot_target_screen_pos = screen_pos
									end

									--if not Aimbot_settings.sticky_aim.Value or Aimbot_settings.sticky_aim.Value and not Aimbot_target_name then
										local mouse_distance = _G.Get_Distance_From_Mouse(screen_pos)
										local aimbot_range = 9999 --dx9.GetAimbotValue("range")
										local aimbot_fov = dx9.GetAimbotValue("fov")
										if mouse_distance and mouse_distance <= aimbot_fov and root_distance <= aimbot_range then
											local current_aimbot_type = dx9.GetAimbotValue("type")
											if current_aimbot_type == 1 then
												if closest_player_value == nil or mouse_distance < closest_player_value then
													closest_player_name = cached_tab.playerName
													closest_player_value = mouse_distance
													closest_player_screen_pos = screen_pos
												end
											elseif current_aimbot_type == 0 then
												if closest_player_value == nil or root_distance < closest_player_value then
													closest_player_name = cached_tab.playerName
													closest_player_value = root_distance
													closest_player_screen_pos = screen_pos
												end
											end
										end
									--end
								end
								
								local this_custom_name = Players.healthtag.Value and cached_tab.playerName.." | "..health..(Players.maxhealthtag.Value and "/"..maxhealth.." hp" or " hp") or cached_tab.playerName;

								
								if Master_esp_settings.enabled.Value and Players.enabled.Value then
									if root_distance < Players.distance_limit.Value then
										Lib_esp.draw({
											target = character,
											color = playerColor,
											healthbar = Players.healthbar.Value,
											nametag = Players.nametag.Value,
											custom_nametag = this_custom_name,
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

			if not _G.lastAimbotFrame or _G.lastAimbotFrame and (os.clock() - _G.lastAimbotFrame) > (1/30) then
				if Aimbot_settings.enabled.Value then
					--swapping targets
					if Aimbot_settings.sticky_aim.Value then
						if dx9.isRightClickHeld() then
							Aimbot_target_name = nil
							Aimbot_target_screen_pos = nil
						end
						if not Aimbot_target_name or Aimbot_target_name and Aimbot_target_name == 0 then
							Aimbot_target_name = closest_player_name
							Aimbot_target_screen_pos = closest_player_screen_pos
						end
					else
						Aimbot_target_name = closest_player_name
						Aimbot_target_screen_pos = closest_player_screen_pos
					end

					if Aimbot_target_name and _G.IsOnScreen(Aimbot_target_screen_pos) then
						--print(Aimbot_target_name.." | x: "..Aimbot_target_screen_pos.x.." | y: "..Aimbot_target_screen_pos.y)
						local mouse_moved = false
						if mouse_moved == false then
							dx9.SetAimbotValue("x", 0)
							dx9.SetAimbotValue("y", 0)
							dx9.SetAimbotValue("z", 0)
							dx9.FirstPersonAim({
								(Aimbot_target_screen_pos and Aimbot_target_screen_pos.x or 0) + Screen_size.width/2,
								(Aimbot_target_screen_pos and Aimbot_target_screen_pos.y or 0) + Screen_size.height/2
							}, Aimbot_settings.smoothness.Value, 1)
							mouse_moved = true
						end
					end
				else
					Aimbot_target_name = nil
					Aimbot_target_screen_pos = nil
				end
				_G.Aimbot_target_name = Aimbot_target_name
				_G.Aimbot_target_screen_pos = Aimbot_target_screen_pos
				_G.lastAimbotFrame = os.clock()
			end
		end
	end
end
if _G.PlayerTask then
	_G.PlayerTask()
end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= Config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end