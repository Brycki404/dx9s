--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines

Oreconfig = _G.Oreconfig or {
	{
		name = "Mythril";
		Enabled = true;
	};
	{
		name = "Tin";
		Enabled = true;
	};
	{
		name = "Iron";
		Enabled = true;
	};
	{
		name = "Copper";
		Enabled = true;
	};
}
if _G.Oreconfig == nil then
	_G.Oreconfig = Oreconfig
	Oreconfig = _G.Oreconfig
end

Config = _G.Config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
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
        healthbar = true;
		healthtag = true;
		maxhealthtag = true;
        nametag = true;
        tracer = false;
		color = { 255, 0, 0 };
		distance_limit = 10000;
	};
	ores = {
        enabled = false;
        distance = true;
        healthbar = false;
        nametag = true;
        tracer = false;
		color = { 255, 255, 255 };
		distance_limit = 10000;
		entries = Oreconfig;
	};
	npcs = {
        enabled = false;
        distance = true;
        healthbar = false;
        nametag = true;
        tracer = false;
		color = { 79, 176, 255 };
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
	};
};
if _G.Config == nil then
	_G.Config = Config
	Config = _G.Config
end

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "Rogue Lineage | dx9ware | By @Brycki";
	Size = { 500, 500 };
	Resizable = true;

	ToggleKey = Config.settings.menu_toggle_keybind;

	FooterToggle = true;
	FooterRGB = true;
	FontColor = { 255, 255, 255 };
	MainColor = { 32, 26, 68 };
	BackgroundColor = { 26, 21, 55 };
	AccentColor = { 81, 37, 112 };
	OutlineColor = { 54, 47, 90 };
})

Tabs = {
	settings = Interface:AddTab("Settings");
	players = Interface:AddTab("Players");
	enemies = Interface:AddTab("Enemies");
	ores = Interface:AddTab("Ores");
	npcs = Interface:AddTab("NPCs");
	trinkets = Interface:AddTab("Trinkets");
}

Groupboxes = {
	esp_settings = Tabs.settings:AddMiddleGroupbox("ESP");

	players = Tabs.players:AddLeftGroupbox("Player ESP");

	enemies = Tabs.enemies:AddLeftGroupbox("Enemy ESP");

	ores = Tabs.ores:AddLeftGroupbox("Ore ESP");
	ores_config = Tabs.ores:AddRightGroupbox("Ore Config");

	npcs = Tabs.npcs:AddLeftGroupbox("NPC ESP");

	trinkets = Tabs.trinkets:AddMiddleGroupbox("Trinket ESP");
}

