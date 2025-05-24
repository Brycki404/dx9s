--dx9.ShowConsole(true)

local config = _G.config or {
    settings = {
		aimbot_enabled = true,
		sticky_aim = false,
		aimbot_part = 1, -- 1 = "Head", 2 = "HumanoidRootPart"
		aimbot_smoothness = 5,

		menu_toggle_keybind = "[F2]",

		esp_enabled = true,
        box_type = 1, -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
        tracer_type = 1, -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    },
    players = {
        enabled = true,
        distance = true,
        healthbar = false,
        nametag = true,
        tracer = false,
        color = { 255, 255, 255 },
		distance_limit = 5000,
    },
	animals = {
        enabled = false,
        distance = true,
        healthbar = false,
        nametag = true,
        tracer = false,
		color = { 255, 255, 255 },
		distance_limit = 5000,
		entries = {
			{
				AnimalType = "Deer",
				Enabled = true,
			},
			{
				AnimalType = "Bison",
				Enabled = true,
			},
			{
				AnimalType = "Gator",
				Enabled = true,
			},
			{
				AnimalType = "Bear",
				Enabled = true,
			},
			{
				AnimalType = "Horse",
				Enabled = false,
			},
			{
				AnimalType = "Cow",
				Enabled = false,
			},
		},
    },
	trees = {
		enabled = false,
        distance = true,
        healthbar = false,
        nametag = true,
        tracer = false,
		color = { 255, 255, 255 },
		distance_limit = 5000,
		thunderstruck_only = true,
		entries = {},
	},
	ores = {
		enabled = false,
		hide_empty = true,
        distance = true,
        healthbar = false,
        nametag = true,
        tracer = false,
		color = { 255, 255, 255 },
		distance_limit = 5000,
		entries = {
			{
				OreName = "Coal",
				Enabled = true,
			},
			{
				OreName = "Copper",
				Enabled = true,
			},
			{
				OreName = "Zinc",
				Enabled = true,
			},
			{
				OreName = "Iron",
				Enabled = true,
			},
			{
				OreName = "Silver",
				Enabled = true,
			},
			{
				OreName = "Gold",
				Enabled = true,
			},
			{
				OreName = "Limestone",
				Enabled = true,
			},
			{
				OreName = "Quartz",
				Enabled = true,
			},
		},
	},
}
if _G.config == nil then
	_G.config = config
	config = _G.config
end

local lib_ui = loadstring(dx9.Get("https://raw.githubusercontent.com/soupg/DXLibUI/main/main.lua"))()

if _G.lib_esp == nil then
	_G.lib_esp = loadstring(dx9.Get("https://pastebin.com/raw/Pwn8GxMB"))()
end

