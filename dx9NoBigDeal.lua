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
if _G.Config == nil then
	_G.Config = Config
	Config = _G.Config
end

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "No Big Deal | dx9ware | By @Brycki";
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
	items = Interface:AddTab("Items");
	ammo = Interface:AddTab("Ammo");
	weapons = Interface:AddTab("Weapons");
}

Groupboxes = {
	esp_settings = Tabs.settings:AddLeftGroupbox("ESP");
	aimbot_settings = Tabs.settings:AddRightGroupbox("Aimbot");
	players = Tabs.players:AddMiddleGroupbox("Player ESP");
	items = Tabs.items:AddLeftGroupbox("Item ESP");
	items_config = Tabs.items:AddRightGroupbox("Item Config");
	ammo = Tabs.ammo:AddLeftGroupbox("Ammo ESP");
	ammo_config = Tabs.ammo:AddRightGroupbox("Ammo Config");
	weapons = Tabs.weapons:AddLeftGroupbox("Weapon ESP");
	weapons_config = Tabs.weapons:AddRightGroupbox("Weapon Config");
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

Items = {
	enabled = Groupboxes.items
		:AddToggle({
			Default = Config.items.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[items] Enabled ESP" or "[items] Disabled ESP", 1)
		end);

	distance = Groupboxes.items
		:AddToggle({
			Default = Config.items.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[items] Enabled Distance" or "[items] Disabled Distance", 1)
		end);

	nametag = Groupboxes.items
		:AddToggle({
			Default = Config.items.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[items] Enabled Nametag" or "[items] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.items
		:AddToggle({
			Default = Config.items.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[items] Enabled Tracer" or "[items] Disabled Tracer", 1)
		end);

    color = Groupboxes.items:AddColorPicker({
		Default = Config.items.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.items:AddSlider({
		Default = Config.items.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

Items_config = {}
for _, tab in pairs(Config.items.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	Items_config[name.."_enabled"] = Groupboxes.items_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[items] Enabled "..name.." ESP" or "[items] Disabled "..name.." ESP", 1)
		end)
end

Ammo = {
	enabled = Groupboxes.ammo
		:AddToggle({
			Default = Config.ammo.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ammo] Enabled ESP" or "[ammo] Disabled ESP", 1)
		end);

	distance = Groupboxes.ammo
		:AddToggle({
			Default = Config.ammo.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ammo] Enabled Distance" or "[ammo] Disabled Distance", 1)
		end);

	nametag = Groupboxes.ammo
		:AddToggle({
			Default = Config.ammo.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ammo] Enabled Nametag" or "[ammo] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.ammo
		:AddToggle({
			Default = Config.ammo.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ammo] Enabled Tracer" or "[ammo] Disabled Tracer", 1)
		end);

    color = Groupboxes.ammo:AddColorPicker({
		Default = Config.ammo.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.ammo:AddSlider({
		Default = Config.ammo.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

Ammo_config = {}
for _, tab in pairs(Config.ammo.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	Ammo_config[name.."_enabled"] = Groupboxes.ammo_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ammo] Enabled "..name.." ESP" or "[ammo] Disabled "..name.." ESP", 1)
		end)
end

Weapons = {
	enabled = Groupboxes.weapons
		:AddToggle({
			Default = Config.weapons.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[weapons] Enabled ESP" or "[weapons] Disabled ESP", 1)
		end);

	distance = Groupboxes.weapons
		:AddToggle({
			Default = Config.weapons.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[weapons] Enabled Distance" or "[weapons] Disabled Distance", 1)
		end);

	nametag = Groupboxes.weapons
		:AddToggle({
			Default = Config.weapons.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[weapons] Enabled Nametag" or "[weapons] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.weapons
		:AddToggle({
			Default = Config.weapons.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[weapons] Enabled Tracer" or "[weapons] Disabled Tracer", 1)
		end);

    color = Groupboxes.weapons:AddColorPicker({
		Default = Config.weapons.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.weapons:AddSlider({
		Default = Config.weapons.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

Weapons_config = {}
for _, tab in pairs(Config.weapons.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	Weapons_config[name.."_enabled"] = Groupboxes.weapons_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ammo] Enabled "..name.." ESP" or "[ammo] Disabled "..name.." ESP", 1)
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

if _G.PlayerTask == nil then
	_G.PlayerTask = function()
		if Players.enabled.Value or Aimbot_settings.enabled.Value then
			local closest_player_name = nil
			local closest_player_value = nil
			local closest_player_screen_pos = nil
			for _, player in pairs(dx9.GetChildren(Services.players)) do
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

							local screen_pos = nil
							if Current_aimbot_part == 1 then
								screen_pos = head_screen_pos
							elseif Current_aimbot_part == 2 then
								screen_pos = root_screen_pos
							end

							if _G.IsOnScreen(screen_pos) then
								if Aimbot_settings.enabled.Value then
									if playerName == Aimbot_target_name then
										Aimbot_target_screen_pos = screen_pos
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
								
								if Esp_settings.enabled.Value and Players.enabled.Value then
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

			if not _G.lastAimbotFrame or _G.lastAimbotFrame and (os.clock() - _G.lastAimbotFrame) > (1/30) then
				if Aimbot_settings.enabled.Value then
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
								Aimbot_target_screen_pos.x + Screen_size.width/2,
								Aimbot_target_screen_pos.y + Screen_size.height/2
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

if not Esp_settings.enabled.Value then
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
			for _, tab in pairs(Config.items.entries) do
				local Name = tab.name
				local PartName = tab.part
				local ParentName = tab.parent

				if parentName == ParentName or parentName == PartName then
					name = Name
					partName = PartName
					if Items.enabled.Value and Items_config[Name.."_enabled"].Value then
						isType = 1
						skipThis = false
					end
					break
				end
			end
		end
		if skipThis == true then
			for _, tab in pairs(Config.ammo.entries) do
				local Name = tab.name
				local PartName = tab.part
				local ParentName = tab.parent

				if parentName == ParentName or parentName == PartName then
					name = Name
					partName = PartName
					if Ammo.enabled.Value and Ammo_config[Name.."_enabled"].Value then
						isType = 2
						skipThis = false
					end
					break
				end
			end
		end
		if skipThis == true then
			for _, tab in pairs(Config.weapons.entries) do
				local Name = tab.name
				local PartName = tab.part
				local ParentName = tab.parent

				if parentName == ParentName or parentName == PartName then
					name = Name
					partName = PartName
					if Weapons.enabled.Value and Weapons_config[Name.."_enabled"].Value then
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
			typeTab = Items
			typeConfigSettings = Config.items
			typeConfig = Items_config
		elseif isType == 2 then
			typeTab = Ammo
			typeConfigSettings = Config.ammo
			typeConfig = Ammo_config
		elseif isType == 3 then
			typeTab = Weapons
			typeConfigSettings = Config.weapons
			typeConfig = Weapons_config
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
				local my_root_pos = dx9.GetPosition(My_root)
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
						Lib_esp.draw({
							esp_type = "misc",
							target = part,
							color = typeTab.color.Value,
							healthbar = false,
							nametag = typeTab.nametag.Value,
							custom_nametag = name,
							distance = typeTab.distance.Value,
							custom_distance = ""..root_distance,
							tracer = typeTab.tracer.Value,
							tracer_type = Current_tracer_type,
							box_type = Current_box_type,
						})
					end
				end
			end
		end
	end
end

if _G.WorkspaceESPTask == nil then
	_G.WorkspaceESPTask = function()
		if Items.enabled.Value or Ammo.enabled.Value or Weapons.enabled.Value then
			for _, parent in pairs(dx9.GetChildren(Workspace)) do
				_G.ParentESPCheck(parent)
			end
		end
	end
end
if _G.WorkspaceESPTask then
	_G.WorkspaceESPTask()
end

