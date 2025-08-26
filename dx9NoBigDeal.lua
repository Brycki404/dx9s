--indent size 4

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
	};
    settings = {
		aimbot_enabled = true;
		sticky_aim = false;
		aimbot_part = 1; -- 1 = "Head", 2 = "HumanoidRootPart"
		aimbot_smoothness = 5;
		
		menu_toggle_keybind = "[F3]";
		
		esp_enabled = true;
    	box_type = 1; -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    };
    players = {
        enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
        color = { 0, 255, 0 };
		distance_limit = 10000;
    };
    items = {
        enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 255, 255 };
		distance_limit = 10000;
		entries = {
			{
				name = "Phone";
				part = "Root";
				parent = "Phone";
				Enabled = true;
			};
			{
				name = "Car";
				part = "DriveSeat";
				parent = "Car";
				Enabled = true;
			};
			{
				name = "Limo";
				part = "DriveSeat";
				parent = "Limo";
				Enabled = true;
			};
			{
				name = "Disk";
				part = "Root";
				parent = "Disk";
				Enabled = true;
			};
			{
				name = "Briefcase";
				part = "Root";
				parent = "Briefcase";
				Enabled = true;
			};
			{
				name = "Cash";
				part = "Root";
				parent = "Cash";
				Enabled = true;
			};
			{
				name = "Fake Cash";
				part = "Root";
				parent = "FakeCash";
				Enabled = true;
			};
		};
	};
	ammo = {
		enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 255, 0 };
		distance_limit = 10000;
		entries = {
			{
				name = "Kick10 Ammo";
				part = "Metal";
				parent = "Kick10Mag";
				Enabled = true;
			};
			{
				name = "TheFix Ammo";
				part = "Meshes/thefix_fixMag";
				parent = "TheFixMag";
				Enabled = true;
			};
			{
				name = "Snub Ammo";
				part = "Root";
				parent = "SnubCylinder";
				Enabled = true;
			};
			{
				name = "Strikeout Ammo";
				part = "Root";
				parent = "StrikeoutMag";
				Enabled = true;
			};
			{
				name = "Pistol Ammo";
				part = "Root";
				parent = "PistolMag";
				Enabled = true;
			};
			{
				name = "MP5 Ammo";
				part = "Root";
				parent = "MP5Mag";
				Enabled = true;
			};
			{
				name = "AK47 Ammo";
				part = "Root";
				parent = "AKMag";
				Enabled = true;
			};
			{
				name = "MAC10 Ammo";
				part = "Root";
				parent = "MAC10MAG";
				Enabled = true;
			};
			{
				name = "Magnum Ammo";
				part = "Root";
				parent = "MagnumRound";
				Enabled = true;
			};
			{
				name = "Ace Ammo";
				part = "Root";
				parent = "AceMag";
				Enabled = true;
			};
			{
				name = "Sniper Ammo";
				part = "Root";
				parent = "SniperBullet";
				Enabled = true;
			};
			{
				name = "Pitch Ammo";
				part = "Root";
				parent = "PitchMag";
				Enabled = true;
			};
			{
				name = "Forte Ammo";
				part = "Root";
				parent = "ForteMag";
				Enabled = true;
			};
			{
				name = "Fix Ammo";
				part = "Root";
				parent = "FixMag";
				Enabled = true;
			};
			{
				name = "Ruby Ammo";
				part = "Root";
				parent = "RubyMag";
				Enabled = true;
			};
			{
				name = "Jericho Ammo";
				part = "Root";
				parent = "JerichoMag";
				Enabled = true;
			};
		};
	};
	weapons = {
		enabled = true;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 0, 0 };
		distance_limit = 10000;
		entries = {
			{
				name = "Raygun";
				part = "Root";
				parent = "Raygun";
				Enabled = true;
			};
			{
				name = "Snub";
				part = "Root";
				parent = "Snub";
				Enabled = true;
			};
			{
				name = "Pistol";
				part = "Root";
				parent = "Pistol";
				Enabled = true;
			};
			{
				name = "Magnum";
				part = "Root";
				parent = "MAGNUM";
				Enabled = true;
			};
			{
				name = "Jericho";
				part = "Root";
				parent = "Jericho";
				Enabled = true;
			};
			{
				name = "Smoke Grenade";
				part = "grenadebody";
				parent = "SmokeGrenade";
				Enabled = true;
			};
			{
				name = "AK47";
				part = "Root";
				parent = "AK47";
				Enabled = true;
			};
			{
				name = "Forte";
				part = "Root";
				parent = "Forte";
				Enabled = true;
			};
			{
				name = "PitchGun";
				part = "Root";
				parent = "PitchGun";
				Enabled = true;
			};
			{
				name = "Sniper";
				part = "Root";
				parent = "Sniper";
				Enabled = true;
			};
			{
				name = "MAC10";
				part = "Root";
				parent = "ToolboxMAC10";
				Enabled = true;
			};
			{
				name = "Ruby";
				part = "Root";
				parent = "Ruby";
				Enabled = true;
			};
			{
				name = "DB";
				part = "Root";
				parent = "DB";
				Enabled = true;
			};
			{
				name = "Grenade";
				part = "Meshes/grenade_striker";
				parent = "Grenade";
				Enabled = true;
			};
			{
				name = "Strikeout";
				part = "Root";
				parent = "Strikeout";
				Enabled = true;
			};
			{
				name = "Kick10";
				part = "Root";
				parent = "Kick10";
				Enabled = true;
			};
			{
				name = "Pop22";
				part = "Root";
				parent = "Pop22";
				Enabled = true;
			};
			{
				name = "The Fix";
				part = "Root";
				parent = "TheFix";
				Enabled = true;
			};
			{
				name = "Ace Carbine";
				part = "Root";
				parent = "AceCarbine";
				Enabled = true;
			};
			{
				name = "MP5";
				part = "Root";
				parent = "MP5";
				Enabled = true;
			};
		};
	};
};
if _G.config == nil then
	_G.config = config
	config = _G.config
