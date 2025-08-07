--indent size 4

trinketconfig = _G.trinketconfig or {
	{
		name = "Ring";
		Enabled = true;
	};
	{
		name = "Amulet";
		Enabled = true;
	};
	{
		name = "Mushroom";
		Enabled = true;
	};
	{
		name = "Goblet";
		Enabled = true;
	};
}
if _G.trinketconfig == nil then
	_G.trinketconfig = trinketconfig
	trinketconfig = _G.trinketconfig
end

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/B0NBunny/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/B0NBunny/DXLibESP/refs/heads/main/main.lua";
	};
    settings = {
		menu_toggle_keybind = "[F2]";
		
		esp_enabled = true;
    	box_type = 1; -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    };
	players = {
        enabled = true;
        distance = true;
        healthbar = false;
		healthtag = false;
		maxhealthtag = false;
        nametag = true;
        tracer = false;
		color = { 0, 255, 0 };
		distance_limit = 10000;
	};
	enemies = {
        enabled = true;
        distance = true;
        healthbar = false;
		healthtag = false;
		maxhealthtag = false;
        nametag = true;
        tracer = false;
		color = { 255, 0, 0 };
		distance_limit = 10000;
	};
	npcs = {
        enabled = true;
        distance = true;
        healthbar = false;
        nametag = true;
        tracer = false;
		color = { 0, 0, 255 };
		distance_limit = 10000;
	};
	drops = {
        enabled = true;
        distance = true;
        healthbar = false;
        nametag = true;
        tracer = false;
		color = { 255, 255, 255 };
		distance_limit = 10000;
	};
	chests = {
        enabled = true;
        distance = true;
        healthbar = false;
        nametag = true;
        tracer = false;
		color = { 255, 255, 0 };
		distance_limit = 10000;
	};
    trinkets = {
        enabled = true;
        distance = true;
        healthbar = false;
        nametag = true;
        tracer = false;
		color = { 255, 255, 255 };
		distance_limit = 10000;
		entries = trinketconfig;
	};
};
if _G.config == nil then
	_G.config = config
	config = _G.config
end

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

lib_esp = loadstring(dx9.Get(config.urls.LibESP))()

