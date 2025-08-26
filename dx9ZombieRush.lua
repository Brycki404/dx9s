--indent size 4

config = _G.config or {
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
if _G.config == nil then
	_G.config = config
	config = _G.config
end

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

lib_esp = loadstring(dx9.Get(config.urls.LibESP))()

interface = lib_ui:CreateWindow({
	Title = "Zombie Rush | dx9ware | By @Brycki";
	Size = { 500, 500 };
	Resizable = true;

	ToggleKey = config.settings.menu_toggle_keybind;

	FooterToggle = true;
	FooterRGB = true;
	FontColor = { 255, 255, 255 };
	MainColor = { 32, 26, 68 };
	BackgroundColor = { 26, 21, 55 };
	AccentColor = { 81, 37, 112 };
	OutlineColor = { 54, 47, 90 };
})

tabs = {
	settings = interface:AddTab("Settings");
	players = interface:AddTab("Players");
    zombies = interface:AddTab("Zombies");
}

groupboxes = {
	esp_settings = tabs.settings:AddLeftGroupbox("ESP");
	aimbot_settings = tabs.settings:AddRightGroupbox("Aimbot");
	players_esp = tabs.players:AddMiddleGroupbox("ESP");
    zombies_aimbot = tabs.zombies:AddMiddleGroupbox("Aimbot");
};
    
esp_settings = {
	enabled = groupboxes.esp_settings
		:AddToggle({
			Default = config.settings.esp_enabled;
			Text = "ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Global ESP" or "[settings] Disabled Global ESP", 1)
		end);

	box_type = groupboxes.esp_settings
		:AddDropdown({
			Text = "Box Type";
			Default = config.settings.box_type;
			Values = { "Corners", "2D Box", "3D Box" };
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Box Type: " .. value, 1)
		end);

	tracer_type = groupboxes.esp_settings
		:AddDropdown({
			Text = "Tracer Type";
			Default = config.settings.tracer_type;
			Values = { "Near-Bottom", "Bottom", "Top", "Mouse" };
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Tracer Type: " .. value, 1)
		end);
}

aimbot_settings = {
	enabled = groupboxes.aimbot_settings
		:AddToggle({
			Default = config.settings.aimbot_enabled;
			Text = "Aimbot Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Aimbot" or "[settings] Disabled Aimbot", 1)
			if not value then
				_G.aimbot_target_address = nil
				_G.aimbot_target_screen_pos = nil
			end
		end);

	part = groupboxes.aimbot_settings
		:AddDropdown({
			Text = "Aimbot Part";
			Default = config.settings.aimbot_part;
			Values = { "Head", "HumanoidRootPart" };
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Aimbot Part: " .. value, 1)
		end);

    first_person_smoothness = groupboxes.aimbot_settings:AddSlider({
		Default = config.settings.first_person_smoothness;
		Text = "First Person Smoothness";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});

    first_person_sensitivity = groupboxes.aimbot_settings:AddSlider({
		Default = config.settings.first_person_sensitivity;
		Text = "First Person Sensitivity";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});

    third_person_vertical_smoothness = groupboxes.aimbot_settings:AddSlider({
		Default = config.settings.third_person_vertical_smoothness;
		Text = "Third Person Vertical Smoothness";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});

	third_person_horizontal_smoothness = groupboxes.aimbot_settings:AddSlider({
		Default = config.settings.third_person_horizontal_smoothness;
		Text = "Third Person Horizontal Smoothness";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});
}

local aimbot_target_address = _G.aimbot_target_address or nil
local aimbot_target_screen_pos = _G.aimbot_target_screen_pos or nil

players_esp = {
	enabled = groupboxes.players_esp
		:AddToggle({
			Default = config.players.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled ESP" or "[Players] Disabled ESP", 1)
		end);

	distance = groupboxes.players_esp
		:AddToggle({
			Default = config.players.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled Distance" or "[Players] Disabled Distance", 1)
		end);

    healthbar = groupboxes.players_esp:AddToggle({
			Default = config.players.healthbar;
			Text = "HealthBar";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled HealthBar" or "[Players] Disabled HealthBar", 1)
		end);

	healthtag = groupboxes.players_esp:AddToggle({
			Default = config.players.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled HealthTag" or "[Players] Disabled HealthTag", 1)
		end);

	maxhealthtag = groupboxes.players_esp:AddToggle({
			Default = config.players.maxhealthtag;
			Text = "MaxHealthTag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled MaxHealthTag" or "[Players] Disabled MaxHealthTag", 1)
		end);
    
	nametag = groupboxes.players_esp
		:AddToggle({
			Default = config.players.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled Nametag" or "[Players] Disabled Nametag", 1)
		end);

	tracer = groupboxes.players_esp
		:AddToggle({
			Default = config.players.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled Tracer" or "[Players] Disabled Tracer", 1)
		end);

	color = groupboxes.players_esp:AddColorPicker({
		Default = config.players.color;
		Text = "Color";
	});

    distance_limit = groupboxes.players_esp:AddSlider({
		Default = config.players.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

zombies_aimbot = {
    enabled = groupboxes.zombies_aimbot
		:AddToggle({
			Default = config.zombies.aimbot;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Zombies] Enabled Aimbot" or "[Zombies] Disabled Aimbot", 1)
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

datamodel = dx9.GetDatamodel()
workspace = dx9.FindFirstChild(datamodel, "Workspace")
services = {
	players = dx9.FindFirstChild(datamodel, "Players");
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

current_aimbot_part = _G.Get_Index("aimbot_part", aimbot_settings.part.Value)
current_tracer_type = _G.Get_Index("tracer", esp_settings.tracer_type.Value)
current_box_type = _G.Get_Index("box", esp_settings.box_type.Value)

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

if _G.ZombiesTask == nil then
	_G.ZombiesTask = function()
		if aimbot_settings.enabled.Value and zombies_aimbot.enabled.Value then
			local ZombieStorage = dx9.FindFirstChild(workspace, "Zombie Storage")
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
                                local my_root_pos = dx9.GetPosition(my_root)
                                local root_pos = dx9.GetPosition(root)
                                local head_pos = dx9.GetPosition(head)
                                local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                                local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                                local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

                                local screen_pos = nil
                                if current_aimbot_part == 1 then
                                    screen_pos = head_screen_pos
                                elseif current_aimbot_part == 2 then
                                    screen_pos = root_screen_pos
                                end

                                if _G.IsOnScreen(head_screen_pos) or _G.IsOnScreen(root_screen_pos) then
                                    if aimbot_settings.enabled.Value and zombies_aimbot.enabled.Value then
                                        if zombie == aimbot_target_address then
                                            aimbot_target_screen_pos = screen_pos
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

                if aimbot_settings.enabled.Value and zombies_aimbot.enabled.Value then
                    aimbot_target_address = closest_zombie_address
                    aimbot_target_screen_pos = closest_zombie_screen_pos
                    
                    if aimbot_target_address and _G.IsOnScreen(aimbot_target_screen_pos) then
                        local mouse_moved = false
                        if mouse_moved == false then
                            dx9.DrawCircle({aimbot_target_screen_pos.x, aimbot_target_screen_pos.y}, {255, 255, 255}, 15)
                            dx9.SetAimbotValue("x", 0)
                            dx9.SetAimbotValue("y", 0)
                            dx9.SetAimbotValue("z", 0)
                            dx9.FirstPersonAim({
                                aimbot_target_screen_pos.x + screen_size.width/2,
                                aimbot_target_screen_pos.y + screen_size.height/2
                            }, aimbot_settings.first_person_smoothness.Value, aimbot_settings.first_person_sensitivity.Value)
                            if not dx9.isRightClickHeld() then
								dx9.ThirdPersonAim({
									aimbot_target_screen_pos.x,
									aimbot_target_screen_pos.y
								}, aimbot_settings.third_person_horizontal_smoothness.Value, aimbot_settings.third_person_vertical_smoothness.Value)
							end
							mouse_moved = true
                        end
                    end
                else
                    aimbot_target_address = nil
                    aimbot_target_screen_pos = nil
                end
                _G.aimbot_target_address = aimbot_target_address
                _G.aimbot_target_screen_pos = aimbot_target_screen_pos
            end
		end
	end
end
if _G.ZombiesTask then
	_G.ZombiesTask()
end

if _G.PlayerTask == nil then
	_G.PlayerTask = function()
		if esp_settings.enabled.Value and players_esp.enabled.Value then
			for _, player in pairs(dx9.GetChildren(services.players)) do
				local playerName = dx9.GetName(player)
				if playerName and playerName ~= local_player_name then
					local character = dx9.FindFirstChild(workspace, playerName)
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

                                local my_root_pos = dx9.GetPosition(my_root)
                                local root_pos = dx9.GetPosition(root)
                                local head_pos = dx9.GetPosition(head)
                                local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                                local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                                local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

                                local customName = playerName
                                if players_esp.healthtag.Value and players_esp.maxhealthtag.Value and health ~= nil and maxhealth ~= nil then
                                    customName = playerName .. " | " .. tostring(health) .. "/" .. tostring(maxhealth) .. " hp"
                                elseif players_esp.healthtag.Value and health ~= nil then
                                    customName = playerName .. " | " .. tostring(health) .. " hp"
                                end

                                if _G.IsOnScreen(head_screen_pos) or _G.IsOnScreen(root_screen_pos) then
                                    if root_distance < players_esp.distance_limit.Value then
                                        lib_esp.draw({
                                            target = character;
                                            color = players_esp.color.Value;
                                            healthbar = players_esp.healthbar.Value;
                                            nametag = players_esp.nametag.Value;
                                            distance = players_esp.distance.Value;
                                            custom_nametag = customName;
                                            custom_distance = tostring(root_distance);
                                            tracer = players_esp.tracer.Value;
                                            tracer_type = current_tracer_type;
                                            box_type = current_box_type;
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