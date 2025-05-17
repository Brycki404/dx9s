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
		entries = {},
	},
	ores = {
		enabled = false,
        distance = true,
        healthbar = false,
        nametag = true,
        tracer = false,
		color = { 255, 255, 255 },
		distance_limit = 5000,
		entries = {
			["Coal"] = true,
			["Copper"] = true,
			["Zinc"] = true,
			["Iron"] = true,
			["Silver"] = true,
			["Gold"] = true,
			["Limestone"] = true,
			["Quartz"] = true,
			["ZincVein"] = true,
			["SilverVein"] = true,
			["GoldVein"] = true,
			["CoalVein"] = true,
			["CopperVein"] = true,
			["IronVein"] = true,
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
	ores = tabs.ores:AddMiddleGroupbox("Mining ESP"),
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
for i, animalTab in pairs(config.animals.entries) do
	local animalType = animalTab.AnimalType
	local animalEnabled = animalTab.Enabled
	hunting[animalType.."_enabled"] = groupboxes.hunting
		:AddToggle({
			Default = animalEnabled,
			Text = animalType.." ESP Enabled",
		})

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
local region_prefix = "REGION_"
local health_value_name = "Health"
local trees_folder_name = "Trees"
local vegitation_folder_name = "Vegitation"
local tree_info_foldeer_name = "TreeInfo"

local workspace_interactables = dx9.FindFirstChild(workspace, "WORKSPACE_Interactables")
local mining_interactables = nil
local ore_deposits_interactables = nil
if workspace_interactables then
	mining_interactables = dx9.FindFirstChild(workspace_interactables, "Mining")
	if mining_interactables then
		ore_deposits_interactables = dx9.FindFirstChild(mining_interactables, "OreDeposits")
	end
end

local workspace_entities = dx9.FindFirstChild(workspace, "WORKSPACE_Entities")
local animal_entities = dx9.FindFirstChild(workspace_entities, "Animals")
local npc_entitiees = dx9.FindFirstChild(workspace_entities, "NPCs")
local player_entities = dx9.FindFirstChild(workspace_entities, "Players")

if not workspace_entities or not player_entities then
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
            if character then
                local root = dx9.FindFirstChild(character, "HumanoidRootPart")
                local humanoid = dx9.FindFirstChild(character, "Humanoid")

                if root and humanoid then
					if teamName == "Outlaws" or teamName == "Lawmen" or teamName == "Citizens" then
						local got_distance = get_distance(dx9.GetPosition(my_root), dx9.GetPosition(root))
						if got_distance < players.distance_limit then
							lib_esp.draw({
								target = character,
								color = playerColor, --players.color,
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
			for i, animalTab in pairs(config.animals.entries) do
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
				if root and healthNumber then
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
