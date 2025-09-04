--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines

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
		
		esp_enabled = true;
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
        color = { 255, 255, 255 };
		distance_limit = 10000;
    };
}
if _G.Config == nil then
	_G.Config = Config
	Config = _G.Config
end

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "Operation One | dx9ware | By @Brycki";
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
	animals = Interface:AddTab("Hunting");
	trees = Interface:AddTab("Logging");
	ores = Interface:AddTab("Mining");
}

Groupboxes = {
	esp_settings = Tabs.settings:AddLeftGroupbox("ESP");
	aimbot_settings = Tabs.settings:AddRightGroupbox("Aimbot");
	players = Tabs.players:AddMiddleGroupbox("Players ESP");
	animals = Tabs.animals:AddLeftGroupbox("Hunting ESP");
	hunting = Tabs.animals:AddRightGroupbox("Hunting Config");
	trees = Tabs.trees:AddMiddleGroupbox("Logging ESP");
	ores = Tabs.ores:AddLeftGroupbox("Mining ESP");
	oreconfig = Tabs.ores:AddRightGroupbox("Mining Config");
}

Esp_settings = {
	enabled = Groupboxes.esp_settings
		:AddToggle({
			Default = Config.settings.esp_enabled;
			Text = "ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Global ESP" or "[settings] Disabled Global ESP", 1)
		end);

	box_type = Groupboxes.esp_settings
		:AddDropdown({
			Text = "Box Type";
			Default = Config.settings.box_type;
			Values = { "Corners", "2D Box", "3D Box" };
		})
		:OnChanged(function(value)
			Lib_ui:Notify("[settings] Box Type: " .. value, 1)
		end);

	tracer_type = Groupboxes.esp_settings
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
				_G.aimbot_target_name = nil
				_G.aimbot_target_screen_pos = nil
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

local aimbot_target_name = _G.aimbot_target_name or nil
local aimbot_target_screen_pos = _G.aimbot_target_screen_pos or nil

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

    distance_limit = Groupboxes.players:AddSlider({
		Default = Config.players.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 5000;
		Rounding = 0;
	});
}