end

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

lib_esp = loadstring(dx9.Get(config.urls.LibESP))()

interface = lib_ui:CreateWindow({
	Title = "No Big Deal | dx9ware | By @Brycki";
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
	items = interface:AddTab("Items");
	ammo = interface:AddTab("Ammo");
	weapons = interface:AddTab("Weapons");
}

groupboxes = {
	esp_settings = tabs.settings:AddLeftGroupbox("ESP");
	aimbot_settings = tabs.settings:AddRightGroupbox("Aimbot");
	players = tabs.players:AddMiddleGroupbox("Player ESP");
	items = tabs.items:AddLeftGroupbox("Item ESP");
	items_config = tabs.items:AddRightGroupbox("Item Config");
	ammo = tabs.ammo:AddLeftGroupbox("Ammo ESP");
	ammo_config = tabs.ammo:AddRightGroupbox("Ammo Config");
	weapons = tabs.weapons:AddLeftGroupbox("Weapon ESP");
	weapons_config = tabs.weapons:AddRightGroupbox("Weapon Config");
}

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
				_G.aimbot_target_name = nil
				_G.aimbot_target_screen_pos = nil
			end
		end);

	sticky_aim = groupboxes.aimbot_settings
		:AddToggle({
			Default = config.settings.sticky_aim;
			Text = "Sticky Aim Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Sticky Aim" or "[settings] Disabled Sticky Aim", 1)
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

	smoothness = groupboxes.aimbot_settings:AddSlider({
		Default = config.settings.aimbot_smoothness;
		Text = "Aimbot Smoothness";
		Min = 1;
		Max = 50;
		Rounding = 0;
	});
}

local aimbot_target_name = _G.aimbot_target_name or nil
local aimbot_target_screen_pos = _G.aimbot_target_screen_pos or nil

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

