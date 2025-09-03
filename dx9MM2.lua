--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

Config = _G.Config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
		LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
	};
    settings = {
		menu_toggle_keybind = "[F2]";
		
        maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;
        cache_cleanup_timer = 3;

		master_esp_enabled = true;
    	box_type = 1; -- 1 = "Corners", 2 = "2D Box", 3 = "3D Box"
    	tracer_type = 1; -- 1= "Near-Bottom", 2 = "Bottom", 3 = "Top", 4 = "Mouse"
    };
    players = {
        distance = true;
        nametag = true;
        distance_limit = 300;

        everyone_else_enabled = true;
        sheriff_enabled = true;
        murderer_enabled = true;

        everyone_else_tracer = false;
        sheriff_tracer = false;
        murderer_tracer = false;
    };
    dropped_guns = {
        --esp
        distance = true;
        nametag = true;
        enabled = true;
        tracer = false;
        distance_limit = 9999;
        rainbow = false;
        color = {50, 255, 255};
        --notify
        notify = true;
        --auto tp
        auto_tp = true;
    };
    gun_aimbot = {
        enabled = true;
		target_part = 1; -- 1 = "Head", 2 = "HumanoidRootPart"
        first_person_smoothness = 1;
        first_person_sensitivity = 1;
		third_person_vertical_smoothness = 1;
        third_person_horizontal_smoothness = 1;
    };
};
if _G.Config == nil then
	_G.Config = Config
	Config = _G.Config
end

if _G.averageHz == nil then
	_G.averageHz = 0
end

if _G.averageSec == nil then
	_G.averageSec = 0
end

if _G.clearedConsole == nil then
	_G.clearedConsole = false
end

if _G.consoleEnabled == nil then
	_G.consoleEnabled = false
end

if _G.clearedConsole == true then
	_G.clearedConsole = false
end

if _G.lastElapsedCycleTimesCache == nil then
	_G.lastElapsedCycleTimesCache = {}
elseif _G.lastElapsedCycleTimesCache ~= nil then
	local cache_entries = #_G.lastElapsedCycleTimesCache
	if cache_entries >= 1 then
		local sum = 0
		for index, elapsedCycleTime in ipairs(_G.lastElapsedCycleTimesCache) do
			sum = sum + elapsedCycleTime
		end
		local averageSeconds = sum / cache_entries
		local Sec_precision = 10 ^ Config.settings.Sec_precision
		local flooredSec = math.floor(averageSeconds * Sec_precision) / Sec_precision
		_G.averageSec = flooredSec or 0
		if averageSeconds > 0 and averageSeconds < math.huge then
			local averageHertz = 1 / averageSeconds
			local Hz_precision = 10 ^ Config.settings.Hz_precision
			local flooredHertz = math.floor(averageHertz * Hz_precision) / Hz_precision
			_G.averageHz = flooredHertz or 0
		else
			_G.averageHz = 0
		end
	end
end

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "Murder Mystery 2 | dx9ware | By @Brycki";
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

Tabs = {}
Tabs.debug = Interface:AddTab("Debug")
Tabs.esps = Interface:AddTab("ESPs")
Tabs.guns = Interface:AddTab("Guns")

if Lib_ui.FirstRun then
    Tabs.esps:Focus()
end

Groupboxes = {}
Groupboxes.debug = Tabs.debug:AddMiddleGroupbox("Debug")
Groupboxes.dropped_guns = Tabs.guns:AddMiddleGroupbox("Dropped Guns")
Groupboxes.aimbot = Tabs.guns:AddMiddleGroupbox("Aimbot")
Groupboxes.master_esp = Tabs.esps:AddMiddleGroupbox("Master")
Groupboxes.murderer_esp = Tabs.esps:AddMiddleGroupbox("Murderer")
Groupboxes.sheriff_esp = Tabs.esps:AddMiddleGroupbox("Sheriff")
Groupboxes.everyone_else_esp = Tabs.esps:AddMiddleGroupbox("Everyone Else")

