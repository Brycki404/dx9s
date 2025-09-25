--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines

Config = _G.Config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
	};
    settings = {
		aimbot_enabled = true;
		aimbot_part = 1; -- 1 = "Head", 2 = "HumanoidRootPart"
        first_person_smoothness = 1;
        first_person_sensitivity = 1;
		third_person_vertical_smoothness = 1;
        third_person_horizontal_smoothness = 1;
		
		menu_toggle_keybind = "[F2]";
		
		esp_enabled = true;
    	box_type = 1; -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    };
    players = {
        enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
        healthbar = true;
		healthtag = true;
		maxhealthtag = true;
        color = { 0, 255, 0 };
		distance_limit = 10000;
    };
    zombies = {
        aimbot = true;
        enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
        healthbar = true;
		healthtag = true;
		maxhealthtag = true;
		color = { 255, 255, 255 };
		distance_limit = 10000;
	};
};
if _G.Config == nil then
	_G.Config = Config
	Config = _G.Config
end

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "Zombie Rush | dx9ware | By @Brycki";
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
    zombies = Interface:AddTab("Zombies");
}

Groupboxes = {
	esp_settings = Tabs.settings:AddLeftGroupbox("ESP");
	aimbot_settings = Tabs.settings:AddRightGroupbox("Aimbot");
	Players_esp = Tabs.players:AddMiddleGroupbox("ESP");
    Zombies_aimbot = Tabs.zombies:AddMiddleGroupbox("Aimbot");
};

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
				_G.aimbot_target_address = nil
				_G.Aimbot_target_screen_pos = nil
			end
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

    first_person_smoothness = Groupboxes.aimbot_settings:AddSlider({
		Default = Config.settings.first_person_smoothness;
		Text = "First Person Smoothness";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});

    first_person_sensitivity = Groupboxes.aimbot_settings:AddSlider({
		Default = Config.settings.first_person_sensitivity;
		Text = "First Person Sensitivity";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});

    third_person_vertical_smoothness = Groupboxes.aimbot_settings:AddSlider({
		Default = Config.settings.third_person_vertical_smoothness;
		Text = "Third Person Vertical Smoothness";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});

	third_person_horizontal_smoothness = Groupboxes.aimbot_settings:AddSlider({
		Default = Config.settings.third_person_horizontal_smoothness;
		Text = "Third Person Horizontal Smoothness";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});
}

local aimbot_target_address = _G.aimbot_target_address or nil
local Aimbot_target_screen_pos = _G.Aimbot_target_screen_pos or nil