local interface = lib_ui:CreateWindow({
	Title = "The Wild West | dx9ware | By @Brycki",
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

local tabs = {
	settings = interface:AddTab("Settings"),
	players = interface:AddTab("Players"),
	animals = interface:AddTab("Hunting"),
	trees = interface:AddTab("Logging"),
	ores = interface:AddTab("Mining"),
}

local groupboxes = {
	esp_settings = tabs.settings:AddLeftGroupbox("ESP"),
	aimbot_settings = tabs.settings:AddRightGroupbox("Aimbot"),
	players = tabs.players:AddMiddleGroupbox("Players ESP"),
	animals = tabs.animals:AddLeftGroupbox("Hunting ESP"),
	hunting = tabs.animals:AddRightGroupbox("Hunting Config"),
	trees = tabs.trees:AddMiddleGroupbox("Logging ESP"),
	ores = tabs.ores:AddLeftGroupbox("Mining ESP"),
	oreconfig = tabs.ores:AddRightGroupbox("Mining Config"),
}

local esp_settings = {
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

local aimbot_settings = {
	enabled = groupboxes.aimbot_settings
		:AddToggle({
			Default = config.settings.aimbot_enabled,
			Text = "Aimbot Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Aimbot" or "[settings] Disabled Aimbot", 1)
			if not value then
				_G.aimbot_target_name = nil
				_G.aimbot_target_screen_pos = nil
			end
		end),

	sticky_aim = groupboxes.aimbot_settings
		:AddToggle({
			Default = config.settings.sticky_aim,
			Text = "Stick Aim Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Sticky Aim" or "[settings] Disabled Sticky Aim", 1)
		end),

	part = groupboxes.aimbot_settings
		:AddDropdown({
			Text = "Aimbot Part",
			Default = config.settings.aimbot_part,
			Values = { "Head", "HumanoidRootPart" },
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Aimbot Part: " .. value, 1)
		end),

	smoothness = groupboxes.aimbot_settings:AddSlider({
		Default = config.settings.aimbot_smoothness,
		Text = "Aimbot Smoothness",
		Min = 1,
		Max = 50,
		Rounding = 0,
	}).Value,
}

local aimbot_target_name = _G.aimbot_target_name or nil
local aimbot_target_screen_pos = _G.aimbot_target_screen_pos or nil

local players = {
	enabled = groupboxes.players
		:AddToggle({
			Default = config.players.enabled,
			Text = "Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled ESP" or "[players] Disabled ESP", 1)
		end),

	distance = groupboxes.players
		:AddToggle({
			Default = config.players.distance,
			Text = "Distance",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled Distance" or "[players] Disabled Distance", 1)
		end),
    
	nametag = groupboxes.players
		:AddToggle({
			Default = config.players.nametag,
			Text = "Nametag",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled Nametag" or "[players] Disabled Nametag", 1)
		end),

	tracer = groupboxes.players
		:AddToggle({
			Default = config.players.tracer,
			Text = "Tracer",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[players] Enabled Tracer" or "[players] Disabled Tracer", 1)
		end),

    color = groupboxes.players:AddColorPicker({
		Default = config.players.color,
		Text = "Color",
	}).Value,

    distance_limit = groupboxes.players:AddSlider({
		Default = config.players.distance_limit,
		Text = "ESP Distance Limit",
		Min = 0,
		Max = 5000,
		Rounding = 0,
	}).Value,
}

local animals = {
	enabled = groupboxes.animals
		:AddToggle({
			Default = config.animals.enabled,
			Text = "Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[hunting] Enabled ESP" or "[hunting] Disabled ESP", 1)
		end),

	distance = groupboxes.animals
		:AddToggle({
			Default = config.animals.distance,
			Text = "Distance",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[hunting] Enabled Distance" or "[hunting] Disabled Distance", 1)
		end),

	nametag = groupboxes.animals
		:AddToggle({
			Default = config.animals.nametag,
			Text = "Nametag",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[hunting] Enabled Nametag" or "[hunting] Disabled Nametag", 1)
		end),

	tracer = groupboxes.animals
		:AddToggle({
			Default = config.animals.tracer,
			Text = "Tracer",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[hunting] Enabled Tracer" or "[hunting] Disabled Tracer", 1)
		end),

    color = groupboxes.animals:AddColorPicker({
		Default = config.animals.color,
		Text = "Color",
	}).Value,

	distance_limit = groupboxes.animals:AddSlider({
		Default = config.animals.distance_limit,
		Text = "ESP Distance Limit",
		Min = 0,
		Max = 5000,
		Rounding = 0,
	}).Value,
}

local hunting = {}
for _, animalTab in pairs(config.animals.entries) do
	local animalType = animalTab.AnimalType
	local animalEnabled = animalTab.Enabled
	hunting[animalType.."_enabled"] = groupboxes.hunting
		:AddToggle({
			Default = animalEnabled,
			Text = animalType.." ESP Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[hunting] Enabled "..animalType.." ESP" or "[hunting] Disabled "..animalType.." ESP", 1)
		end)

	hunting[animalType.."_color"] = groupboxes.hunting
		:AddColorPicker({
			Default = config.animals.color,
			Text = animalType.." Color",
		}).Value

	hunting[animalType.."_distance_limit"] = groupboxes.hunting
		:AddSlider({
			Default = config.animals.distance_limit,
			Text = animalType.." ESP Distance Limit",
			Min = 0,
			Max = 5000,
			Rounding = 0,
		}).Value
end

local trees = {
	enabled = groupboxes.trees
		:AddToggle({
			Default = config.trees.enabled,
			Text = "Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[logging] Enabled ESP" or "[logging] Disabled ESP", 1)
		end),

	thunderstruck_only = groupboxes.trees
		:AddToggle({
			Default = config.trees.thunderstruck_only,
			Text = "Thunderstruck Only",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[logging] Enabled Thunderstruck Only" or "[logging] Disabled Thundrstruck Only", 1)
		end),

	distance = groupboxes.trees
		:AddToggle({
			Default = config.trees.distance,
			Text = "Distance",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[logging] Enabled Distance" or "[logging] Disabled Distance", 1)
		end),

	nametag = groupboxes.trees
		:AddToggle({
			Default = config.trees.nametag,
			Text = "Nametag",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[logging] Enabled Nametag" or "[logging] Disabled Nametag", 1)
		end),

	tracer = groupboxes.trees
		:AddToggle({
			Default = config.trees.tracer,
			Text = "Tracer",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[logging] Enabled Tracer" or "[logging] Disabled Tracer", 1)
		end),

    color = groupboxes.trees:AddColorPicker({
		Default = config.trees.color,
		Text = "Color",
	}).Value,

	distance_limit = groupboxes.trees:AddSlider({
		Default = config.trees.distance_limit,
		Text = "ESP Distance Limit",
		Min = 0,
		Max = 5000,
		Rounding = 0,
	}).Value,
}

local ores = {
	enabled = groupboxes.ores
		:AddToggle({
			Default = config.ores.enabled,
			Text = "Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[mining] Enabled ESP" or "[mining] Disabled ESP", 1)
		end),

	hide_empty = groupboxes.ores
		:AddToggle({
			Default = config.ores.hide_empty,
			Text = "Hide Empty",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[mining] Enabled Hide Empty" or "[mining] Disabled Hide Empty", 1)
		end),

	distance = groupboxes.ores
		:AddToggle({
			Default = config.ores.distance,
			Text = "Distance",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[mining] Enabled Distance" or "[mining] Disabled Distance", 1)
		end),

	nametag = groupboxes.ores
		:AddToggle({
			Default = config.ores.nametag,
			Text = "Nametag",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[mining] Enabled Nametag" or "[mining] Disabled Nametag", 1)
		end),

	tracer = groupboxes.ores
		:AddToggle({
			Default = config.ores.tracer,
			Text = "Tracer",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[mining] Enabled Tracer" or "[mining] Disabled Tracer", 1)
		end),

    color = groupboxes.ores:AddColorPicker({
		Default = config.ores.color,
		Text = "Color",
	}).Value,

	distance_limit = groupboxes.ores:AddSlider({
		Default = config.ores.distance_limit,
		Text = "ESP Distance Limit",
		Min = 0,
		Max = 5000,
		Rounding = 0,
	}).Value,
}

local oreconfig = {}
for _, oreTab in pairs(config.ores.entries) do
	local oreName = oreTab.OreName
	local oreEnabled = oreTab.Enabled
	oreconfig[oreName.."_enabled"] = groupboxes.oreconfig
		:AddToggle({
			Default = oreEnabled,
			Text = oreName.." ESP Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[mining] Enabled "..oreName.." ESP" or "[mining] Disabled "..oreName.." ESP", 1)
		end)

	oreconfig[oreName.."_color"] = groupboxes.oreconfig
		:AddColorPicker({
			Default = config.ores.color,
			Text = oreName.." Color",
		}).Value

	oreconfig[oreName.."_distance_limit"] = groupboxes.oreconfig
		:AddSlider({
			Default = config.ores.distance_limit,
			Text = oreName.." ESP Distance Limit",
			Min = 0,
			Max = 5000,
			Rounding = 0,
		}).Value
end

if _G.Get_Distance == nil then
	_G.Get_Distance = function(myRoot, part)
		local v1 = myRoot
		local v2 = part

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

local datamodel = dx9.GetDatamodel()
local workspace = dx9.FindFirstChild(datamodel, "Workspace")
local services = {
	players = dx9.FindFirstChild(datamodel, "Players"),
}

local local_player = nil
local mouse = nil

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

local current_aimbot_part = _G.Get_Index("aimbot_part", aimbot_settings.part.Value)
local current_tracer_type = _G.Get_Index("tracer", esp_settings.tracer_type.Value)
local current_box_type = _G.Get_Index("box", esp_settings.box_type.Value)

if local_player == nil then
	for _, player in pairs(dx9.GetChildren(services.players)) do
		if dx9.FindFirstChild(player, "PlayerGui") then
			local_player = player
			break
		end
	end
end

local function get_local_player_name()
	if dx9.GetType(local_player) == "Player" then
		return dx9.GetName(local_player)
	else
		return local_player.Info.Name
	end
end

local workspace_entities = dx9.FindFirstChild(workspace, "WORKSPACE_Entities")
local player_entities = dx9.FindFirstChild(workspace_entities, "Players")
if workspace_entities == 0 or player_entities == 0 then
	return false
end

local my_player = dx9.FindFirstChild(services.players, get_local_player_name())
local my_character = nil
local my_root = nil
local my_humanoid = nil
if my_player and my_player ~= 0 then
    my_character = dx9.FindFirstChild(player_entities, get_local_player_name())
    if my_character and my_character ~= 0 then
        my_root = dx9.FindFirstChild(my_character, "HumanoidRootPart")
        my_humanoid = dx9.FindFirstChild(my_character, "Humanoid")
    end
end

if not my_root or my_root == 0 then
    return
end

local health_value_name = "Health"

local screen_size = nil

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
				if playerName and playerName ~= get_local_player_name() then
					local teamName = dx9.GetTeam(player)
					local playerColor = players.color
					if teamName == "Outlaws" then
						playerColor = {255, 0, 0}
					elseif teamName == "Lawmen" then
						playerColor = {0, 0, 255}
					elseif teamName == "Citizens" then
						playerColor = {255, 255, 0}
					end
					
					local character = dx9.FindFirstChild(player_entities, playerName)
					if character and character ~= 0 then
						local root = dx9.FindFirstChild(character, "HumanoidRootPart")
						local head = dx9.FindFirstChild(character, "Head")
						local humanoid = dx9.FindFirstChild(character, "Humanoid")

						if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
							if teamName and (teamName == "Outlaws" or teamName == "Lawmen" or teamName == "Citizens") then
								local my_root_pos = dx9.GetPosition(my_root)
								local root_pos = dx9.GetPosition(root)
								local root_distance = _G.Get_Distance(my_root_pos, root_pos)
								local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
								local head_pos = dx9.GetPosition(head)
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

										if not aimbot_settings.sticky_aim.Value or aimbot_settings.sticky_aim.Value and not aimbot_target_name then
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
									end
									
									if esp_settings.enabled.Value and players.enabled.Value then
										if root_distance < players.distance_limit then
											_G.lib_esp.draw({
												target = character,
												color = playerColor,
												healthbar = config.players.healthbar,
												nametag = players.nametag.Value,
												distance = players.distance.Value,
												custom_distance = "" .. root_distance,
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
			end

			if aimbot_settings.enabled.Value then
				if dx9.isRightClickHeld() then --swapping targets
					if aimbot_settings.sticky_aim.Value then
						if not aimbot_target_name or aimbot_target_name and aimbot_target_name == 0 then
							aimbot_target_name = closest_player_name
							aimbot_target_screen_pos = closest_player_screen_pos
						end
					else
						aimbot_target_name = closest_player_name
						aimbot_target_screen_pos = closest_player_screen_pos
					end
				end

				if aimbot_target_name and _G.IsOnScreen(aimbot_target_screen_pos) then
					--print(aimbot_target_name.." | x: "..aimbot_target_screen_pos.x.." | y: "..aimbot_target_screen_pos.y)
					local mouse_moved = false
					if mouse_moved == false then
						dx9.SetAimbotValue("x", 0)
						dx9.SetAimbotValue("y", 0)
						dx9.SetAimbotValue("z", 0)
						dx9.FirstPersonAim({
							aimbot_target_screen_pos.x + screen_size.width/2,
							aimbot_target_screen_pos.y + screen_size.height/2
						}, aimbot_settings.smoothness, 1)
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

if _G.AnimalEspTask == nil then
	_G.AnimalEspTask = function()
		local animal_entities = dx9.FindFirstChild(workspace_entities, "Animals")
		if animal_entities then
			if animals.enabled.Value then
				for _, animal in pairs(dx9.GetChildren(animal_entities)) do
					local animalName = dx9.GetName(animal)
					local animalType = nil
					local skipThisAnimal = true
					for _, animalTab in pairs(config.animals.entries) do
						local at = animalTab.AnimalType
						if string.match(animalName, at) then
							animalType = at
							if hunting[animalType.."_enabled"].Value then
								skipThisAnimal = false
							end
							break
						end
					end
					if not skipThisAnimal then
						local root = dx9.FindFirstChild(animal, "HumanoidRootPart")
						local healthNumber = dx9.FindFirstChild(animal, health_value_name)
						if root and root ~= 0 and healthNumber and healthNumber ~= 0 then
							local my_root_pos = dx9.GetPosition(my_root)
							local root_pos = dx9.GetPosition(root)
							local health = dx9.GetNumValue(healthNumber)
							local root_distance = _G.Get_Distance(my_root_pos, root_pos)
							if root_distance < (animalType and hunting[animalType.."_distance_limit"] or animals.distance_limit) then
								local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
								if _G.IsOnScreen(root_screen_pos) then
									_G.lib_esp.draw({
										target = animal,
										color = animalType and hunting[animalType.."_color"] or animals.color,
										healthbar = config.animals.healthbar,
										nametag = animals.nametag.Value,
										custom_nametag = animalName .. " | " .. health .. " hp",
										distance = animals.distance.Value,
										custom_distance = "" .. root_distance,
										tracer = animals.tracer.Value,
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
	end
end
if _G.AnimalEspTask then
	_G.AnimalEspTask()
end

--local npc_entities = dx9.FindFirstChild(workspace_entities, "NPCs")

if _G.OreEspTask == nil then
	_G.OreEspTask = function()
		local deposit_info_folder_name = "DepositInfo"
		local ore_remaining_value_name = "OreRemaining"

		local workspace_interactables = dx9.FindFirstChild(workspace, "WORKSPACE_Interactables")
		local mining_interactables = nil
		local ore_deposits_interactables = nil
		if workspace_interactables and workspace_interactables ~= 0 then
			mining_interactables = dx9.FindFirstChild(workspace_interactables, "Mining")
			if mining_interactables and mining_interactables ~= 0 then
				ore_deposits_interactables = dx9.FindFirstChild(mining_interactables, "OreDeposits")
			end
		end
		if ore_deposits_interactables and ore_deposits_interactables ~= 0 then
			if ores.enabled.Value then
				for _, typeFolder in pairs(dx9.GetChildren(ore_deposits_interactables)) do
					local typeName = dx9.GetName(typeFolder)
					local oreName = nil
					local oreEnabled = true
					for _, oreTab in pairs(config.ores.entries) do
						local oreTabName = oreTab.OreName
						if string.match(typeName, oreTabName) then
							oreName = oreTabName
							if not oreconfig[oreName.."_enabled"].Value then
								oreEnabled = false
							end
							break
						end
					end
					if oreEnabled then
						for _, model in pairs(dx9.GetChildren(typeFolder)) do
							local modelName = dx9.GetName(model)
							local meshpart = dx9.FindFirstChildOfClass(model, "MeshPart")
							local depositInfo = dx9.FindFirstChild(model, deposit_info_folder_name)
							if meshpart and meshpart ~= 0 and depositInfo and depositInfo ~= 0 then
								local remainingNumber = dx9.FindFirstChild(depositInfo, ore_remaining_value_name)
								if remainingNumber and remainingNumber ~= 0 then
									local remainingNumber = dx9.GetNumValue(remainingNumber)
									if ores.hide_empty.Value and remainingNumber > 0 or not ores.hide_empty.Value then
										local my_root_pos = dx9.GetPosition(my_root)
										local meshpart_pos = dx9.GetPosition(meshpart)
										local meshpartName = dx9.GetName(meshpart)
										local got_distance = _G.Get_Distance(my_root_pos, meshpart_pos)
										if got_distance < (oreconfig[oreName.."_distance_limit"] or ores.distance_limit) then
											local screen_pos = dx9.WorldToScreen({meshpart_pos.x, meshpart_pos.y, meshpart_pos.z})
											if _G._G.IsOnScreen(screen_pos) then
												_G.lib_esp.draw({
													target = model,
													custom_root = meshpartName,
													color = oreconfig[oreName.."_color"] or ores.color,
													healthbar = config.ores.healthbar,
													nametag = ores.nametag.Value,
													custom_nametag = typeName .. " | " .. remainingNumber .. " left",
													distance = ores.distance.Value,
													custom_distance = "" .. got_distance,
													tracer = ores.tracer.Value,
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
				end
			end
		end
	end
end
if _G.OreEspTask then
	_G.OreEspTask()
end

if _G.TreeEspTask == nil then
	_G.TreeEspTask = function()
		local trees_folder_name = "Trees"
		local vegetation_folder_name = "Vegetation"
		local tree_info_folder_name = "TreeInfo"
		
		local workspace_geometry = dx9.FindFirstChild(workspace, "WORKSPACE_Geometry")
		local workspace_ignore = dx9.FindFirstChild(workspace, "Ignore")
		local foliageModel = nil
		if workspace_ignore and workspace_ignore ~= 0 then
			foliageModel = dx9.FindFirstChild(workspace_ignore, "FoliageModel")
		end

		if trees.enabled.Value then
			local function addTree(model)
				local modelName = dx9.GetName(model)
				local meshpart = dx9.FindFirstChildOfClass(model, "MeshPart")
				local treeinfo = dx9.FindFirstChild(model, tree_info_folder_name)

				if meshpart ~= 0 and treeinfo ~= 0 then
					local healthNumber = dx9.FindFirstChild(treeinfo, health_value_name)
					if healthNumber ~= 0 then
						local my_root_pos = dx9.GetPosition(my_root)
						local meshpart_pos = dx9.GetPosition(meshpart)
						local health = dx9.GetNumValue(healthNumber)
						local meshpartName = dx9.GetName(meshpart)
						local got_distance = _G.Get_Distance(my_root_pos, meshpart_pos)
						if got_distance < trees.distance_limit then
							local screen_pos = dx9.WorldToScreen({meshpart_pos.x, meshpart_pos.y, meshpart_pos.z})
							if _G.IsOnScreen(screen_pos) then
								_G.lib_esp.draw({
									target = model,
									custom_root = meshpartName,
									color = trees.color,
									healthbar = config.trees.healthbar,
									nametag = trees.nametag.Value,
									custom_nametag = modelName .. " | " .. health .. " hp",
									distance = trees.distance.Value,
									custom_distance = "" .. got_distance,
									tracer = trees.tracer.Value,
									tracer_type = current_tracer_type,
									box_type = current_box_type,
								})
							end
						end
					end
				end
			end

			local function hasStrike2(model)
				local found = false
				for _, part in pairs(dx9.GetChildren(model)) do
					local strike2 = dx9.FindFirstChild(part, "Strike2")
					if strike2 ~= 0 then
						found = true
						break
					end
				end
				return found
			end

			local function treesLoop(folder)
				for _, model in pairs(dx9.GetChildren(folder)) do
					if trees.thunderstruck_only.Value then
						local strike2 = hasStrike2(model)
						if strike2 then
							addTree(model)
						end
					else
						addTree(model)
					end
				end
			end

			if workspace_geometry and workspace_geometry ~= 0 then
				for _, region in pairs(dx9.GetChildren(workspace_geometry)) do
					local trees_folder = dx9.FindFirstChild(region, trees_folder_name)
					local vegitation_folder = dx9.FindFirstChild(region, vegetation_folder_name)

					if trees_folder and trees_folder ~= 0 then
						treesLoop(trees_folder)
					end
					if vegitation_folder and vegitation_folder ~= 0 then
						treesLoop(vegitation_folder)
					end
				end
			end

			if foliageModel and foliageModel ~= 0 then
				treesLoop(foliageModel)
			end
		end
	end
end
if _G.TreeEspTask then
	_G.TreeEspTask()
end
