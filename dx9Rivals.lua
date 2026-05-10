Master_esp_settings.autoshoot = Groupboxes.aimbot_settings:AddToggle({
	Default = false;
	Text = "Aimbot Autoshoot";
}):OnChanged(function(value)
	Lib_ui:Notify(value and "[aimbot] Autoshoot Enabled" or "[aimbot] Autoshoot Disabled", 1)
end);

local last_autoshoot_time = 0
--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

Config = _G.Config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main2.lua";
        DXRaycast = "https://raw.githubusercontent.com/Brycki404/DXRaycast/refs/heads/main/main.lua";
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
		cache_cleanup_timer = 3;

		master_esp_enabled = true;
    	box_type = 1; -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    };
	enemies = {
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
	allies = {
        enabled = false;
        distance = true;
        nametag = true;
		healthbar = true;
		healthtag = true;
		maxhealthtag = true;
        tracer = false;
        color = { 0, 255, 0 };
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

Lib_raycast = loadstring(dx9.Get(Config.urls.DXRaycast))()

Interface = Lib_ui:CreateWindow({
	Title = "Rivals | dx9ware | By @Brycki";
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
Tabs.esp = Interface:AddTab("ESP")
Tabs.players = Interface:AddTab("Players")

Groupboxes = {}
Groupboxes.debug = Tabs.debug:AddMiddleGroupbox("Debugging")
Groupboxes.master_esp_settings = Tabs.settings:AddMiddleGroupbox("Master ESP")
Groupboxes.aimbot_settings = Tabs.settings:AddMiddleGroupbox("Aimbot")
Groupboxes.esp_enemies = Tabs.esp:AddMiddleGroupbox("Enemies ESP")
Groupboxes.esp_allies = Tabs.esp:AddMiddleGroupbox("Allies ESP")
Groupboxes.players = Tabs.players:AddMiddleGroupbox("Players List")

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
		wallcheck_esp = Groupboxes.master_esp_settings:AddToggle({
			Default = true;
			Text = "ESP Wall Check";
		}):OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] ESP Wall Check Enabled" or "[settings] ESP Wall Check Disabled", 1)
		end);

		wallcheck_aimbot = Groupboxes.master_esp_settings:AddToggle({
			Default = true;
			Text = "Aimbot Wall Check";
		}):OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Aimbot Wall Check Enabled" or "[settings] Aimbot Wall Check Disabled", 1)
		end);
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

	fov_circle_enabled = Groupboxes.master_esp_settings:AddToggle({
		Default = true;
		Text = "Show FOV Circle";
	}):OnChanged(function(value)
		Lib_ui:Notify(value and "[settings] FOV Circle Enabled" or "[settings] FOV Circle Disabled", 1)
	end);

	fov_radius = Groupboxes.master_esp_settings:AddSlider({
		Default = 150;
		Text = "Aimbot FOV Radius";
		Min = 10;
		Max = 1300;
		Rounding = 0;
	});
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

Enemies = {
   enabled = Groupboxes.esp_enemies
	   :AddToggle({
		   Default = Config.enemies.enabled;
		   Text = "Enabled";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[enemies] Enabled ESP" or "[enemies] Disabled ESP", 1)
	   end);

   distance = Groupboxes.esp_enemies
	   :AddToggle({
		   Default = Config.enemies.distance;
		   Text = "Distance";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[enemies] Enabled Distance" or "[enemies] Disabled Distance", 1)
	   end);
   
   healthbar = Groupboxes.esp_enemies:AddToggle({
		   Default = Config.enemies.healthbar;
		   Text = "HealthBar";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[enemies] Enabled HealthBar" or "[enemies] Disabled HealthBar", 1)
	   end);

   healthtag = Groupboxes.esp_enemies:AddToggle({
		   Default = Config.enemies.healthtag;
		   Text = "HealthTag";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[enemies] Enabled HealthTag" or "[enemies] Disabled HealthTag", 1)
	   end);

   maxhealthtag = Groupboxes.esp_enemies:AddToggle({
		   Default = Config.enemies.maxhealthtag;
		   Text = "MaxHealthTag";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[enemies] Enabled MaxHealthTag" or "[enemies] Disabled MaxHealthTag", 1)
	   end);

   nametag = Groupboxes.esp_enemies
	   :AddToggle({
		   Default = Config.enemies.nametag;
		   Text = "Nametag";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[enemies] Enabled Nametag" or "[enemies] Disabled Nametag", 1)
	   end);

   tracer = Groupboxes.esp_enemies
	   :AddToggle({
		   Default = Config.enemies.tracer;
		   Text = "Tracer";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[enemies] Enabled Tracer" or "[enemies] Disabled Tracer", 1)
	   end);

	distance_limit = Groupboxes.esp_enemies:AddSlider({
	   Default = Config.enemies.distance_limit;
	   Text = "ESP Distance Limit";
	   Min = 0;
	   Max = 5000;
	   Rounding = 0;
   });
}

Allies = {
   enabled = Groupboxes.esp_allies
	   :AddToggle({
		   Default = Config.allies.enabled;
		   Text = "Enabled";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[allies] Enabled ESP" or "[allies] Disabled ESP", 1)
	   end);

   distance = Groupboxes.esp_allies
	   :AddToggle({
		   Default = Config.allies.distance;
		   Text = "Distance";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[allies] Enabled Distance" or "[allies] Disabled Distance", 1)
	   end);
    
   healthbar = Groupboxes.esp_allies:AddToggle({
		   Default = Config.allies.healthbar;
		   Text = "HealthBar";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[allies] Enabled HealthBar" or "[allies] Disabled HealthBar", 1)
	   end);

   healthtag = Groupboxes.esp_allies:AddToggle({
		   Default = Config.allies.healthtag;
		   Text = "HealthTag";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[allies] Enabled HealthTag" or "[allies] Disabled HealthTag", 1)
	   end);

   maxhealthtag = Groupboxes.esp_allies:AddToggle({
		   Default = Config.allies.maxhealthtag;
		   Text = "MaxHealthTag";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[allies] Enabled MaxHealthTag" or "[allies] Disabled MaxHealthTag", 1)
	   end);


   nametag = Groupboxes.esp_allies
	   :AddToggle({
		   Default = Config.allies.nametag;
		   Text = "Nametag";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[allies] Enabled Nametag" or "[allies] Disabled Nametag", 1)
	   end);

   tracer = Groupboxes.esp_allies
	   :AddToggle({
		   Default = Config.allies.tracer;
		   Text = "Tracer";
	   })
	   :OnChanged(function(value)
		   Lib_ui:Notify(value and "[allies] Enabled Tracer" or "[allies] Disabled Tracer", 1)
	   end);

	distance_limit = Groupboxes.esp_allies:AddSlider({
	   Default = Config.allies.distance_limit;
	   Text = "ESP Distance Limit";
	   Min = 0;
	   Max = 5000;
	   Rounding = 0;
   });
}

-- Player classification state
PlayerClassifications = {}

function RefreshPlayersList()
	Groupboxes.players:Clear()
	local playerObjs = dx9.GetChildren(Services.players)
	for _, player in pairs(playerObjs) do
		local playerName = dx9.GetName(player)
		if playerName and playerName ~= Local_player_name then
			if PlayerClassifications[playerName] == nil then
				PlayerClassifications[playerName] = "Enemy" -- default
			end
			local toggle = Groupboxes.players:AddDropdown({
				Text = playerName .. " Type";
				Default = PlayerClassifications[playerName] == "Enemy" and 1 or 2;
				Values = { "Enemy", "Ally" };
			}):OnChanged(function(val)
				PlayerClassifications[playerName] = val
				Lib_ui:Notify("Set "..playerName.." as "..val, 1)
			end)
		end
	end
end

RefreshPlayersList()
-- Optionally, hook this to a refresh button or event if players can join/leave

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

Local_player_table = dx9.get_localplayer()
for _, player in pairs(dx9.GetChildren(Services.players)) do
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
	-- R15 body part indices for identification
	local R15Parts = {
		"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot", "HumanoidRootPart"
	}
	local R15PartIndex = {}
	for i, partName in ipairs(R15Parts) do
		R15PartIndex[partName] = i
	end

	-- Draw FOV circle function
	local function drawFOVCircle()
		if not Master_esp_settings.fov_circle_enabled.Value then return end
		local screen = dx9.size()
		local center = { x = screen.width / 2, y = screen.height / 2 }
		local radius = Master_esp_settings.fov_radius.Value
		-- Use Lib_esp or dx9 to draw a circle (pseudo, replace with actual draw call)
		if Lib_esp and Lib_esp.draw_circle then
			Lib_esp.draw_circle(center, radius, {255,255,255,100})
		elseif dx9.DrawCircle then
			dx9.DrawCircle(center.x, center.y, radius, {255,255,255,100})
		end
	end

	_G.PlayerTask = function()
		if Enemies.enabled.Value or Allies.enabled.Value or Aimbot_settings.enabled.Value then
			drawFOVCircle()
			local closest_player_name = nil
			local closest_player_value = nil
			local closest_player_screen_pos = nil
			local allParts = dx9.GetAllParts(dx9.GetDatamodel())
			-- Build a reverse lookup: part -> playerName
			local partToPlayer = {}
			for _, player in pairs(dx9.GetChildren(Services.players)) do
				local playerName = dx9.GetName(player)
				local character = dx9.FindFirstChild(Worskpace, playerName)
				if character and character ~= 0 then
					for _, partName in ipairs(R15Parts) do
						local part = dx9.FindFirstChild(character, partName)
						if part and part ~= 0 then
							partToPlayer[tostring(part)] = {playerName = playerName, partName = partName, partIndex = R15PartIndex[partName]}
						end
					end
				end
			end

			for _, player in pairs(dx9.GetChildren(Services.players)) do
				local cached_tab = _G.PlayerCache[tostring(player)]
				local playerName = dx9.GetName(player)
				if not cached_tab then
					if playerName and type(playerName) == "string" and playerName ~= "" and playerName ~= Local_player_name then
						_G.PlayerCache[tostring(player)] = {
							player = player;
							playerName = playerName;
							last_update = os.clock();
						}
					end
				end
				if cached_tab then
					-- Use Players tab classification if set
					local classification = PlayerClassifications[playerName] or "Enemy"
					local isEnemy = classification == "Enemy"
					local teamGroupbox = isEnemy and Enemies or Allies
					local teamConfig = isEnemy and Config.enemies or Config.allies
					local playerColor = isEnemy and {255, 0, 0} or {0, 255, 0}

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


							-- ESP wall check
							local canSeeESP = true
							if isEnemy and Master_esp_settings.wallcheck_esp.Value then
								canSeeESP = false
								for _, partName in ipairs(R15Parts) do
									local part = dx9.FindFirstChild(character, partName)
									if part and part ~= 0 then
										local part_pos = dx9.GetPosition(part)
										local hit, hitPart = dx9.Raycast(my_root_pos, part_pos, allParts)
										if hit and hitPart and partToPlayer[tostring(hitPart)] and partToPlayer[tostring(hitPart)].playerName == playerName then
											canSeeESP = true
											break
										end
									end
								end
							end

							-- Aimbot wall check and biggest visible part selection
							local canSeeAimbot = true
							local best_part = nil
							local best_screen = nil
							if isEnemy and Master_esp_settings.wallcheck_aimbot.Value then
								canSeeAimbot = false
								local found_head, found_root, found_torso, found_limb = nil, nil, nil, nil
								local torso_parts = {"UpperTorso", "LowerTorso"}
								local limb_parts = {"LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"}
								for _, partName in ipairs(R15Parts) do
									local part = dx9.FindFirstChild(character, partName)
									if part and part ~= 0 then
										local part_pos = dx9.GetPosition(part)
										local screen = dx9.WorldToScreen({part_pos.x, part_pos.y, part_pos.z})
										if screen and screen.x and screen.y then
											local hit, hitPart = dx9.Raycast(my_root_pos, part_pos, allParts)
											if hit and hitPart and partToPlayer[tostring(hitPart)] and partToPlayer[tostring(hitPart)].playerName == playerName then
												canSeeAimbot = true
												if partName == "Head" and not found_head then
													found_head = {part=part, screen=screen}
												elseif partName == "HumanoidRootPart" and not found_root then
													found_root = {part=part, screen=screen}
												elseif table.find and table.find(torso_parts, partName) and not found_torso then
													found_torso = {part=part, screen=screen}
												elseif table.find and table.find(limb_parts, partName) and not found_limb then
													found_limb = {part=part, screen=screen}
												end
											end
										end
									end
								end
								if found_head then
									best_part = found_head.part
									best_screen = found_head.screen
								elseif found_root then
									best_part = found_root.part
									best_screen = found_root.screen
								elseif found_torso then
									best_part = found_torso.part
									best_screen = found_torso.screen
								elseif found_limb then
									best_part = found_limb.part
									best_screen = found_limb.screen
								end
							else
								-- If wallcheck is off, just pick root
								best_part = root
								best_screen = root_screen_pos
							end


							if _G.IsOnScreen(screen_pos) and (not isEnemy or canSeeESP) then
								-- Aimbot logic: aim at biggest visible part
								if Aimbot_settings.enabled.Value and isEnemy and canSeeAimbot and best_screen then
									if cached_tab.playerName == Aimbot_target_name then
										Aimbot_target_screen_pos = best_screen
									end
									local mouse_distance = _G.Get_Distance_From_Mouse(best_screen)
									local aimbot_range = 9999 --dx9.GetAimbotValue("range")
									local inFOV = true
									if Master_esp_settings.fov_circle_enabled.Value then
										local screen = dx9.size()
										local center = { x = screen.width / 2, y = screen.height / 2 }
										local dx = (best_screen.x - center.x)
										local dy = (best_screen.y - center.y)
										local dist = math.sqrt(dx*dx + dy*dy)
										inFOV = dist <= Master_esp_settings.fov_radius.Value
									end
									if mouse_distance and root_distance <= aimbot_range and (inFOV or not Master_esp_settings.fov_circle_enabled.Value) then
										local current_aimbot_type = dx9.GetAimbotValue("type")
										if current_aimbot_type == 1 then
											if closest_player_value == nil or mouse_distance < closest_player_value then
												closest_player_name = cached_tab.playerName
												closest_player_value = mouse_distance
												closest_player_screen_pos = best_screen
											end
										elseif current_aimbot_type == 0 then
											if closest_player_value == nil or root_distance < closest_player_value then
												closest_player_name = cached_tab.playerName
												closest_player_value = root_distance
												closest_player_screen_pos = best_screen
											end
										end
									end
								end

								local this_custom_name = teamGroupbox.healthtag.Value and cached_tab.playerName.." | "..health..(teamGroupbox.maxhealthtag.Value and "/"..maxhealth.." hp" or " hp") or cached_tab.playerName;

								if Master_esp_settings.enabled.Value and teamGroupbox.enabled.Value then
									if root_distance < teamGroupbox.distance_limit.Value then
										-- ESP Drawing logic using anchor-aware helpers
										local anchors = nil
										local box_type = Master_esp_settings.box_type.Value
										local cframe = dx9.GetCFrame(root)
										local size = {2, 5, 1} -- Default size, override with actual part size if available
										local topleft, bottomright = nil, nil
										if box_type == 1 then -- Corners (2D)
											-- Project 3D bounding box to 2D, then draw 2D corner box
											local minx, miny, maxx, maxy = math.huge, math.huge, -math.huge, -math.huge
											for _, partName in ipairs(R15Parts) do
												local part = dx9.FindFirstChild(character, partName)
												if part and part ~= 0 then
													local pos = dx9.GetPosition(part)
													local screen = dx9.WorldToScreen({pos.x, pos.y, pos.z})
													if screen and screen.x and screen.y then
														if screen.x < minx then minx = screen.x end
														if screen.y < miny then miny = screen.y end
														if screen.x > maxx then maxx = screen.x end
														if screen.y > maxy then maxy = screen.y end
													end
												end
											end
											topleft = {x = minx, y = miny}
											bottomright = {x = maxx, y = maxy}
											anchors = Lib_esp.draw_box_2d_corners_anchored(topleft, bottomright, playerColor, 2, 12, true)
										elseif box_type == 2 then -- 2D Box
											-- Project 3D bounding box to 2D, then draw 2D box
											local minx, miny, maxx, maxy = math.huge, math.huge, -math.huge, -math.huge
											for _, partName in ipairs(R15Parts) do
												local part = dx9.FindFirstChild(character, partName)
												if part and part ~= 0 then
													local pos = dx9.GetPosition(part)
													local screen = dx9.WorldToScreen({pos.x, pos.y, pos.z})
													if screen and screen.x and screen.y then
														if screen.x < minx then minx = screen.x end
														if screen.y < miny then miny = screen.y end
														if screen.x > maxx then maxx = screen.x end
														if screen.y > maxy then maxy = screen.y end
													end
												end
											end
											topleft = {x = minx, y = miny}
											bottomright = {x = maxx, y = maxy}
											anchors = Lib_esp.draw_box_2d_anchored(topleft, bottomright, playerColor, 2, true)
										elseif box_type == 3 then -- 3D Corner Box
											if cframe then
												size = {2, 5, 1} -- You may want to get actual size from root or character
												anchors = Lib_esp.draw_box_3d_corners_anchored(cframe, size, playerColor, 2, 1, true)
											end
										end

										-- Healthbar
										if teamGroupbox.healthbar.Value and anchors and anchors.topleft and anchors.bottomright then
											-- Draw healthbar to the left of the box
											local bar_width = 4
											local bar_topleft = { x = anchors.topleft.x - bar_width - 2, y = anchors.topleft.y }
											local bar_bottomright = { x = anchors.topleft.x - 2, y = anchors.bottomleft.y }
											Lib_esp.draw_healthbar(bar_topleft, bar_bottomright, health, maxhealth, {0,255,0}, "vertical", false)
										end

										-- Nametag
										if teamGroupbox.nametag.Value and anchors and anchors.top then
											dx9.DrawString({ anchors.top.x, anchors.top.y - 16 }, playerColor, this_custom_name)
										end

										-- Tracer
										if teamGroupbox.tracer.Value and anchors and anchors.bottom then
											local loc
											if Current_tracer_type == 1 then
												loc = { dx9.size().width / 2, dx9.size().height / 1.1 }
											elseif Current_tracer_type == 2 then
												loc = { dx9.size().width / 2, dx9.size().height }
											elseif Current_tracer_type == 3 then
												loc = { dx9.size().width / 2, 1 }
											else
												loc = { dx9.GetMouse().x, dx9.GetMouse().y }
											end
											dx9.DrawLine(loc, { anchors.bottom.x, anchors.bottom.y }, playerColor, 1)
										end

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
						-- Autoshoot feature
						if Master_esp_settings.autoshoot.Value then
							local now = os.clock()
							if now - last_autoshoot_time >= (1/240) then
								dx9.Mouse1Click()
								last_autoshoot_time = now
							end
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