Debugging = {}
Debugging.console = Groupboxes.debug:AddToggle({
    Default = false;
    Text = "Console Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Debug] Enabled Console" or "[Debug] Disabled Console", 1)
    if value then
        _G.consoleEnabled = true
        dx9.ClearConsole()
        dx9.ShowConsole(true)
    else
        _G.consoleEnabled = false
        dx9.ClearConsole()
        dx9.ShowConsole(false)
    end
end)
Debugging.sec = Groupboxes.debug:AddLabel("Avg. Program Cycle: ".._G.averageSec.." s")
Debugging.hz = Groupboxes.debug:AddLabel("Avg. Program Cycle: ".._G.averageHz.." Hz")
Debugging.clock = Groupboxes.debug:AddLabel("Clock: "..os.clock())
Debugging.resize_keybind = Groupboxes.debug:AddKeybindButton({
    Index = "ResizeWindowKeybindButton";
    Text = "Resize Window Keybind: [F3]";
    Default = "[F3]";
})
Debugging.resize_keybind = Debugging.resize_keybind:OnChanged(function(newKey)
    local oldKey = Debugging.resize_keybind.Key
    Debugging.resize_keybind:SetText("Resize Window Keybind: "..tostring(newKey))
    lib_ui:Notify("Resize Window Keybind changed from '"..tostring(oldKey).."' to '"..tostring(newKey).."'", 1)
end)
Debugging.resize = Groupboxes.debug:AddButton("Resize Window", function()
    if Interface.Active then
        Interface.Size = {300, 300}
        Lib_ui:Notify("Reset Window Size to the minimum", 1)
    end
end)
Debugging.resize:ConnectKeybindButton(Debugging.resize_keybind)

Dropped_guns = {}
----UNFINISHED
Dropped_guns.notify = Groupboxes.dropped_guns:AddToggle({
    Default = Config.dropped_guns.tracer;
    Text = "Notify";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Dropped Gun Notify] Enabled" or "[Dropped Gun Notify] Disabled", 1)
end)
Dropped_guns.auto_tp = Groupboxes.dropped_guns:AddToggle({
    Default = Config.dropped_guns.tracer;
    Text = "Auto Pickup";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Dropped Gun Auto Pickup] Enabled" or "[Dropped Gun Auto Pickup] Disabled", 1)
end)
----FINISHED
Dropped_guns.enabled = Groupboxes.dropped_guns:AddToggle({
    Default = Config.dropped_guns.enabled;
    Text = "ESP";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Dropped Gun ESP] Enabled" or "[Dropped Gun ESP] Disabled", 1)
end)
Dropped_guns.tracer = Groupboxes.dropped_guns:AddToggle({
    Default = Config.dropped_guns.tracer;
    Text = "Tracer";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Dropped Gun Tracer] Enabled" or "[Dropped Gun Tracer] Disabled", 1)
end)
Dropped_guns.distance = Groupboxes.dropped_guns:AddToggle({
    Default = Config.dropped_guns.distance;
    Text = "Distance";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Dropped Gun ESP] Shown Distance" or "[Dropped Gun ESP] Hid Distance", 1)
end)
Dropped_guns.nametag = Groupboxes.dropped_guns:AddToggle({
    Default = Config.dropped_guns.nametag;
    Text = "Nametag";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Dropped Gun ESP] Shown Nametag" or "[Dropped Gun ESP] Hid Nametag", 1)
end)
Dropped_guns.distance_limit = Groupboxes.dropped_guns:AddSlider({
    Default = Config.dropped_guns.distance_limit;
    Text = "Dropped Gun ESP Distance Limit";
    Min = 0;
    Max = 1999;
    Rounding = 0;
})
Dropped_guns.rainbow = Groupboxes.dropped_guns:AddToggle({
    Default = Config.dropped_guns.rainbow;
    Text = "Rainbow Dropped Gun";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Rainbow Dropped Gun] Enabled" or "[Rainbow Dropped Gun] Disabled", 1)
end)
--Lib_ui.CurrentRainbowColor
if not Dropped_guns.rainbow.Value then
    Dropped_guns.color = Groupboxes.dropped_guns:AddColorPicker({
        Default = Config.dropped_guns.color;
        Text = "Color";
    });
end

Aimbot = {}
Aimbot.enabled = Groupboxes.aimbot:AddToggle({
    Default = Config.gun_aimbot.enabled;
    Text = "Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Gun Aimbot] Enabled" or "[Gun Aimbot] Disabled", 1)
    if not value then
        _G.aimbot_target_address = nil
        _G.aimbot_target_screen_pos = nil
    end
end)
Aimbot.part = Groupboxes.aimbot:AddDropdown({
    Text = "Target Part";
    Default = Config.gun_aimbot.target_part;
    Values = { "Head", "HumanoidRootPart" };
}):OnChanged(function(value)
    Lib_ui:Notify("[Gun Aimbot] Target Part: " .. value, 1)
end)
Aimbot.first_person_smoothness = Groupboxes.aimbot:AddSlider({
    Default = Config.gun_aimbot.first_person_smoothness;
    Text = "First Person Smoothness";
    Min = 1;
    Max = 50;
    Rounding = 0;
})
Aimbot.first_person_sensitivity = Groupboxes.aimbot:AddSlider({
    Default = Config.gun_aimbot.first_person_sensitivity;
    Text = "First Person Sensitivity";
    Min = 1;
    Max = 50;
    Rounding = 0;
})
Aimbot.third_person_vertical_smoothness = Groupboxes.aimbot:AddSlider({
    Default = Config.gun_aimbot.third_person_vertical_smoothness;
    Text = "Third Person Vertical Smoothness";
    Min = 1;
    Max = 50;
    Rounding = 0;
})
Aimbot.third_person_horizontal_smoothness = Groupboxes.aimbot:AddSlider({
    Default = Config.gun_aimbot.third_person_horizontal_smoothness;
    Text = "Third Person Horizontal Smoothness";
    Min = 1;
    Max = 50;
    Rounding = 0;
})
local aimbot_target_address = _G.aimbot_target_address or nil
local aimbot_target_screen_pos = _G.aimbot_target_screen_pos or nil