Animals = {
	enabled = Groupboxes.animals
		:AddToggle({
			Default = Config.animals.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[hunting] Enabled ESP" or "[hunting] Disabled ESP", 1)
		end);

	distance = Groupboxes.animals
		:AddToggle({
			Default = Config.animals.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[hunting] Enabled Distance" or "[hunting] Disabled Distance", 1)
		end);

	nametag = Groupboxes.animals
		:AddToggle({
			Default = Config.animals.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[hunting] Enabled Nametag" or "[hunting] Disabled Nametag", 1)
		end);

	healthtag = Groupboxes.animals
		:AddToggle({
			Default = Config.animals.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[hunting] Enabled HealthTag" or "[hunting] Disabled HealthTag", 1)
		end);

	tracer = Groupboxes.animals
		:AddToggle({
			Default = Config.animals.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[hunting] Enabled Tracer" or "[hunting] Disabled Tracer", 1)
		end);

    color = Groupboxes.animals:AddColorPicker({
		Default = Config.animals.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.animals:AddSlider({
		Default = Config.animals.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 5000;
		Rounding = 0;
	});
}

Hunting = {}
for _, animalTab in pairs(Config.animals.entries) do
	local animalType = animalTab.AnimalType
	local animalEnabled = animalTab.Enabled
	Hunting[animalType.."_enabled"] = Groupboxes.hunting
		:AddToggle({
			Default = animalEnabled;
			Text = animalType.." ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[hunting] Enabled "..animalType.." ESP" or "[hunting] Disabled "..animalType.." ESP", 1)
		end)

	Hunting[animalType.."_color"] = Groupboxes.hunting
		:AddColorPicker({
			Default = Config.animals.color;
			Text = animalType.." Color";
		})

	Hunting[animalType.."_distance_limit"] = Groupboxes.hunting
		:AddSlider({
			Default = Config.animals.distance_limit;
			Text = animalType.." ESP Distance Limit";
			Min = 0;
			Max = 5000;
			Rounding = 0;
		})
end

Trees = {
	enabled = Groupboxes.trees
		:AddToggle({
			Default = Config.trees.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[logging] Enabled ESP" or "[logging] Disabled ESP", 1)
		end);

	thunderstruck_only = Groupboxes.trees
		:AddToggle({
			Default = Config.trees.thunderstruck_only;
			Text = "Thunderstruck Only";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[logging] Enabled Thunderstruck Only" or "[logging] Disabled Thundrstruck Only", 1)
		end);

	distance = Groupboxes.trees
		:AddToggle({
			Default = Config.trees.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[logging] Enabled Distance" or "[logging] Disabled Distance", 1)
		end);

	nametag = Groupboxes.trees
		:AddToggle({
			Default = Config.trees.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[logging] Enabled Nametag" or "[logging] Disabled Nametag", 1)
		end);

	healthtag = Groupboxes.trees
		:AddToggle({
			Default = Config.trees.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[logging] Enabled HealthTag" or "[logging] Disabled HealthTag", 1)
		end);

	tracer = Groupboxes.trees
		:AddToggle({
			Default = Config.trees.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[logging] Enabled Tracer" or "[logging] Disabled Tracer", 1)
		end);

    color = Groupboxes.trees:AddColorPicker({
		Default = Config.trees.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.trees:AddSlider({
		Default = Config.trees.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 5000;
		Rounding = 0;
	});
}

Ores = {
	enabled = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[mining] Enabled ESP" or "[mining] Disabled ESP", 1)
		end);

	hide_empty = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.hide_empty;
			Text = "Hide Empty";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[mining] Enabled Hide Empty" or "[mining] Disabled Hide Empty", 1)
		end);

	distance = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[mining] Enabled Distance" or "[mining] Disabled Distance", 1)
		end);

	nametag = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[mining] Enabled Nametag" or "[mining] Disabled Nametag", 1)
		end);

	healthtag = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[mining] Enabled HealthTag" or "[mining] Disabled HealthTag", 1)
		end);

	tracer = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[mining] Enabled Tracer" or "[mining] Disabled Tracer", 1)
		end);

    color = Groupboxes.ores:AddColorPicker({
		Default = Config.ores.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.ores:AddSlider({
		Default = Config.ores.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 5000;
		Rounding = 0;
	});
}

Oreconfig = {}
for _, oreTab in pairs(Config.ores.entries) do
	local oreName = oreTab.OreName
	local oreEnabled = oreTab.Enabled
	Oreconfig[oreName.."_enabled"] = Groupboxes.oreconfig
		:AddToggle({
			Default = oreEnabled;
			Text = oreName.." ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[mining] Enabled "..oreName.." ESP" or "[mining] Disabled "..oreName.." ESP", 1)
		end)

	Oreconfig[oreName.."_color"] = Groupboxes.oreconfig
		:AddColorPicker({
			Default = Config.ores.color;
			Text = oreName.." Color";
		})

	Oreconfig[oreName.."_distance_limit"] = Groupboxes.oreconfig
		:AddSlider({
			Default = Config.ores.distance_limit;
			Text = oreName.." ESP Distance Limit";
			Min = 0;
			Max = 5000;
			Rounding = 0;
		})
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
			table = { "Closest to Mouse", "Distance" }
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

Datamodel = dx9.GetDatamodel()

Worskpace = dx9.FindFirstChild(Datamodel, "Workspace")

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

Current_aimbot_part = _G.Get_Index("aimbot_part", Aimbot_settings.part.Value)
Current_tracer_type = _G.Get_Index("tracer", Esp_settings.tracer_type.Value)
Current_box_type = _G.Get_Index("box", Esp_settings.box_type.Value)

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

Workspace_entities = dx9.FindFirstChild(Worskpace, "WORKSPACE_Entities")
Player_entities = dx9.FindFirstChild(Workspace_entities, "Players")
if Workspace_entities == nil or Workspace_entities == 0 or Player_entities == nil or Player_entities == 0 then
	return false
end

My_player = dx9.FindFirstChild(Services.players, Local_player_name)
My_character = nil
My_head = nil
My_root = nil
My_humanoid = nil

if My_player == nil or My_player == 0 then
	return
elseif My_player ~= nil and My_player ~= 0 then
    My_character = dx9.FindFirstChild(Player_entities, Local_player_name)
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

Health_value_name = "Health"

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

dx9.ShowConsole(true)

CleanCacheTimeout = 3

if _G.PlayerCache == nil then
	_G.PlayerCache = {}
else
	for i, cached_tab in pairs(_G.PlayerCache) do
		if not cached_tab.last_update or (os.clock() - cached_tab.last_update) > CleanCacheTimeout then
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
					if playerName and playerName ~= Local_player_name then
						_G.PlayerCache[tostring(player)] = {
							player = player;
							playerName = playerName;
							last_update = os.clock();
						}
					end
				elseif cached_tab then
					local teamName = dx9.GetTeam(player)
					local playerColor = Players.color
					if teamName == "Outlaws" then
						playerColor = {255, 0, 0}
					elseif teamName == "Lawmen" then
						playerColor = {0, 0, 255}
					elseif teamName == "Citizens" then
						playerColor = {255, 255, 0}
					end
					
					local character = dx9.FindFirstChild(Player_entities, cached_tab.playerName)
					if character and character ~= 0 then
						local root = dx9.FindFirstChild(character, "HumanoidRootPart")
						local head = dx9.FindFirstChild(character, "Head")
						local humanoid = dx9.FindFirstChild(character, "Humanoid")

						if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
							if teamName and (teamName == "Outlaws" or teamName == "Lawmen" or teamName == "Citizens") then
								local my_root_pos = dx9.GetPosition(My_root)
								local root_pos = dx9.GetPosition(root)
								local head_pos = dx9.GetPosition(head)
								local root_distance = _G.Get_Distance(my_root_pos, root_pos)
								local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
								local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

								local screen_pos = nil
								if Current_aimbot_part == 1 then
									screen_pos = head_screen_pos
								elseif Current_aimbot_part == 2 then
									screen_pos = root_screen_pos
								end

								if _G.IsOnScreen(screen_pos) then
									if Aimbot_settings.enabled.Value then
										if cached_tab.playerName == aimbot_target_name then
											aimbot_target_screen_pos = screen_pos
										end

										--if not Aimbot_settings.sticky_aim.Value or Aimbot_settings.sticky_aim.Value and not aimbot_target_name then
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
									
									if Esp_settings.enabled.Value and Players.enabled.Value then
										if root_distance < Players.distance_limit.Value then
											Lib_esp.draw({
												target = character,
												color = playerColor,
												healthbar = Config.players.healthbar,
												nametag = Players.nametag.Value,
												distance = Players.distance.Value,
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

			if Aimbot_settings.enabled.Value then
				--swapping targets
				if Aimbot_settings.sticky_aim.Value then
					if dx9.isRightClickHeld() then
						aimbot_target_name = nil
						aimbot_target_screen_pos = nil
					end
					if not aimbot_target_name or aimbot_target_name and aimbot_target_name == 0 then
						aimbot_target_name = closest_player_name
						aimbot_target_screen_pos = closest_player_screen_pos
					end
				else
					aimbot_target_name = closest_player_name
					aimbot_target_screen_pos = closest_player_screen_pos
				end

				if aimbot_target_name and _G.IsOnScreen(aimbot_target_screen_pos) then
					--print(aimbot_target_name.." | x: "..aimbot_target_screen_pos.x.." | y: "..aimbot_target_screen_pos.y)
					local mouse_moved = false
					if mouse_moved == false then
						dx9.SetAimbotValue("x", 0)
						dx9.SetAimbotValue("y", 0)
						dx9.SetAimbotValue("z", 0)
						dx9.FirstPersonAim({
							aimbot_target_screen_pos.x + Screen_size.width/2,
							aimbot_target_screen_pos.y + Screen_size.height/2
						}, Aimbot_settings.smoothness.Value, 1)
						mouse_moved = true
					end
				end
			else
				aimbot_target_name = nil
				aimbot_target_screen_pos = nil
			end
			_G.aimbot_target_name = aimbot_target_name
			_G.aimbot_target_screen_pos = aimbot_target_screen_pos
		end
	end
end
if _G.PlayerTask then
	_G.PlayerTask()
end