interface = lib_ui:CreateWindow({
	Title = "Rogueblox | dx9ware | By @Brycki";
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
	enemies = interface:AddTab("Enemies");
	npcs = interface:AddTab("NPCs");
	chests = interface:AddTab("Chests");
	drops = interface:AddTab("Drops");
	trinkets = interface:AddTab("Trinkets");
}

groupboxes = {
	esp_settings = tabs.settings:AddMiddleGroupbox("ESP");

	players = tabs.players:AddLeftGroupbox("Player ESP");

	enemies = tabs.enemies:AddLeftGroupbox("Enemy ESP");

	npcs = tabs.npcs:AddLeftGroupbox("NPC ESP");

	chests = tabs.chests:AddLeftGroupbox("Chest ESP");

	drops = tabs.drops:AddLeftGroupbox("Drops ESP");

	trinkets = tabs.trinkets:AddLeftGroupbox("Trinket ESP");
	trinkets_config = tabs.trinkets:AddRightGroupbox("Trinket Config");
}

esp_settings = {
	enabled = groupboxes.esp_settings
		:AddToggle({
			Default = config.settings.esp_enabled;
			Text = "ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Settings] Enabled Global ESP" or "[Settings] Disabled Global ESP", 1)
		end);

	box_type = groupboxes.esp_settings
		:AddDropdown({
			Text = "Box Type";
			Default = config.settings.box_type;
			Values = { "Corners", "2D Box", "3D Box" };
		})
		:OnChanged(function(value)
			lib_ui:Notify("[Settings] Box Type: " .. value, 1)
		end);

	tracer_type = groupboxes.esp_settings
		:AddDropdown({
			Text = "Tracer Type";
			Default = config.settings.tracer_type;
			Values = { "Near-Bottom", "Bottom", "Top", "Mouse" };
		})
		:OnChanged(function(value)
			lib_ui:Notify("[Settings] Tracer Type: " .. value, 1)
		end);
}

players = {
	enabled = groupboxes.players
		:AddToggle({
			Default = config.players.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled ESP" or "[Players] Disabled ESP", 1)
		end);

	distance = groupboxes.players
		:AddToggle({
			Default = config.players.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled Distance" or "[Players] Disabled Distance", 1)
		end);

	healthbar = groupboxes.players:AddToggle({
			Default = config.players.healthbar;
			Text = "HealthBar";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled HealthBar" or "[Players] Disabled HealthBar", 1)
		end);

	healthtag = groupboxes.players:AddToggle({
			Default = config.players.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled HealthTag" or "[Players] Disabled HealthTag", 1)
		end);

	maxhealthtag = groupboxes.players:AddToggle({
			Default = config.players.maxhealthtag;
			Text = "MaxHealthTag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled MaxHealthTag" or "[Players] Disabled MaxHealthTag", 1)
		end);

	nametag = groupboxes.players
		:AddToggle({
			Default = config.players.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled Nametag" or "[Players] Disabled Nametag", 1)
		end);

	tracer = groupboxes.players
		:AddToggle({
			Default = config.players.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Players] Enabled Tracer" or "[Players] Disabled Tracer", 1)
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

enemies = {
	enabled = groupboxes.enemies
		:AddToggle({
			Default = config.enemies.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Enemies] Enabled ESP" or "[Enemies] Disabled ESP", 1)
		end);

	distance = groupboxes.enemies
		:AddToggle({
			Default = config.enemies.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Enemies] Enabled Distance" or "[Enemies] Disabled Distance", 1)
		end);

	healthbar = groupboxes.enemies:AddToggle({
			Default = config.enemies.healthbar;
			Text = "HealthBar";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Enemies] Enabled HealthBar" or "[Enemies] Disabled HealthBar", 1)
		end);

	healthtag = groupboxes.enemies:AddToggle({
			Default = config.enemies.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Enemies] Enabled HealthTag" or "[Enemies] Disabled HealthTag", 1)
		end);

	maxhealthtag = groupboxes.enemies:AddToggle({
			Default = config.enemies.maxhealthtag;
			Text = "MaxHealthTag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Enemies] Enabled MaxHealthTag" or "[Enemies] Disabled MaxHealthTag", 1)
		end);

	nametag = groupboxes.enemies
		:AddToggle({
			Default = config.enemies.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Enemies] Enabled Nametag" or "[Enemies] Disabled Nametag", 1)
		end);

	tracer = groupboxes.enemies
		:AddToggle({
			Default = config.enemies.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Enemies] Enabled Tracer" or "[Enemies] Disabled Tracer", 1)
		end);

    color = groupboxes.enemies:AddColorPicker({
		Default = config.enemies.color;
		Text = "Color";
	});

	distance_limit = groupboxes.enemies:AddSlider({
		Default = config.enemies.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

npcs = {
	enabled = groupboxes.npcs
		:AddToggle({
			Default = config.npcs.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[npcs] Enabled ESP" or "[npcs] Disabled ESP", 1)
		end);

	distance = groupboxes.npcs
		:AddToggle({
			Default = config.npcs.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[npcs] Enabled Distance" or "[npcs] Disabled Distance", 1)
		end);

	nametag = groupboxes.npcs
		:AddToggle({
			Default = config.npcs.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[npcs] Enabled Nametag" or "[npcs] Disabled Nametag", 1)
		end);

	tracer = groupboxes.npcs
		:AddToggle({
			Default = config.npcs.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[npcs] Enabled Tracer" or "[npcs] Disabled Tracer", 1)
		end);

    color = groupboxes.npcs:AddColorPicker({
		Default = config.npcs.color;
		Text = "Color";
	});

	distance_limit = groupboxes.npcs:AddSlider({
		Default = config.npcs.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

chests = {
	enabled = groupboxes.chests
		:AddToggle({
			Default = config.chests.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[chests] Enabled ESP" or "[chests] Disabled ESP", 1)
		end);

	distance = groupboxes.chests
		:AddToggle({
			Default = config.chests.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[chests] Enabled Distance" or "[chests] Disabled Distance", 1)
		end);

	nametag = groupboxes.chests
		:AddToggle({
			Default = config.chests.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[chests] Enabled Nametag" or "[chests] Disabled Nametag", 1)
		end);

	tracer = groupboxes.chests
		:AddToggle({
			Default = config.chests.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[chests] Enabled Tracer" or "[chests] Disabled Tracer", 1)
		end);

    color = groupboxes.chests:AddColorPicker({
		Default = config.chests.color;
		Text = "Color";
	});

	distance_limit = groupboxes.chests:AddSlider({
		Default = config.chests.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

drops = {
	enabled = groupboxes.drops
		:AddToggle({
			Default = config.drops.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[drops] Enabled ESP" or "[drops] Disabled ESP", 1)
		end);

	distance = groupboxes.drops
		:AddToggle({
			Default = config.drops.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[drops] Enabled Distance" or "[drops] Disabled Distance", 1)
		end);

	nametag = groupboxes.drops
		:AddToggle({
			Default = config.drops.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[drops] Enabled Nametag" or "[drops] Disabled Nametag", 1)
		end);

	tracer = groupboxes.drops
		:AddToggle({
			Default = config.drops.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[drops] Enabled Tracer" or "[drops] Disabled Tracer", 1)
		end);

    color = groupboxes.drops:AddColorPicker({
		Default = config.drops.color;
		Text = "Color";
	});

	distance_limit = groupboxes.drops:AddSlider({
		Default = config.drops.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

trinkets = {
	enabled = groupboxes.trinkets
		:AddToggle({
			Default = config.trinkets.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled ESP" or "[trinkets] Disabled ESP", 1)
		end);

	distance = groupboxes.trinkets
		:AddToggle({
			Default = config.trinkets.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled Distance" or "[trinkets] Disabled Distance", 1)
		end);

	nametag = groupboxes.trinkets
		:AddToggle({
			Default = config.trinkets.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled Nametag" or "[trinkets] Disabled Nametag", 1)
		end);

	tracer = groupboxes.trinkets
		:AddToggle({
			Default = config.trinkets.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled Tracer" or "[trinkets] Disabled Tracer", 1)
		end);

    color = groupboxes.trinkets:AddColorPicker({
		Default = config.trinkets.color;
		Text = "Color";
	});

	distance_limit = groupboxes.trinkets:AddSlider({
		Default = config.trinkets.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

trinkets_config = {}
for _, tab in pairs(config.trinkets.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	trinkets_config[name.."_enabled"] = groupboxes.trinkets_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled "..name.." ESP" or "[trinkets] Disabled "..name.." ESP", 1)
		end)
end

if _G.SplitString == nil then
	_G.SplitString = function(inputstr, sep)
		if sep == nil then
			sep = "%s"
		end
		local t = {}
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
		end
		return t
	end
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

datamodel = dx9.GetDatamodel()
workspace = dx9.FindFirstChild(datamodel, "Workspace")
services = {
	players = dx9.FindFirstChild(datamodel, "Players");
}

local_player = nil

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

local Living_Folder = dx9.FindFirstChild(workspace, "Living")
if Living_Folder == nil or Living_Folder == 0 then
    return
end

if my_player == nil or my_player == 0 then
	return
elseif my_player ~= nil and my_player ~= 0 then
    my_character = dx9.FindFirstChild(Living_Folder, local_player_name)
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

if not esp_settings.enabled.Value then
	return
end

if _G.LivingTask == nil then
	_G.LivingTask = function()
        if players.enabled.Value or enemies.enabled.Value then
			local Living_Folder = dx9.FindFirstChild(workspace, "Living")
			if Living_Folder ~= nil and Living_Folder ~= 0 then
				local Living_Folder_Children = dx9.GetChildren(Living_Folder)
				if #Living_Folder_Children > 0 then
					for _, entity in pairs(Living_Folder_Children) do
						local entityName = dx9.GetName(entity)
						local entityTab = enemies
						local entityConfig = config.enemies
						local playerObject = dx9.FindFirstChild(services.players, entityName)
						if playerObject ~= nil and playerObject ~= 0 then
							entityTab = players
							entityConfig = config.players
						else
							local splits = _G.SplitString(entityName, "|")
							local subName = string.sub(splits[1], 2)
							entityName = subName
						end
						local humanoid = dx9.FindFirstChild(entity, "Humanoid")
						local health = nil
						local maxhealth = nil
						if humanoid ~= nil and humanoid ~= 0 then
							health = dx9.GetHealth(humanoid) or nil
							maxhealth = dx9.GetMaxHealth(humanoid) or nil
						end
						if health ~= nil then
							health = math.floor(health)
						end
						if maxhealth ~= nil then
							maxhealth = math.floor(maxhealth)
						end
						local root = dx9.FindFirstChild(entity, "HumanoidRootPart")
						if root ~= nil and root ~= 0 then
							local my_root_pos = dx9.GetPosition(my_root)
							local root_pos = dx9.GetPosition(root)
							local root_distance = _G.Get_Distance(my_root_pos, root_pos)
							if root_distance < entityTab.distance_limit.Value then
								local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
								if _G.IsOnScreen(root_screen_pos) then
									local customName = entityName
									if entityTab.healthtag.Value and entityTab.maxhealthtag.Value and health ~= nil and maxhealth ~= nil then
										customName = entityName .. " | " .. tostring(health) .. "/" .. tostring(maxhealth) .. " hp"
									elseif entityTab.healthtag.Value and health ~= nil then
										customName = entityName .. " | " .. tostring(health) .. " hp"
									end	
									lib_esp.draw({
										target = entity;
										color = entityTab.color.Value;
										healthbar = entityTab.healthbar.Value;
										nametag = entityTab.nametag.Value;
										custom_nametag = customName;
										distance = entityTab.distance.Value;
										custom_distance = ""..root_distance;
										tracer = entityTab.tracer.Value;
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
if _G.LivingTask then
	_G.LivingTask()
end

if _G.DebrisTask == nil then
	_G.DebrisTask = function()
		local Debris_Folder = dx9.FindFirstChild(workspace, "Debris")
		if Debris_Folder and Debris_Folder ~= 0 then
			if trinkets.enabled.Value then
				local SpawnedItems_Folder = dx9.FindFirstChild(Debris_Folder, "SpawnedItems") --all children are BaseParts
				if SpawnedItems_Folder ~= nil and SpawnedItems_Folder ~= 0 then
					local SpawnedItems_Folder_Children = dx9.GetChildren(SpawnedItems_Folder)
					if #SpawnedItems_Folder_Children > 0 then
						for _, basePart in pairs(SpawnedItems_Folder_Children) do
							local name = dx9.GetName(basePart)

							local skipThis = true
							local isType = 0
							if skipThis == true then
								for _, tab in pairs(config.trinkets.entries) do
									local Name = tab.name

									if name == Name then
										isType = 1
										if trinkets_config[Name.."_enabled"].Value then
											skipThis = false
										end
										break
									end
								end
							end

							if skipThis == true and isType == 0 then
								skipThis = false
							end

							local typeTab = nil
							local typeConfigSettings = nil
							local typeConfig = nil
							if isType == 0 or isType == 1 then
								typeTab = trinkets
								typeConfigSettings = config.trinkets
								typeConfig = trinkets_config
							end

							if not skipThis and typeTab and typeConfigSettings and typeConfig then
								local my_root_pos = dx9.GetPosition(my_root)
								local root_pos = dx9.GetPosition(basePart)
								local root_distance = _G.Get_Distance(my_root_pos, root_pos)
								if root_distance < typeTab.distance_limit.Value then
									local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
									if _G.IsOnScreen(root_screen_pos) then
										lib_esp.draw({
											esp_type = "misc";
											target = basePart;
											color = typeTab.color.Value;
											healthbar = typeConfigSettings.healthbar;
											nametag = typeTab.nametag.Value;
											custom_nametag = name;
											distance = typeTab.distance.Value;
											custom_distance = ""..root_distance;
											tracer = typeTab.tracer.Value;
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

			if drops.enabled.Value then
				local DroppedItems_Folder = dx9.FindFirstChild(Debris_Folder, "DroppedItems")
				if DroppedItems_Folder ~= nil and DroppedItems_Folder ~= 0 then
					local DroppedItems_Folder_Children = dx9.GetChildren(DroppedItems_Folder)
					if #DroppedItems_Folder_Children > 0 then
						for _, basePart in pairs(DroppedItems_Folder) do
							local name = dx9.GetName(basePart)
							local my_root_pos = dx9.GetPosition(my_root)
							local root_pos = dx9.GetPosition(basePart)
							local root_distance = _G.Get_Distance(my_root_pos, root_pos)
							if root_distance < drops.distance_limit.Value then
								local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
								if _G.IsOnScreen(root_screen_pos) then
									lib_esp.draw({
										esp_type = "misc";
										target = basePart;
										color = drops.color.Value;
										healthbar = config.drops.healthbar;
										nametag = drops.nametag.Value;
										custom_nametag = name;
										distance = drops.distance.Value;
										custom_distance = ""..root_distance;
										tracer = drops.tracer.Value;
										tracer_type = current_tracer_type;
										box_type = current_box_type;
									})
								end
							end
						end
					end
				end
			end

			if chests.enabled.Value then
				local Debris_Folder_Children = dx9.GetChildren(Debris_Folder)
				if #Debris_Folder_Children > 0 then
					for _, chest in pairs(Debris_Folder_Children) do
						local className = dx9.GetType(chest)
						if className == "Model" then
							local name = dx9.GetName(chest)
							local splits = _G.SplitString(name, "|")
							local subName = string.sub(splits[1], 2)
							print(subName)
							if subName == "chest" then
								local basePart = dx9.FindFirstChild("Bottom")
								if basePart == nil or basePart == 0 then
									basePart = dx9.FindFirstChild("Top")
								end
								if basePart ~= nil and basePart ~= 0 then
									local my_root_pos = dx9.GetPosition(my_root)
									local root_pos = dx9.GetPosition(basePart)
									local root_distance = _G.Get_Distance(my_root_pos, root_pos)
									if root_distance < drops.distance_limit.Value then
										local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
										if _G.IsOnScreen(root_screen_pos) then
											lib_esp.draw({
												esp_type = "misc";
												target = basePart;
												color = drops.color.Value;
												healthbar = config.drops.healthbar;
												nametag = drops.nametag.Value;
												custom_nametag = subName;
												distance = drops.distance.Value;
												custom_distance = ""..root_distance;
												tracer = drops.tracer.Value;
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
end
if _G.DebrisTask then
	_G.DebrisTask()
end