Master_esp = {}
Master_esp.enabled = Groupboxes.master_esp:AddToggle({
    Default = Config.settings.master_esp_enabled;
    Text = "Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Master ESP] Enabled" or "[Master ESP] Disabled", 1)
end)
Master_esp.box_type = Groupboxes.master_esp:AddDropdown({
    Text = "Box Type";
    Default = Config.settings.box_type;
    Values = { "Corners", "2D Box", "3D Box" };
}):OnChanged(function(value)
    Lib_ui:Notify("[Master ESP] Box Type: " .. value, 1)
end)
Master_esp.tracer_type = Groupboxes.master_esp:AddDropdown({
    Text = "Tracer Type";
    Default = Config.settings.tracer_type;
    Values = { "Near-Bottom", "Bottom", "Top", "Mouse" };
}):OnChanged(function(value)
    Lib_ui:Notify("[Master ESP] Tracer Type: " .. value, 1)
end)
Master_esp.player_distance = Groupboxes.master_esp:AddToggle({
    Default = Config.players.distance;
    Text = "Player Distance";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Master Player ESP] Shown Distance" or "[Master Player ESP] Hid Distance", 1)
end)
Master_esp.player_nametag = Groupboxes.master_esp:AddToggle({
    Default = Config.players.nametag;
    Text = "Player Nametag";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Master Player ESP] Shown Nametag" or "[Master Player ESP] Hid Nametag", 1)
end)
Master_esp.player_distance_limit = Groupboxes.master_esp:AddSlider({
    Default = Config.players.distance_limit;
    Text = "Player ESP Distance Limit";
    Min = 0;
    Max = 9999;
    Rounding = 0;
})

Murderer_esp = {}
Murderer_esp.enabled = Groupboxes.murderer_esp:AddToggle({
    Default = Config.players.murderer_enabled;
    Text = "Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Murderer ESP] Enabled" or "[Murderer ESP] Disabled", 1)
end)
Murderer_esp.tracer = Groupboxes.murderer_esp:AddToggle({
    Default = Config.players.murderer_tracer;
    Text = "Tracer";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Murderer ESP] Enabled Tracer" or "[Murderer ESP] Disabled Tracer", 1)
end)

Sheriff_esp = {}
Sheriff_esp.enabled = Groupboxes.sheriff_esp:AddToggle({
    Default = Config.players.sheriff_enabled;
    Text = "Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Sheriff ESP] Enabled" or "[Sheriff ESP] Disabled", 1)
end)
Sheriff_esp.tracer = Groupboxes.sheriff_esp:AddToggle({
    Default = Config.players.sheriff_tracer;
    Text = "Tracer";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Sheriff Tracer] Enabled" or "[Sheriff Tracer] Disabled", 1)
end)

Everyone_else_esp = {}
Everyone_else_esp.enabled = Groupboxes.everyone_else_esp:AddToggle({
    Default = Config.players.everyone_else_enabled;
    Text = "Enabled";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Everyone Else ESP] Enabled" or "[Everyone Else ESP] Disabled", 1)
end)
Everyone_else_esp.tracer = Groupboxes.everyone_else_esp:AddToggle({
    Default = Config.players.everyone_else_tracer;
    Text = "Tracer";
}):OnChanged(function(value)
    Lib_ui:Notify(value and "[Everyone Else ESP] Enabled Tracer" or "[Everyone Else ESP] Disabled Tracer", 1)
end)

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
			table = { "Closest to Mouse", "Distance" }
		elseif type == "target_part" then
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

Current_target_part = _G.Get_Index("target_part", Aimbot.part.Value)
Current_tracer_type = _G.Get_Index("tracer", Master_esp.tracer_type.Value)
Current_box_type = _G.Get_Index("box", Master_esp.box_type.Value)

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