Players_esp = {
	enabled = Groupboxes.Players_esp
		:AddToggle({
			Default = Config.players.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Players] Enabled ESP" or "[Players] Disabled ESP", 1)
		end);

	distance = Groupboxes.Players_esp
		:AddToggle({
			Default = Config.players.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Players] Enabled Distance" or "[Players] Disabled Distance", 1)
		end);

    healthbar = Groupboxes.Players_esp:AddToggle({
			Default = Config.players.healthbar;
			Text = "HealthBar";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Players] Enabled HealthBar" or "[Players] Disabled HealthBar", 1)
		end);

	healthtag = Groupboxes.Players_esp:AddToggle({
			Default = Config.players.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Players] Enabled HealthTag" or "[Players] Disabled HealthTag", 1)
		end);

	maxhealthtag = Groupboxes.Players_esp:AddToggle({
			Default = Config.players.maxhealthtag;
			Text = "MaxHealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Players] Enabled MaxHealthTag" or "[Players] Disabled MaxHealthTag", 1)
		end);
    
	nametag = Groupboxes.Players_esp
		:AddToggle({
			Default = Config.players.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Players] Enabled Nametag" or "[Players] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.Players_esp
		:AddToggle({
			Default = Config.players.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Players] Enabled Tracer" or "[Players] Disabled Tracer", 1)
		end);

	color = Groupboxes.Players_esp:AddColorPicker({
		Default = Config.players.color;
		Text = "Color";
	});

    distance_limit = Groupboxes.Players_esp:AddSlider({
		Default = Config.players.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

Zombies_aimbot = {
    enabled = Groupboxes.Zombies_aimbot
		:AddToggle({
			Default = Config.zombies.aimbot;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Zombies] Enabled Aimbot" or "[Zombies] Disabled Aimbot", 1)
		end);
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

if _G.ZombiesTask == nil then
	_G.ZombiesTask = function()
		if Aimbot_settings.enabled.Value and Zombies_aimbot.enabled.Value then
			local ZombieStorage = dx9.FindFirstChild(Workspace, "Zombie Storage")
            if ZombieStorage ~= nil and ZombieStorage ~= 0 then
                local closest_zombie_address = nil
                local closest_zombie_value = nil
                local closest_zombie_screen_pos = nil
                for _, zombie in pairs(dx9.GetChildren(ZombieStorage)) do
                    local zombieName = dx9.GetName(zombie)
                    if zombieName then
                        local root = dx9.FindFirstChild(zombie, "HumanoidRootPart")
                        local head = dx9.FindFirstChild(zombie, "Head")
                        local humanoid = dx9.FindFirstChild(zombie, "Humanoid")
                        if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
                            local health = dx9.GetHealth(humanoid) or nil
                            if health ~= nil then
                                health = math.floor(health)
                            end
                            if health ~= nil and health > 0 then
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

                                if _G.IsOnScreen(head_screen_pos) or _G.IsOnScreen(root_screen_pos) then
                                    if Aimbot_settings.enabled.Value and Zombies_aimbot.enabled.Value then
                                        if zombie == aimbot_target_address then
                                            Aimbot_target_screen_pos = screen_pos
                                        end

                                        local mouse_distance = _G.Get_Distance_From_Mouse(screen_pos)
                                        local aimbot_range = 9999 --dx9.GetAimbotValue("range")
                                        local aimbot_fov = dx9.GetAimbotValue("fov")
                                        if mouse_distance and mouse_distance <= aimbot_fov and root_distance <= aimbot_range then
                                            local current_aimbot_type = dx9.GetAimbotValue("type")
                                            if current_aimbot_type == 1 then
                                                if closest_zombie_value == nil or mouse_distance < closest_zombie_value then
                                                    closest_zombie_address = zombie
                                                    closest_zombie_value = mouse_distance
                                                    closest_zombie_screen_pos = screen_pos
                                                end
                                            elseif current_aimbot_type == 0 then
                                                if closest_zombie_value == nil or root_distance < closest_zombie_value then
                                                    closest_zombie_address = zombie
                                                    closest_zombie_value = root_distance
                                                    closest_zombie_screen_pos = screen_pos
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                if Aimbot_settings.enabled.Value and Zombies_aimbot.enabled.Value then
                    aimbot_target_address = closest_zombie_address
                    Aimbot_target_screen_pos = closest_zombie_screen_pos
                    
                    if aimbot_target_address and _G.IsOnScreen(Aimbot_target_screen_pos) then
						if not _G.lastAimbotFrame or _G.lastAimbotFrame and (os.clock() - _G.lastAimbotFrame) > (1/60) then
							local mouse_moved = false
							if mouse_moved == false then
								dx9.DrawCircle({Aimbot_target_screen_pos.x, Aimbot_target_screen_pos.y}, {255, 255, 255}, 15)
								dx9.SetAimbotValue("x", 0)
								dx9.SetAimbotValue("y", 0)
								dx9.SetAimbotValue("z", 0)
								dx9.FirstPersonAim({
									Aimbot_target_screen_pos.x + Screen_size.width/2,
									Aimbot_target_screen_pos.y + Screen_size.height/2
								}, Aimbot_settings.first_person_smoothness.Value, Aimbot_settings.first_person_sensitivity.Value)
								if not dx9.isRightClickHeld() then
									dx9.ThirdPersonAim({
										Aimbot_target_screen_pos.x,
										Aimbot_target_screen_pos.y
									}, Aimbot_settings.third_person_horizontal_smoothness.Value, Aimbot_settings.third_person_vertical_smoothness.Value)
								end
								mouse_moved = true
							end
							_G.lastAimbotFrame = os.clock()
						end
                    end
                else
                    aimbot_target_address = nil
                    Aimbot_target_screen_pos = nil
                end
                _G.aimbot_target_address = aimbot_target_address
                _G.Aimbot_target_screen_pos = Aimbot_target_screen_pos
            end
		end
	end
end
if _G.ZombiesTask then
	_G.ZombiesTask()
end

if _G.PlayerTask == nil then
	_G.PlayerTask = function()
		if Esp_settings.enabled.Value and Players_esp.enabled.Value then
			for _, player in pairs(dx9.GetChildren(Services.players)) do
				local playerName = dx9.GetName(player)
				if playerName and playerName ~= Local_player_name then
					local character = dx9.FindFirstChild(Workspace, playerName)
					if character and character ~= 0 then
						local root = dx9.FindFirstChild(character, "HumanoidRootPart")
						local head = dx9.FindFirstChild(character, "Head")
						local humanoid = dx9.FindFirstChild(character, "Humanoid")

						if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
                            local health = dx9.GetHealth(humanoid) or nil
                            if health ~= nil then
                                health = math.floor(health)
                            end
                            if health ~= nil and health > 0 then
                                local maxhealth = dx9.GetMaxHealth(humanoid) or nil
                                if maxhealth ~= nil then
                                    maxhealth = math.floor(maxhealth)
                                end

                                local my_root_pos = dx9.GetPosition(My_root)
                                local root_pos = dx9.GetPosition(root)
                                local head_pos = dx9.GetPosition(head)
                                local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                                local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                                local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

                                local customName = playerName
                                if Players_esp.healthtag.Value and Players_esp.maxhealthtag.Value and health ~= nil and maxhealth ~= nil then
                                    customName = playerName .. " | " .. tostring(health) .. "/" .. tostring(maxhealth) .. " hp"
                                elseif Players_esp.healthtag.Value and health ~= nil then
                                    customName = playerName .. " | " .. tostring(health) .. " hp"
                                end

                                if _G.IsOnScreen(head_screen_pos) or _G.IsOnScreen(root_screen_pos) then
                                    if root_distance < Players_esp.distance_limit.Value then
                                        Lib_esp.draw({
                                            target = character;
                                            color = Players_esp.color.Value;
                                            healthbar = Players_esp.healthbar.Value;
                                            nametag = Players_esp.nametag.Value;
                                            distance = Players_esp.distance.Value;
                                            custom_nametag = customName;
                                            custom_distance = tostring(root_distance);
                                            tracer = Players_esp.tracer.Value;
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
	end
end
if _G.PlayerTask then
	_G.PlayerTask()
end