items = {
	enabled = groupboxes.items
		:AddToggle({
			Default = config.items.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[items] Enabled ESP" or "[items] Disabled ESP", 1)
		end);

	distance = groupboxes.items
		:AddToggle({
			Default = config.items.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[items] Enabled Distance" or "[items] Disabled Distance", 1)
		end);

	nametag = groupboxes.items
		:AddToggle({
			Default = config.items.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[items] Enabled Nametag" or "[items] Disabled Nametag", 1)
		end);

	tracer = groupboxes.items
		:AddToggle({
			Default = config.items.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[items] Enabled Tracer" or "[items] Disabled Tracer", 1)
		end);

    color = groupboxes.items:AddColorPicker({
		Default = config.items.color;
		Text = "Color";
	});

	distance_limit = groupboxes.items:AddSlider({
		Default = config.items.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

items_config = {}
for _, tab in pairs(config.items.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	items_config[name.."_enabled"] = groupboxes.items_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[items] Enabled "..name.." ESP" or "[items] Disabled "..name.." ESP", 1)
		end)
end

ammo = {
	enabled = groupboxes.ammo
		:AddToggle({
			Default = config.ammo.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[ammo] Enabled ESP" or "[ammo] Disabled ESP", 1)
		end);

	distance = groupboxes.ammo
		:AddToggle({
			Default = config.ammo.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[ammo] Enabled Distance" or "[ammo] Disabled Distance", 1)
		end);

	nametag = groupboxes.ammo
		:AddToggle({
			Default = config.ammo.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[ammo] Enabled Nametag" or "[ammo] Disabled Nametag", 1)
		end);

	tracer = groupboxes.ammo
		:AddToggle({
			Default = config.ammo.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[ammo] Enabled Tracer" or "[ammo] Disabled Tracer", 1)
		end);

    color = groupboxes.ammo:AddColorPicker({
		Default = config.ammo.color;
		Text = "Color";
	});

	distance_limit = groupboxes.ammo:AddSlider({
		Default = config.ammo.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

ammo_config = {}
for _, tab in pairs(config.ammo.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	ammo_config[name.."_enabled"] = groupboxes.ammo_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[ammo] Enabled "..name.." ESP" or "[ammo] Disabled "..name.." ESP", 1)
		end)
end

weapons = {
	enabled = groupboxes.weapons
		:AddToggle({
			Default = config.weapons.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[weapons] Enabled ESP" or "[weapons] Disabled ESP", 1)
		end);

	distance = groupboxes.weapons
		:AddToggle({
			Default = config.weapons.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[weapons] Enabled Distance" or "[weapons] Disabled Distance", 1)
		end);

	nametag = groupboxes.weapons
		:AddToggle({
			Default = config.weapons.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[weapons] Enabled Nametag" or "[weapons] Disabled Nametag", 1)
		end);

	tracer = groupboxes.weapons
		:AddToggle({
			Default = config.weapons.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[weapons] Enabled Tracer" or "[weapons] Disabled Tracer", 1)
		end);

    color = groupboxes.weapons:AddColorPicker({
		Default = config.weapons.color;
		Text = "Color";
	});

	distance_limit = groupboxes.weapons:AddSlider({
		Default = config.weapons.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

weapons_config = {}
for _, tab in pairs(config.weapons.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	weapons_config[name.."_enabled"] = groupboxes.weapons_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[ammo] Enabled "..name.." ESP" or "[ammo] Disabled "..name.." ESP", 1)
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

if _G.PlayerTask == nil then
	_G.PlayerTask = function()
		if players.enabled.Value or aimbot_settings.enabled.Value then
			local closest_player_name = nil
			local closest_player_value = nil
			local closest_player_screen_pos = nil
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

							local screen_pos = nil
							if current_aimbot_part == 1 then
								screen_pos = head_screen_pos
							elseif current_aimbot_part == 2 then
								screen_pos = root_screen_pos
							end

							if _G.IsOnScreen(screen_pos) then
								if aimbot_settings.enabled.Value then
									if playerName == aimbot_target_name then
										aimbot_target_screen_pos = screen_pos
									end

									local mouse_distance = _G.Get_Distance_From_Mouse(screen_pos)
									local aimbot_range = 9999 --dx9.GetAimbotValue("range")
									local aimbot_fov = dx9.GetAimbotValue("fov")
									if mouse_distance and mouse_distance <= aimbot_fov and root_distance <= aimbot_range then
										local current_aimbot_type = dx9.GetAimbotValue("type")
										if current_aimbot_type == 1 then
											if closest_player_value == nil or mouse_distance < closest_player_value then
												closest_player_name = playerName
												closest_player_value = mouse_distance
												closest_player_screen_pos = screen_pos
											end
										elseif current_aimbot_type == 0 then
											if closest_player_value == nil or root_distance < closest_player_value then
												closest_player_name = playerName
												closest_player_value = root_distance
												closest_player_screen_pos = screen_pos
											end
										end
									end
								end
								
								if esp_settings.enabled.Value and players.enabled.Value then
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

			if aimbot_settings.enabled.Value then
				if aimbot_settings.sticky_aim.Value then
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
					local mouse_moved = false
					if mouse_moved == false then
						dx9.SetAimbotValue("x", 0)
						dx9.SetAimbotValue("y", 0)
						dx9.SetAimbotValue("z", 0)
						dx9.FirstPersonAim({
							aimbot_target_screen_pos.x + screen_size.width/2,
							aimbot_target_screen_pos.y + screen_size.height/2
						}, aimbot_settings.smoothness.Value, 1)
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

if not esp_settings.enabled.Value then
	return
end

if _G.ParentESPCheck == nil then
	_G.ParentESPCheck = function(parent)
		local name = nil
		local partName = nil
		local parentName = dx9.GetName(parent)

		if parentName == "Briefcase" then
			if _G.ParentESPCheck ~= nil then
				for _, child in pairs(dx9.GetChildren(parent)) do
					local childName = dx9.GetName(child)
					if childName ~= "Briefcase" then
						_G.ParentESPCheck(child)
					end
				end
			end
		end

		local skipThis = true
		local isType = 0
		if skipThis == true then
			for _, tab in pairs(config.items.entries) do
				local Name = tab.name
				local PartName = tab.part
				local ParentName = tab.parent

				if parentName == ParentName or parentName == PartName then
					name = Name
					partName = PartName
					if items.enabled.Value and items_config[Name.."_enabled"].Value then
						isType = 1
						skipThis = false
					end
					break
				end
			end
		end
		if skipThis == true then
			for _, tab in pairs(config.ammo.entries) do
				local Name = tab.name
				local PartName = tab.part
				local ParentName = tab.parent

				if parentName == ParentName or parentName == PartName then
					name = Name
					partName = PartName
					if ammo.enabled.Value and ammo_config[Name.."_enabled"].Value then
						isType = 2
						skipThis = false
					end
					break
				end
			end
		end
		if skipThis == true then
			for _, tab in pairs(config.weapons.entries) do
				local Name = tab.name
				local PartName = tab.part
				local ParentName = tab.parent

				if parentName == ParentName or parentName == PartName then
					name = Name
					partName = PartName
					if weapons.enabled.Value and weapons_config[Name.."_enabled"].Value then
						isType = 3
						skipThis = false
					end
					break
				end
			end
		end

		local typeTab = nil
		local typeConfigSettings = nil
		local typeConfig = nil
		if isType == 1 then
			typeTab = items
			typeConfigSettings = config.items
			typeConfig = items_config
		elseif isType == 2 then
			typeTab = ammo
			typeConfigSettings = config.ammo
			typeConfig = ammo_config
		elseif isType == 3 then
			typeTab = weapons
			typeConfigSettings = config.weapons
			typeConfig = weapons_config
		end

		if not skipThis and typeTab and typeConfigSettings and typeConfig then
			local part = partName and dx9.FindFirstChild(parent, partName) or nil
			if part and part ~= 0 then
				local pivot = dx9.FindFirstChild(part, "Pivot")
				local offset = {
					x = 0,
					y = 0,
					z = 0,
				}
				if pivot and pivot ~= 0 then
					local pivot_pos = dx9.GetPosition(pivot)
					offset.x = pivot_pos.x
					offset.y = pivot_pos.y
					offset.z = pivot_pos.z
				end
				local my_root_pos = dx9.GetPosition(my_root)
				local root_pos = dx9.GetPosition(part)
				local final_pos = {
					x = root_pos.x + offset.x,
					y = root_pos.y + offset.y,
					z = root_pos.z + offset.z,
				}
				local root_distance = _G.Get_Distance(my_root_pos, final_pos)
				if root_distance < typeTab.distance_limit.Value then
					local root_screen_pos = dx9.WorldToScreen({final_pos.x, final_pos.y, final_pos.z})
					if _G.IsOnScreen(root_screen_pos) then
						lib_esp.draw({
							esp_type = "misc",
							target = part,
							color = typeTab.color.Value,
							healthbar = false,
							nametag = typeTab.nametag.Value,
							custom_nametag = name,
							distance = typeTab.distance.Value,
							custom_distance = ""..root_distance,
							tracer = typeTab.tracer.Value,
							tracer_type = current_tracer_type,
							box_type = current_box_type,
						})
					end
				end
			end
		end
	end
end

if _G.WorkspaceESPTask == nil then
	_G.WorkspaceESPTask = function()
		if items.enabled.Value or ammo.enabled.Value or weapons.enabled.Value then
			for _, parent in pairs(dx9.GetChildren(workspace)) do
				_G.ParentESPCheck(parent)
			end
		end
	end
end
if _G.WorkspaceESPTask then
	_G.WorkspaceESPTask()
end