Esp_settings = {
	enabled = Groupboxes.esp_settings
		:AddToggle({
			Default = Config.settings.esp_enabled;
			Text = "ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Settings] Enabled Global ESP" or "[Settings] Disabled Global ESP", 1)
		end);

	box_type = Groupboxes.esp_settings
		:AddDropdown({
			Text = "Box Type";
			Default = Config.settings.box_type;
			Values = { "Corners", "2D Box", "3D Box" };
		})
		:OnChanged(function(value)
			Lib_ui:Notify("[Settings] Box Type: " .. value, 1)
		end);

	tracer_type = Groupboxes.esp_settings
		:AddDropdown({
			Text = "Tracer Type";
			Default = Config.settings.tracer_type;
			Values = { "Near-Bottom", "Bottom", "Top", "Mouse" };
		})
		:OnChanged(function(value)
			Lib_ui:Notify("[Settings] Tracer Type: " .. value, 1)
		end);
}

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

	healthbar = Groupboxes.enemies:AddToggle({
			Default = Config.enemies.healthbar;
			Text = "HealthBar";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Enemies] Enabled HealthBar" or "[Enemies] Disabled HealthBar", 1)
		end);

	healthtag = Groupboxes.enemies:AddToggle({
			Default = Config.enemies.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Enemies] Enabled HealthTag" or "[Enemies] Disabled HealthTag", 1)
		end);

	maxhealthtag = Groupboxes.enemies:AddToggle({
			Default = Config.enemies.maxhealthtag;
			Text = "MaxHealthTag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[Enemies] Enabled MaxHealthTag" or "[Enemies] Disabled MaxHealthTag", 1)
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

Ores = {
	enabled = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ores] Enabled ESP" or "[ores] Disabled ESP", 1)
		end);

	distance = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ores] Enabled Distance" or "[ores] Disabled Distance", 1)
		end);

	nametag = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ores] Enabled Nametag" or "[ores] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.ores
		:AddToggle({
			Default = Config.ores.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ores] Enabled Tracer" or "[ores] Disabled Tracer", 1)
		end);

    color = Groupboxes.ores:AddColorPicker({
		Default = Config.ores.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.ores:AddSlider({
		Default = Config.ores.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

Ores_config = {}
for _, tab in pairs(Config.ores.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	Ores_config[name.."_enabled"] = Groupboxes.ores_config
		:AddToggle({
			Default = Enabled;
			Text = name.." ESP Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[ores] Enabled "..name.." ESP" or "[ores] Disabled "..name.." ESP", 1)
		end)
end

Npcs = {
	enabled = Groupboxes.npcs
		:AddToggle({
			Default = Config.npcs.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[npcs] Enabled ESP" or "[npcs] Disabled ESP", 1)
		end);

	distance = Groupboxes.npcs
		:AddToggle({
			Default = Config.npcs.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[npcs] Enabled Distance" or "[npcs] Disabled Distance", 1)
		end);

	nametag = Groupboxes.npcs
		:AddToggle({
			Default = Config.npcs.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[npcs] Enabled Nametag" or "[npcs] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.npcs
		:AddToggle({
			Default = Config.npcs.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[npcs] Enabled Tracer" or "[npcs] Disabled Tracer", 1)
		end);

    color = Groupboxes.npcs:AddColorPicker({
		Default = Config.npcs.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.npcs:AddSlider({
		Default = Config.npcs.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

Trinkets = {
	enabled = Groupboxes.trinkets
		:AddToggle({
			Default = Config.trinkets.enabled;
			Text = "Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[trinkets] Enabled ESP" or "[trinkets] Disabled ESP", 1)
		end);

	distance = Groupboxes.trinkets
		:AddToggle({
			Default = Config.trinkets.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[trinkets] Enabled Distance" or "[trinkets] Disabled Distance", 1)
		end);

	nametag = Groupboxes.trinkets
		:AddToggle({
			Default = Config.trinkets.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[trinkets] Enabled Nametag" or "[trinkets] Disabled Nametag", 1)
		end);

	tracer = Groupboxes.trinkets
		:AddToggle({
			Default = Config.trinkets.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[trinkets] Enabled Tracer" or "[trinkets] Disabled Tracer", 1)
		end);

    color = Groupboxes.trinkets:AddColorPicker({
		Default = Config.trinkets.color;
		Text = "Color";
	});

	distance_limit = Groupboxes.trinkets:AddSlider({
		Default = Config.trinkets.distance_limit;
		Text = "ESP Distance Limit";
		Min = 0;
		Max = 10000;
		Rounding = 0;
	});
}

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

Datamodel = dx9.GetDatamodel()
Workspace = dx9.FindFirstChild(Datamodel, "Workspace")
Services = {
	players = dx9.FindFirstChild(Datamodel, "Players");
}

Local_player = nil

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

local Live_Folder = dx9.FindFirstChild(Workspace, "Live")
if Live_Folder == nil or Live_Folder == 0 then
    return
end

if My_player == nil or My_player == 0 then
	return
elseif My_player ~= nil and My_player ~= 0 then
    My_character = dx9.FindFirstChild(Live_Folder, Local_player_name)
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

if not Esp_settings.enabled.Value then
	return
end

if _G.LiveTask == nil then
	_G.LiveTask = function()
        if Players.enabled.Value or Enemies.enabled.Value then
			local Live_Folder_Children = dx9.GetChildren(Live_Folder)
			if #Live_Folder_Children > 0 then
				for _, entity in pairs(Live_Folder_Children) do
					local entityName = dx9.GetName(entity)
					local entityTab = Enemies
					local entityConfig = Config.enemies
					local playerObject = dx9.FindFirstChild(Services.players, entityName)
					if playerObject ~= nil and playerObject ~= 0 then
						entityTab = Players
						entityConfig = Config.players
					else
						local splits = _G.SplitString(entityName, "|")
						local subName = string.sub(splits[1], 2)
						entityName = subName
					end
					if entityTab == Players and Players.enabled.Value or entityTab == Enemies and Enemies.enabled.Value then
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
							local my_root_pos = dx9.GetPosition(My_root)
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
									Lib_esp.draw({
										target = entity;
										color = entityTab.color.Value;
										healthbar = entityTab.healthbar.Value;
										nametag = entityTab.nametag.Value;
										custom_nametag = customName;
										distance = entityTab.distance.Value;
										custom_distance = ""..root_distance;
										tracer = entityTab.tracer.Value;
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
if _G.LiveTask then
	_G.LiveTask()
end

if _G.NPCTask == nil then
	_G.NPCTask = function()
        if Npcs.enabled.Value then
			local NPCs_Folder = dx9.FindFirstChild(Workspace, "NPCs")
			if NPCs_Folder ~= nil and NPCs_Folder ~= 0 then
				local NPCs_Folder_Children = dx9.GetChildren(NPCs_Folder)
				if #NPCs_Folder_Children > 0 then
					for _, npc in pairs(NPCs_Folder_Children) do
						local npcName = dx9.GetName(npc)
						local root = dx9.FindFirstChild(npc, "HumanoidRootPart")
						if root ~= nil and root ~= 0 then
							local my_root_pos = dx9.GetPosition(My_root)
							local root_pos = dx9.GetPosition(root)
							local root_distance = _G.Get_Distance(my_root_pos, root_pos)
							if root_distance < Npcs.distance_limit.Value then
								local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
								if _G.IsOnScreen(root_screen_pos) then
									Lib_esp.draw({
										esp_type = "misc";
										target = root;
										color = Npcs.color.Value;
										healthbar = Config.Npcs.healthbar;
										nametag = Npcs.nametag.Value;
										custom_nametag = npcName;
										distance = Npcs.distance.Value;
										custom_distance = ""..root_distance;
										tracer = Npcs.tracer.Value;
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
if _G.NPCTask then
	_G.NPCTask()
end

if _G.OreTask == nil then
	_G.OreTask = function()
        if Ores.enabled.Value then
			local Ores_Folder = dx9.FindFirstChild(Workspace, "Ores")
			if Ores_Folder ~= nil and Ores_Folder ~= 0 then
				local Ores_Folder_Children = dx9.GetChildren(Ores_Folder)
				if #Ores_Folder_Children > 0 then
					for _, ore in pairs(Ores_Folder_Children) do
						local oreName = dx9.GetName(ore)

						local skipThis = true
						local isType = 0
						if skipThis == true then
							for _, tab in pairs(Config.ores.entries) do
								local Name = tab.name

								if oreName == Name then
									isType = 1
									if Ores_config[Name.."_enabled"].Value then
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
							typeTab = Ores
							typeConfigSettings = Config.ores
							typeConfig = Ores_config
						end

						if not skipThis and typeTab and typeConfigSettings and typeConfig then
							local my_root_pos = dx9.GetPosition(My_root)
							local ore_pos = dx9.GetPosition(ore)
							local root_distance = _G.Get_Distance(my_root_pos, ore_pos)
							if root_distance < ores.distance_limit.Value then
								local root_screen_pos = dx9.WorldToScreen({ore_pos.x, ore_pos.y, ore_pos.z})
								if _G.IsOnScreen(root_screen_pos) then
									Lib_esp.draw({
										esp_type = "misc";
										target = ore;
										color = typeTab.color.Value;
										healthbar = typeConfigSettings.healthbar;
										nametag = typeTab.nametag.Value;
										custom_nametag = oreName;
										distance = typeTab.distance.Value;
										custom_distance = ""..root_distance;
										tracer = typeTab.tracer.Value;
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
if _G.OreTask then
	_G.OreTask()
end

if _G.TrinketTask == nil then
	_G.TrinketTask = function()
		if Trinkets.enabled.Value then
			for i,v in pairs(dx9.GetChildren(Workspace)) do
				local vname = dx9.GetName(v)
				local vtype = dx9.GetType(v)
				if vname == "Folder" and vtype == "Folder" then
					for i,v2 in pairs(dx9.GetChildren(v)) do
						local v2name = dx9.GetName(v2)
						local v2type = dx9.GetType(v2)
						if v2name == "UnionOperation" and v2type == "UnionOperation" then
							local my_root_pos = dx9.GetPosition(My_root)
							local root_pos = dx9.GetPosition(v2)
							local root_distance = _G.Get_Distance(my_root_pos, root_pos)
							if root_distance < Trinkets.distance_limit.Value then
								local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
								if _G.IsOnScreen(root_screen_pos) then
									Lib_esp.draw({
										esp_type = "misc";
										target = v2;
										color = Trinkets.color.Value;
										healthbar = Config.trinkets.healthbar;
										nametag = Trinkets.nametag.Value;
										custom_nametag = "Trinket?";
										distance = Trinkets.distance.Value;
										custom_distance = ""..root_distance;
										tracer = Trinkets.tracer.Value;
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
if _G.TrinketTask then
	_G.TrinketTask()
end