local startTime = os.clock();
--indent size 4
dx9.ShowConsole(true);

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/B0NBunny/DXLibUI/refs/heads/main/main.lua";
	};
	settings = {
		menu_toggle_keybind = "[F3]";
		autoparry_enabled = true;
		autoparry_keybind = "[F4]";
		minimum_distance_enabled = false;
		maximum_reach_enabled = true;
		maximum_eta_enabled = true;
		minimum_distance = 4;
		maximum_reach = 40;
		maximum_eta = 0.55;
		simulation_rate = 1/60;
		maximum_Hz_Cache = 5;
		Hz_precision = 0;
		game = 1; -- 1 = "Blade Ball", 2 = "Death Ball"
	};
};
if _G.config == nil then
	_G.config = config
	config = _G.config
end

if _G.averageHz == nil then
	_G.averageHz = 0
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
		local averageElapsedTime = sum / cache_entries
		local averageHertz = 1 / averageElapsedTime
		local precision = 10 ^ config.settings.Hz_precision
		local flooredHertz = math.floor(averageHertz * precision) / precision
		_G.averageHz = flooredHertz or 0
	end
end

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

interface = lib_ui:CreateWindow({
	Title = "Ball Auto Parry | dx9ware | By @Brycki";
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

tabs = {}
tabs.settings = interface:AddTab("Settings")

groupboxes = {}
groupboxes.game_settings = tabs.settings:AddLeftGroupbox("Game")
groupboxes.autoparry_settings = tabs.settings:AddRightGroupbox("Auto Parry")

game_settings = {}
game_settings.game = groupboxes.game_settings
	:AddDropdown({
		Text = "Game";
		Default = config.settings.game;
		Values = { "Blade Ball", "Death Ball" };
	})
	:OnChanged(function(value)
		lib_ui:Notify("[settings] Game: " .. value, 1)
	end)
game_settings.hz = groupboxes.game_settings
	:AddLabel("Avg. Program Cycle: ".._G.averageHz.." Hz")

autoparry_settings = {}
autoparry_settings.enabled = groupboxes.autoparry_settings
		:AddToggle({
			Default = config.settings.autoparry_enabled;
			Text = "ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Auto Parry" or "[settings] Disabled Auto Parry", 1)
		end)
groupboxes.autoparry_settings:AddBorder()
autoparry_settings.minimum_distance_enabled = groupboxes.autoparry_settings
		:AddToggle({
			Default = config.settings.minimum_distance_enabled;
			Text = "Min. Distance Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Minimum Distance" or "[settings] Disabled Minimum Distance", 1)
		end)
autoparry_settings.minimum_distance = groupboxes.autoparry_settings:AddSlider({
		Default = config.settings.minimum_distance;
		Text = "Min. Distance";
		Min = 0;
		Max = 10;
		Rounding = 1;
	}):AddTooltip("The minimum distance at which you will always parry")
groupboxes.autoparry_settings:AddBorder()
autoparry_settings.maximum_reach_enabled = groupboxes.autoparry_settings
		:AddToggle({
			Default = config.settings.maximum_reach_enabled;
			Text = "Max. Reach Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Maximum Reach" or "[settings] Disabled Maximum Reach", 1)
		end)
autoparry_settings.maximum_reach = groupboxes.autoparry_settings:AddSlider({
		Default = config.settings.maximum_reach;
		Text = "Max. Reach";
		Min = 0;
		Max = 60;
		Rounding = 0;
	}):AddTooltip("The maximum distance that you can parry from")
groupboxes.autoparry_settings:AddBorder()
autoparry_settings.maximum_eta_enabled = groupboxes.autoparry_settings
		:AddToggle({
			Default = config.settings.maximum_eta_enabled;
			Text = "Max. Arrival Time Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Maximum Arrival Time" or "[settings] Disabled Maximum Arrival Time", 1)
		end)
autoparry_settings.maximum_eta = groupboxes.autoparry_settings:AddSlider({
		Default = config.settings.maximum_eta;
		Text = "Max. Arrival Time";
		Min = config.settings.simulation_rate;
		Max = 1.25;
		Rounding = 2;
	}):AddTooltip("The maximum amount of estimated seconds away the ball is from you at which you will parry")

if _G.Get_Distance == nil then
	_G.Get_Distance = function(v1, v2)
		local a = (v1.x - v2.x)
		local b = (v1.y - v2.y)
		local c = (v1.z - v2.z)

		return math.sqrt(a^2 + b^2 + c^2)
	end
end

if _G.Get_Index == nil then
	_G.Get_Index = function(type, value)
		local table = nil
		if type == "game" then
			table = { "Blade Ball", "Death Ball" }
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
local_player_table = nil
current_game = _G.Get_Index("game", game_settings.game.Value)

if local_player == nil then
	for _, player in pairs(dx9.GetChildren(services.players)) do
		local pgui = dx9.FindFirstChild(player, "PlayerGui")
		if pgui ~= nil and pgui ~= 0 then
			local_player = player
			break
		end
	end
end

if local_player == nil then
	local_player_table = dx9.get_localplayer()
end

function get_local_player_name()
	if dx9.GetType(local_player) == "Player" then
		return dx9.GetName(local_player)
	else
		local_player_table = dx9.get_localplayer()
		return local_player_table.Info.Name
	end
end

local_player_name = get_local_player_name()

my_player = dx9.FindFirstChild(services.players, local_player_name)
my_character = nil
my_root = nil

local PlayerCharacterFolder = nil
if current_game == 1 then
	PlayerCharacterFolder = dx9.FindFirstChild(workspace, "Alive")
end

if PlayerCharacterFolder ~= nil and PlayerCharacterFolder ~= 0 then
	if my_player ~= nil and my_player ~= 0 then
		my_character = dx9.FindFirstChild(PlayerCharacterFolder, local_player_name)
		if my_character ~= nil and my_character ~= 0 then
			my_root = dx9.FindFirstChild(my_character, "HumanoidRootPart")
			if autoparry_settings.enabled.Value then
				if current_game == 1 then
					--Blade Ball

					--disabling highlight check for now because its sometimes
					--absent which causes a delay
					--unfortunately dx9ware doesnt have access to Roblox Attributes
					--so i cant just use ball:GetAttribute("target")
					--like most bladeball auto parry scripts

					--local highlight = dx9.FindFirstChild(my_character, "Highlight")
					--if highlight and highlight ~= 0 then
						local Balls = dx9.FindFirstChild(workspace, "Balls")
						if Balls and Balls ~= 0 then
							for i,v in pairs(dx9.GetChildren(Balls)) do
								local ballpos = dx9.GetPosition(v)
								local vel = dx9.GetVelocity(v)
								local speed = math.sqrt(vel.x^2 + vel.y^2 + vel.z^2)
								print("spd: "..speed.." studs/second")

								local skip = false
								if speed == 0 or speed >= 10000 then
									skip = true
								end

								if not skip then
									local lpos = dx9.GetPosition(my_root) or local_player_table.Position
									local distance = _G.Get_Distance(lpos, ballpos)
									print("dist: "..distance.." studs")
									if autoparry_settings.minimum_distance_enabled.Value and distance <= autoparry_settings.minimum_distance.Value then
										dx9.Mouse1Click()
										break
									end

									local eta = distance / speed
									print("eta: "..eta.." seconds")
									if autoparry_settings.maximum_eta_enabled.Value or autoparry_settings.maximum_eta_enabled.Value then
										if not autoparry_settings.maximum_reach_enabled.Value or autoparry_settings.maximum_reach_enabled.Value and distance <= autoparry_settings.maximum_reach.Value then
											if not autoparry_settings.maximum_eta_enabled.Value or autoparry_settings.maximum_eta_enabled.Value and eta <= autoparry_settings.maximum_eta.Value then
												dx9.Mouse1Click()
												break
											end
										end
									end
								end
							end
						end
					--end

				end
			end
		end
	end
end

local endTime = os.clock();
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end