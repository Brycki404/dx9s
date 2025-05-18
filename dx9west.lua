local config = _G.config or {
    settings = {
        enabled = true,
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

local lib_ui = loadstring(dx9.Get("https://raw.githubusercontent.com/soupg/DXLibUI/main/main.lua"))()
local lib_esp = loadstring(dx9.Get("https://pastebin.com/raw/Pwn8GxMB"))()

local interface = lib_ui:CreateWindow({
	Title = "The Wild West | dx9ware",
	Size = { 500, 500 },
	Resizable = false,

	ToggleKey = "[F2]",

	FooterToggle = false,
	FooterRGB = false,
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
	settings = tabs.settings:AddMiddleGroupbox("< Settings >"),
	players = tabs.players:AddMiddleGroupbox("Players ESP"),
	animals = tabs.animals:AddLeftGroupbox("Hunting ESP"),
	hunting = tabs.animals:AddRightGroupbox("Hunting Config"),
	trees = tabs.trees:AddMiddleGroupbox("Logging ESP"),
	ores = tabs.ores:AddLeftGroupbox("Mining ESP"),
	oreconfig = tabs.ores:AddRightGroupbox("Mining Config"),
}

local settings = {
	enabled = groupboxes.settings
		:AddToggle({
			Default = config.settings.enabled,
			Text = "ESP Enabled",
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Global ESP" or "[settings] Disabled Global ESP", 1)
		end),

	box_type = groupboxes.settings
		:AddDropdown({
			Text = "Box Type",
			Default = config.settings.box_type,
			Values = { "Corners", "2D Box", "3D Box" },
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Box Type: " .. value, 1)
		end),

	tracer_type = groupboxes.settings
		:AddDropdown({
			Text = "Tracer Type",
			Default = config.settings.tracer_type,
			Values = { "Near-Bottom", "Bottom", "Top", "Mouse" },
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Tracer Type: " .. value, 1)
		end),
}

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

local datamodel = dx9.GetDatamodel()
local workspace = dx9.FindFirstChild(datamodel, "Workspace")
local services = {
	players = dx9.FindFirstChild(datamodel, "Players"),
}

local function get_distance(myRoot, part)
    local v1 = myRoot
	local v2 = part

	local a = (v1.x - v2.x) * (v1.x - v2.x)
	local b = (v1.y - v2.y) * (v1.y - v2.y)
	local c = (v1.z - v2.z) * (v1.z - v2.z)

	return math.floor(math.sqrt(a + b + c) + 0.5)
end

local function get_index(type, value)
	local table = type == "tracer" and { "Near-Bottom", "Bottom", "Top", "Mouse" } or { "Corners", "2D Box", "3D Box" }

	for index, item in pairs(table) do
		if item == value then
			return index
		end
	end

	return nil
end

local local_player = nil
local mouse = dx9.GetMouse()
local current_tracer_type = get_index("tracer", settings.tracer_type.Value)
local current_box_type = get_index("box", settings.box_type.Value)

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

local workspace_geometry = dx9.FindFirstChild(workspace, "WORKSPACE_Geometry")
local health_value_name = "Health"
local trees_folder_name = "Trees"
local vegetation_folder_name = "Vegetation"
local tree_info_folder_name = "TreeInfo"
local deposit_info_folder_name = "DepositInfo"
local ore_remaining_value_name = "OreRemaining"

local workspace_interactables = dx9.FindFirstChild(workspace, "WORKSPACE_Interactables")
local mining_interactables = nil
local ore_deposits_interactables = nil
if workspace_interactables ~= 0 then
	mining_interactables = dx9.FindFirstChild(workspace_interactables, "Mining")
	if mining_interactables ~= 0 then
		ore_deposits_interactables = dx9.FindFirstChild(mining_interactables, "OreDeposits")
	end
end

local workspace_ignore = dx9.FindFirstChild(workspace, "Ignore")
local foliageModel = nil
if workspace_ignore ~= 0 then
	foliageModel = dx9.FindFirstChild(workspace_ignore, "FoliageModel")
end

local workspace_entities = dx9.FindFirstChild(workspace, "WORKSPACE_Entities")
local animal_entities = dx9.FindFirstChild(workspace_entities, "Animals")
local npc_entitiees = dx9.FindFirstChild(workspace_entities, "NPCs")
local player_entities = dx9.FindFirstChild(workspace_entities, "Players")

if workspace_entities == 0 or player_entities == 0 then
	return false
end

if not settings.enabled.Value then
	return
end

local my_player = dx9.FindFirstChild(services.players, get_local_player_name())
local my_character = nil
local my_root = nil
local my_humanoid = nil
if my_player then
    my_character = dx9.FindFirstChild(player_entities, get_local_player_name())
    if my_character then
        my_root = dx9.FindFirstChild(my_character, "HumanoidRootPart")
        my_humanoid = dx9.FindFirstChild(my_character, "Humanoid")
    end
end

if not my_root then
    return
end

if players.enabled.Value then
    for _, player in pairs(dx9.GetChildren(services.players)) do
        local playerName = dx9.GetName(player)
        if playerName ~= get_local_player_name() then
			
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
            if character ~= 0 then
                local root = dx9.FindFirstChild(character, "HumanoidRootPart")
                local humanoid = dx9.FindFirstChild(character, "Humanoid")

                if root ~= 0 and humanoid ~= 0 then
					if teamName == "Outlaws" or teamName == "Lawmen" or teamName == "Citizens" then
						local got_distance = get_distance(dx9.GetPosition(my_root), dx9.GetPosition(root))
						if got_distance < players.distance_limit then
							lib_esp.draw({
								target = character,
								color = playerColor,
								healthbar = config.players.healthbar,
								nametag = players.nametag.Value,
								distance = players.distance.Value,
								custom_distance = "" .. got_distance,
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
				if root ~= 0 and healthNumber ~= 0 then
					local health = dx9.GetNumValue(healthNumber)
					local got_distance = get_distance(dx9.GetPosition(my_root), dx9.GetPosition(root))
					if got_distance < (animalType and hunting[animalType.."_distance_limit"] or animals.distance_limit) then
						lib_esp.draw({
							target = animal,
							color = animalType and hunting[animalType.."_color"] or animals.color,
							healthbar = config.animals.healthbar,
							nametag = animals.nametag.Value,
							custom_nametag = animalName .. " | " .. health .. " hp",
							distance = animals.distance.Value,
							custom_distance = "" .. got_distance,
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

if ore_deposits_interactables then
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
					if meshpart ~= 0 and depositInfo ~= 0 then
						local remainingNumber = dx9.FindFirstChild(depositInfo, ore_remaining_value_name)
						if remainingNumber ~= 0 then
							local remainingNumber = dx9.GetNumValue(remainingNumber)
							local meshpartName = dx9.GetName(meshpart)
							local got_distance = get_distance(dx9.GetPosition(my_root), dx9.GetPosition(meshpart))
							if got_distance < (oreconfig[oreName.."_distance_limit"] or ores.distance_limit) then
								lib_esp.draw({
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

dx9.ShowConsole(true)

if trees.enabled.Value then
	local function addTree(model)
		local modelName = dx9.GetName(model)
		local meshpart = dx9.FindFirstChildOfClass(model, "MeshPart")
		local treeinfo = dx9.FindFirstChild(model, tree_info_folder_name)

		if meshpart ~= 0 and treeinfo ~= 0 then
			local healthNumber = dx9.FindFirstChild(treeinfo, health_value_name)
			if healthNumber ~= 0 then
				local health = dx9.GetNumValue(healthNumber)
				local meshpartName = dx9.GetName(meshpart)
				local got_distance = get_distance(dx9.GetPosition(my_root), dx9.GetPosition(meshpart))
				if got_distance < trees.distance_limit then
					lib_esp.draw({
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

	if workspace_geometry ~= 0 then
		for _, region in pairs(dx9.GetChildren(workspace_geometry)) do
			local trees_folder = dx9.FindFirstChild(region, trees_folder_name)
			local vegitation_folder = dx9.FindFirstChild(region, vegetation_folder_name)

			if trees_folder ~= 0 then
				treesLoop(trees_folder)
			end
			if vegitation_folder ~= 0 then
				treesLoop(vegitation_folder)
			end
		end
	end

	if foliageModel ~= 0 then
		treesLoop(foliageModel)
	end
end