Murderer_Player = nil
Murderer_Backpack = nil
Murderer_Character = nil
Sheriff_Player = nil
Sheriff_Backpack = nil
Sheriff_Character = nil

if _G.PlayerTask == nil then
	_G.PlayerTask = function()
        for _, player in pairs(dx9.GetChildren(Services.players)) do
            local playerName = dx9.GetName(player)
            if playerName and playerName ~= Local_player_name then
                local backpack = dx9.FindFirstChild(player, "Backpack")
                local gun = nil
                local knife = nil
                if backpack then
                    gun = dx9.FindFirstChild(backpack, "Gun")
                    knife = dx9.FindFirstChild(backpack, "Knife")
                    if gun == 0 then
                        gun = nil
                    end
                    if knife == 0 then
                        knife = nil
                    end
                end
                local character = dx9.FindFirstChild(Workspace, playerName)
                if character and character ~= 0 then
                    if not gun then
                        gun = dx9.FindFirstChild(character, "Gun")
                        if gun == 0 then
                            gun = nil
                        end
                    end
                    if not knife then
                       knife = dx9.FindFirstChild(character, "Knife")
                        if knife == 0 then
                            knife = nil
                        end
                    end
                    local root = dx9.FindFirstChild(character, "HumanoidRootPart")
                    local head = dx9.FindFirstChild(character, "Head")
                    local humanoid = dx9.FindFirstChild(character, "Humanoid")

                    if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
                        local health = dx9.GetHealth(humanoid) or nil
                        if health ~= nil then
                            health = math.floor(health)
                        end
                        if health ~= nil and health > 0 then
                            local My_root_pos = dx9.GetPosition(My_root)
                            local root_pos = dx9.GetPosition(root)
                            local head_pos = dx9.GetPosition(head)
                            local root_distance = _G.Get_Distance(My_root_pos, root_pos)
                            local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                            local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

                            local team_color = (knife and {255, 0, 0}) or (gun and {0, 0, 255}) or {255, 255, 255}
                            local team = (knife and Murderer_esp) or (gun and Sheriff_esp) or Everyone_else_esp

                            if Master_esp.enabled.Value and team.enabled.Value then
                                if _G.IsOnScreen(head_screen_pos) or _G.IsOnScreen(root_screen_pos) then
                                    if root_distance < Master_esp.player_distance_limit.Value then
                                        Lib_esp.draw({
                                            target = character;
                                            color = team_color;
                                            healthbar = false;
                                            nametag = Master_esp.player_nametag.Value;
                                            distance = Master_esp.player_distance.Value;
                                            custom_nametag = playerName;
                                            custom_distance = tostring(root_distance);
                                            tracer = team.tracer.Value;
                                            tracer_type = Current_tracer_type;
                                            box_type = Current_box_type;
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
                if knife then
                    Murderer_Player = player
                    Murderer_Backpack = backpack
                    Murderer_Character = character
                elseif gun then
                    Sheriff_Player = player
                    Sheriff_Backpack = backpack
                    Sheriff_Character = character
                end
            end
        end
    end
end
if _G.PlayerTask then
	_G.PlayerTask()
end

if _G.AimbotTask == nil then
    _G.AimbotTask = function()
        if Aimbot.enabled.Value then
            if Sheriff_Player ~= nil and Sheriff_Player ~= 0 and Sheriff_Player == Local_player and Sheriff_Character ~= nil and Sheriff_Character ~= 0 and Sheriff_Character == My_character then
                if Murderer_Character ~= nil and Murderer_Character ~= 0 then
                    local root = dx9.FindFirstChild(Murderer_Character, "HumanoidRootPart")
                    local head = dx9.FindFirstChild(Murderer_Character, "Head")
                    local humanoid = dx9.FindFirstChild(Murderer_Character, "Humanoid")
                    if root and root ~= 0 and humanoid and humanoid ~= 0 and head and head ~= 0 then
                        local health = dx9.GetHealth(humanoid) or nil
                        if health ~= nil then
                            health = math.floor(health)
                        end
                        if health ~= nil and health > 0 then
                            local guntool = dx9.FindFirstChild(My_character, "Gun")
                            if guntool ~= nil and guntool ~= 0 then
                                local My_root_pos = dx9.GetPosition(My_root)
                                local root_pos = dx9.GetPosition(root)
                                local head_pos = dx9.GetPosition(head)
                                local root_distance = _G.Get_Distance(My_root_pos, root_pos)
                                local root_screen_pos = dx9.WorldToScreen({root_pos.x, root_pos.y, root_pos.z})
                                local head_screen_pos = dx9.WorldToScreen({head_pos.x, head_pos.y, head_pos.z})

                                local screen_pos = nil
                                if Current_target_part == 1 then
                                    screen_pos = head_screen_pos
                                elseif Current_target_part == 2 then
                                    screen_pos = root_screen_pos
                                end

                                if _G.IsOnScreen(head_screen_pos) or _G.IsOnScreen(root_screen_pos) then
                                    aimbot_target_screen_pos = screen_pos

                                    local Mouse_distance = _G.Get_Distance_From_Mouse(screen_pos)
                                    local aimbot_range = 9999 --dx9.GetAimbotValue("range")
                                    local aimbot_fov = dx9.GetAimbotValue("fov")
                                    if Mouse_distance and Mouse_distance <= aimbot_fov and root_distance <= aimbot_range then
                                        local Mouse_moved = false
                                        if Mouse_moved == false then
                                            dx9.DrawCircle({aimbot_target_screen_pos.x, aimbot_target_screen_pos.y}, {255, 255, 255}, 15)
                                            dx9.SetAimbotValue("x", 0)
                                            dx9.SetAimbotValue("y", 0)
                                            dx9.SetAimbotValue("z", 0)
                                            dx9.FirstPersonAim({
                                                aimbot_target_screen_pos.x + Screen_size.width/2,
                                                aimbot_target_screen_pos.y + Screen_size.height/2
                                            }, Aimbot.first_person_smoothness.Value, Aimbot.first_person_sensitivity.Value)
                                            if not dx9.isRightClickHeld() then
                                                dx9.ThirdPersonAim({
                                                    aimbot_target_screen_pos.x,
                                                    aimbot_target_screen_pos.y
                                                }, Aimbot.third_person_horizontal_smoothness.Value, Aimbot.third_person_vertical_smoothness.Value)
                                            end
                                            Mouse_moved = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            aimbot_target_screen_pos = nil
		end
        _G.aimbot_target_screen_pos = aimbot_target_screen_pos
    end
end
if _G.AimbotTask then
    _G.AimbotTask()
end

if _G.GunDroppedFlip == nil then
    _G.GunDroppedFlip = false
end
if _G.DroppedGunTask == nil then
	_G.DroppedGunTask = function()
        local gundrop = nil
        if Workspace ~= nil and Workspace ~= 0 then
            local Workspace_children = dx9.GetChildren(Workspace)
            for i,v in ipairs(Workspace_children) do
                if dx9.GetType(v) == "Model" or dx9.GetType(v) == "Folder" then
                    local possible_gun_drop = dx9.FindFirstChild(v, "GunDrop")
                    if possible_gun_drop ~= nil and possible_gun_drop ~= 0 then
                        if dx9.GetType(possible_gun_drop) == "Part" then
                            gundrop = possible_gun_drop
                            break
                        end
                    end
                end
            end
        end
        if gundrop ~= nil then
            if _G.GunDroppedFlip == false then
                _G.GunDroppedFlip = true
                if Dropped_guns.notify.Value then
                    Lib_ui:Notify("Gun Dropped!", 1)
                end
            end
            local gunpos = dx9.GetPosition(gundrop)

            if Dropped_guns.auto_tp.Value then
                dx9.Teleport(My_character, {gunpos.x, gunpos.y, gunpos.z})
            end

            local My_root_pos = dx9.GetPosition(My_root)
            local root_distance = _G.Get_Distance(My_root_pos, gunpos)
            local screen_pos = dx9.WorldToScreen({gunpos.x, gunpos.y, gunpos.z})
            if Master_esp.enabled.Value and Dropped_guns.enabled.Value then
                if root_distance < Dropped_guns.distance_limit.Value then
                    if _G.IsOnScreen(screen_pos) then
                        Lib_esp.draw({
                            esp_type = "misc";
                            target = gundrop;
                            color = Dropped_guns.rainbow.Value and Lib_ui.CurrentRainbowColor or Dropped_guns.color.Value;
                            healthbar = false;
                            nametag = Dropped_guns.nametag.Value;
                            custom_nametag = "GunDrop";
                            distance = Dropped_guns.distance.Value;
                            custom_distance = ""..root_distance;
                            tracer = Dropped_guns.tracer.Value;
                            tracer_type = Current_tracer_type;
                            box_type = Current_box_type;
                        })
                    end
                end
            end
        else
            _G.GunDroppedFlip = false
        end
	end
end
if _G.DroppedGunTask then
	_G.DroppedGunTask()
end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= Config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end