--indent size 4

config = _G.config or {
    settings = {
		menu_toggle_keybind = "[F2]",
		
		esp_enabled = true,
    	box_type = 1, -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1, -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    },
    trinkets = {
        enabled = true,
        distance = true,
        healthbar = false,
        nametag = true,
        tracer = false,
		color = { 255, 255, 255 },
		distance_limit = 10000,
		entries = {
			{
				name = "Ring",
				Enabled = true,
			},
            {
				name = "Amulet",
				Enabled = true,
			},
            {
				name = "Mushroom",
				Enabled = true,
			},
            {
				name = "Goblet",
				Enabled = true,
			},
		},
	},
}
if _G.config == nil then
	_G.config = config
	config = _G.config
end

lib_ui = loadstring(dx9.Get("https://raw.githubusercontent.com/soupg/DXLibUI/main/main.lua"))()

lib_esp = loadstring(dx9.Get("https://pastebin.com/raw/Pwn8GxMB"))()

interface = lib_ui:CreateWindow({
	Title = "Rogueblox | dx9ware | By @Brycki",
	Size = { 500, 500 },
	Resizable = true,

	ToggleKey = config.settings.menu_toggle_keybind,

	FooterToggle = false,
	FooterRGB = true,
	FontColor = { 255, 255, 255 },
	MainColor = { 32, 26, 68 },
	BackgroundColor = { 26, 21, 55 },
	AccentColor = { 81, 37, 112 },
	OutlineColor = { 54, 47, 90 },
})

tabs = {
	settings = interface:AddTab("Settings"),
	trinkets = interface:AddTab("Trinkets"),
}

groupboxes = {
	esp_settings = tabs.settings:AddLeftGroupbox("ESP"),
	trinkets = tabs.trinkets:AddLeftGroupbox("Trinket ESP"),
	trinkets_config = tabs.trinkets:AddRightGroupbox("Trinket Config"),
}

esp_settings = {
	enabled = groupboxes.esp_settings
		:AddToggle({
			Default = config.settings.esp_enabled,
			Text = "ESP Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Global ESP" or "[settings] Disabled Global ESP", 1)
		end),

	box_type = groupboxes.esp_settings
		:AddDropdown({
			Text = "Box Type",
			Default = config.settings.box_type,
			Values = { "Corners", "2D Box", "3D Box" },
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Box Type: " .. value, 1)
		end),

	tracer_type = groupboxes.esp_settings
		:AddDropdown({
			Text = "Tracer Type",
			Default = config.settings.tracer_type,
			Values = { "Near-Bottom", "Bottom", "Top", "Mouse" },
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Tracer Type: " .. value, 1)
		end),
}

trinkets = {
	enabled = groupboxes.trinkets
		:AddToggle({
			Default = config.trinkets.enabled,
			Text = "Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled ESP" or "[trinkets] Disabled ESP", 1)
		end),

	distance = groupboxes.trinkets
		:AddToggle({
			Default = config.trinkets.distance,
			Text = "Distance",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled Distance" or "[trinkets] Disabled Distance", 1)
		end),

	nametag = groupboxes.trinkets
		:AddToggle({
			Default = config.trinkets.nametag,
			Text = "Nametag",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled Nametag" or "[trinkets] Disabled Nametag", 1)
		end),

	tracer = groupboxes.trinkets
		:AddToggle({
			Default = config.trinkets.tracer,
			Text = "Tracer",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled Tracer" or "[trinkets] Disabled Tracer", 1)
		end),

    color = groupboxes.trinkets:AddColorPicker({
		Default = config.trinkets.color,
		Text = "Color",
	}),

	distance_limit = groupboxes.trinkets:AddSlider({
		Default = config.trinkets.distance_limit,
		Text = "ESP Distance Limit",
		Min = 0,
		Max = 10000,
		Rounding = 0,
	}),
}

trinkets_config = {}
for _, tab in pairs(config.trinkets.entries) do
	local name = tab.name
	local Enabled = tab.Enabled

	trinkets_config[name.."_enabled"] = groupboxes.trinkets_config
		:AddToggle({
			Default = Enabled,
			Text = name.." ESP Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[trinkets] Enabled "..name.." ESP" or "[trinkets] Disabled "..name.." ESP", 1)
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
	players = dx9.FindFirstChild(datamodel, "Players"),
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

local Debris_Folder = dx9.FindFirstChild(workspace, "Debris")
local SpawnedItems_Folder = nil
if Debris_Folder and Debris_Folder ~= 0 then
    SpawnedItems_Folder = dx9.FindFirstChild(Debris_Folder, "SpawnedItems") --all children are BaseParts
    if SpawnedItems_Folder and SpawnedItems_Folder ~= 0 then
        if _G.SpawnedItemsTask == nil then
            _G.SpawnedItemsTask = function()
                if trinkets.enabled.Value then
                    print("enabled")
                    for _, basePart in pairs(dx9.GetChildren(SpawnedItems_Folder)) do
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
                                        esp_type = "misc",
                                        target = basePart,
                                        color = typeTab.color.Value,
                                        healthbar = typeConfigSettings.healthbar,
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
        end
        if _G.SpawnedItemsTask then
            _G.SpawnedItemsTask()
        end
    end
end
