--indent size 4

--dx9.ShowConsole(true)

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/B0NBunny/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://pastebin.com/raw/Pwn8GxMB";
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
        healthtag = false;
        nametag = true;
        tracer = false;
        color = { 0, 0, 255 };
		distance_limit = 5000;
    };
	enemies = {
        enabled = true;
        distance = true;
        healthbar = true;
		healthtag = false;
        nametag = true;
        tracer = false;
		color = { 255, 0, 0 };
		distance_limit = 5000;
    };
	npcs = {
		enabled = false;
        distance = true;
        nametag = true;
        tracer = false;
		color = { 255, 255, 255 };
		distance_limit = 5000;
	};
}
if _G.config == nil then
	_G.config = config
	config = _G.config
end

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

lib_esp = loadstring(dx9.Get(config.urls.LibESP))()

interface = lib_ui:CreateWindow({
	Title = "Deepwoken | dx9ware | By @Brycki";
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
}

groupboxes = {
	esp_settings = tabs.settings:AddLeftGroupbox("ESP");
	players = tabs.players:AddLeftGroupbox("Players ESP");
	enemies = tabs.enemies:AddLeftGroupbox("Enemies ESP");
	npcs = tabs.npcs:AddLeftGroupbox("NPCs ESP");
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

    healthtag = groupboxes.players
		:AddToggle({
			Default = config.players.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled HealthTag" or "[players] Disabled HealthTag", 1)
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
		Max = 5000;
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
			lib_ui:Notify(value and "[hunting] Enabled Distance" or "[hunting] Disabled Distance", 1)
		end);

	nametag = groupboxes.enemies
		:AddToggle({
			Default = config.enemies.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[hunting] Enabled Nametag" or "[hunting] Disabled Nametag", 1)
		end);

	healthtag = groupboxes.enemies
		:AddToggle({
			Default = config.enemies.healthtag;
			Text = "HealthTag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[Enemies] Enabled HealthTag" or "[Enemies] Disabled HealthTag", 1)
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
		Max = 5000;
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
			lib_ui:Notify(value and "[NPCs] Enabled ESP" or "[NPCs] Disabled ESP", 1)
		end);

	distance = groupboxes.npcs
		:AddToggle({
			Default = config.npcs.distance;
			Text = "Distance";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[NPCs] Enabled Distance" or "[NPCs] Disabled Distance", 1)
		end);

	nametag = groupboxes.npcs
		:AddToggle({
			Default = config.npcs.nametag;
			Text = "Nametag";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[NPCs] Enabled Nametag" or "[NPCs] Disabled Nametag", 1)
		end);

	tracer = groupboxes.npcs
		:AddToggle({
			Default = config.npcs.tracer;
			Text = "Tracer";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[NPCs] Enabled Tracer" or "[NPCs] Disabled Tracer", 1)
		end);

    color = groupboxes.npcs:AddColorPicker({
		Default = config.npcs.color;
		Text = "Color";
	});

	distance_limit = groupboxes.npcs:AddSlider({
		Default = config.npcs.distance_limit;
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

workspace_Live = dx9.FindFirstChild(workspace, "Live")
workspace_NPCs = dx9.FindFirstChild(workspace, "NPCs")

if workspace_Live == nil or workspace_Live == 0 or workspace_NPCs == nil or workspace_NPCs == 0 then
	return false
end

my_player = dx9.FindFirstChild(services.players, local_player_name)
my_character = nil
my_head = nil
my_root = nil
my_humanoid = nil

if my_player == nil or my_player == 0 then
	return
elseif my_player ~= nil and my_player ~= 0 then
    my_character = dx9.FindFirstChild(workspace_Live, local_player_name)
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

if _G.LiveTask == nil then
	_G.LiveTask = function()
        if players.enabled.Value or enemies.enabled.Value then
            for _, entity in pairs(dx9.GetChildren(workspace_Live)) do
                local entityName = dx9.GetName(entity)
                local entityTab = enemies
                local entityConfig = config.enemies
                local playerObject = dx9.FindFirstChild(services.players, entityName)
                if playerObject and playerObject ~= 0 then
                    entityTab = players
                    entityConfig = config.players
                end
                local root = dx9.FindFirstChild(entity, "HumanoidRootPart")
                if root and root ~= 0 then
                    local my_root_pos = dx9.GetPosition(my_root)
                    local root_pos = dx9.GetPosition(root)
                    local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                    if root_distance < entityTab.distance_limit.Value then
                        local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                        if _G.IsOnScreen(root_screen_pos) then
                        	lib_esp.draw({
                                target = entity;
                                color = entityTab.color.Value;
                                healthbar = entityConfig.healthbar;
                                nametag = entityTab.nametag.Value;
                                custom_nametag = entityTab.healthtag.Value and entityName .. " | " .. "0" .. " hp" or entityName;
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
if _G.LiveTask then
	_G.LiveTask()
end

if _G.NPCTask == nil then
	_G.NPCTask = function()
		if npcs.enabled.Value then
            for _, npc in pairs(dx9.GetChildren(workspace_NPCs)) do
                local npcName = dx9.GetName(npc)
                local root = dx9.FindFirstChild(npc, "HumanoidRootPart")
                if root and root ~= 0 then
                    local my_root_pos = dx9.GetPosition(my_root)
                    local root_pos = dx9.GetPosition(root)
                    local root_distance = _G.Get_Distance(my_root_pos, root_pos)
                    if root_distance < npcs.distance_limit.Value then
                        local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                        if _G._G.IsOnScreen(root_screen_pos) then
                            lib_esp.draw({
                                target = npc;
                                custom_root = npcName;
                                color = npcs.color.Value;
                                healthbar = false;
                                nametag = npcs.nametag.Value;
                                custom_nametag = npcName;
                                distance = npcs.distance.Value;
                                custom_distance = ""..root_distance;
                                tracer = npcs.tracer.Value;
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
if _G.NPCTask then
	_G.NPCTask()
end
