local startTime = os.clock()
--indent size 4

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/B0NBunny/DXLibUI/refs/heads/main/main.lua";
	};
	settings = {
		menu_toggle_keybind = "[F3]";

		game = 1; -- 1 = "Blade Ball", 2 = "Death Ball"
		fps = 4; -- 1 = 60, 2 = 120, 3 = 144, 4 = 240

		maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;

		autoparry_enabled = true;
		autoparry_keybind = "[F4]";
		no_double_clicks_enabled = true;
		must_have_highlight_enabled = false;
		minimum_distance_enabled = false;
		maximum_reach_enabled = true;
		maximum_eta_enabled = true;
		minimum_distance = 0.5;
		maximum_reach = 60;
		maximum_eta = 0.55;
		click_cooldown = 0.55;
	};
}
if _G.config == nil then
	_G.config = config
	config = _G.config
end

if _G.averageHz == nil then
	_G.averageHz = 0
end

if _G.averageSec == nil then
	_G.averageSec = 0
end

------
if _G.clickedForThisHighlight == nil then
	_G.clickedForThisHighlight = false
end

if _G.highlightExists == nil then
	_G.highlightExists = false
end

if _G.highlightRemoved == nil then
	_G.highlightRemoved = false
end
------

if _G.clearedConsole == nil then
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
		local Sec_precision = 10 ^ config.settings.Sec_precision
		local flooredSec = math.floor(averageSeconds * Sec_precision) / Sec_precision
		_G.averageSec = flooredSec or 0
		if averageSeconds > 0 and averageSeconds < math.huge then
			local averageHertz = 1 / averageSeconds
			local Hz_precision = 10 ^ config.settings.Hz_precision
			local flooredHertz = math.floor(averageHertz * Hz_precision) / Hz_precision
			_G.averageHz = flooredHertz or 0
		else
			_G.averageHz = 0
		end
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
game_settings.fps = groupboxes.game_settings:AddDropdown({
		Text = "Your Game's FPS";
		Default = config.settings.fps;
		Values = { "60", "120", "144", "240" };
	})
	:OnChanged(function(value)
		lib_ui:Notify("[settings] FPS: " .. value, 1)
	end)
game_settings.sec = groupboxes.game_settings
	:AddLabel("Avg. Program Cycle: ".._G.averageSec.." s")
game_settings.hz = groupboxes.game_settings
	:AddLabel("Avg. Program Cycle: ".._G.averageHz.." Hz")

autoparry_settings = {}
autoparry_settings.enabled = groupboxes.autoparry_settings
		:AddToggle({
			Default = config.settings.autoparry_enabled;
			Text = "Auto Parry Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Auto Parry" or "[settings] Disabled Auto Parry", 1)
		end)
autoparry_settings.no_double_clicks_enabled = groupboxes.autoparry_settings
		:AddToggle({
			Default = config.settings.no_double_clicks_enabled;
			Text = "No Double Clicks Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled No Double Clicks" or "[settings] Disabled No Double Clicks", 1)
		end)
autoparry_settings.must_have_highlight_enabled = groupboxes.autoparry_settings
		:AddToggle({
			Default = config.settings.must_have_highlight_enabled;
			Text = "Must Have Highlight Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Must Have Highlight" or "[settings] Disabled Must Have Highlight", 1)
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
		Max = 100;
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
		Min = 0;
		Max = 1.25;
		Rounding = 2;
	}):AddTooltip("The maximum amount of estimated seconds away the ball is from you at which you will parry")
groupboxes.autoparry_settings:AddBorder()
autoparry_settings.click_cooldown = groupboxes.autoparry_settings:AddSlider({
		Default = config.settings.click_cooldown;
		Text = "Click Cooldown";
		Min = 0; --(1/game_settings.fps.Value);
		Max = 0.55;
		Rounding = 3;
	}):AddTooltip("The delay before you can auto-parry again")

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
		elseif type == "fps" then
			table = { "60", "120", "144", "240" }
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
local_player_table = dx9.get_localplayer()
current_game = _G.Get_Index("game", game_settings.game.Value)
current_fps = tonumber(_G.Get_Index("fps", game_settings.fps.Value))

if local_player == nil then
	for _, player in pairs(dx9.GetChildren(services.players)) do
		local pgui = dx9.FindFirstChild(player, "PlayerGui")
		if pgui ~= nil and pgui ~= 0 then
			local_player = player
			break
		end
	end
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

if _G.devmode == nil then
	_G.devmode = false
end

if local_player_name == "B0NBunny" then
	game_settings.dev = groupboxes.game_settings
		:AddToggle({
			Default = false;
			Text = "Dev Mode Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Dev Mode" or "[settings] Disabled Dev Mode", 1)
			if value then
				_G.devmode = true
				dx9.ClearConsole()
				dx9.ShowConsole(true)
			else
				_G.devmode = false
				dx9.ClearConsole()
				dx9.ShowConsole(false)
			end
		end)
end

my_player = dx9.FindFirstChild(services.players, local_player_name)
my_character = nil
my_root = nil

if _G.clearedConsole == true then
	_G.clearedConsole = false
end

if _G.clearCooldown == nil then
	_G.clearCooldown = function()
		if _G.clearedConsole == false then
			_G.clearedConsole = true
			if _G.devmode then
				print("clear cooldown")
			end
			--dx9.ClearConsole()
		end
		_G.nextParryTime = nil
	end
end

if my_player ~= nil and my_player ~= 0 then
	if autoparry_settings.enabled.Value then
		if current_game == 1 then
			--Blade Ball
			local AliveFolder = dx9.FindFirstChild(workspace, "Alive")
			local DeadFolder = dx9.FindFirstChild(workspace, "Dead")

			local InTraining = false

			if AliveFolder ~= nil and AliveFolder ~= 0 then
				my_character = dx9.FindFirstChild(AliveFolder, local_player_name)
			end

			if my_character == nil or my_character == 0 then
				if DeadFolder ~= nil and DeadFolder ~= 0 then
					my_character = dx9.FindFirstChild(DeadFolder, local_player_name)
					InTraining = true
				end
			end

			local lastHighlight = _G.highlight
			local newHighlight = nil
			local lastHighlightExisted = lastHighlight ~= nil and lastHighlight ~= 0 and true or false
			local newHighlightExists = false
			local characterExists = my_character ~= nil and my_character ~= 0 and true or false
			local rootExists = false
			local ballsFolderExists = false

			local passedBallChecks = false
			local passedHighlightCheck1 = false
			local passedClickChecks = false

			if characterExists then
				my_root = dx9.FindFirstChild(my_character, "HumanoidRootPart")
			end
			
			rootExists = my_root and my_root ~= 0 and true or false

			if characterExists and rootExists then
				newHighlight = dx9.FindFirstChild(my_character, "Highlight")
				newHighlightExists = newHighlight ~= nil and newHighlight ~= 0 and true or false
				if newHighlight ~= lastHighlight then
					print("\nlastHighlight: "..tostring(lastHighlight).."\nnewHighlight: "..tostring(newHighlight))
					_G.highlight = newHighlight
				end
				if autoparry_settings.no_double_clicks_enabled.Value then
					if lastHighlightExisted and newHighlightExists then
						if _G.highlightRemoved == true then
							_G.highlightRemoved = nil
						end
						if lastHighlight ~= newHighlight then
							print("swap Highlight")
							_G.clearCooldown()
						end
					elseif newHighlightExists then
						if _G.highlightRemoved == true then
							_G.highlightRemoved = nil
						end
						print("brand new Highlight")
						_G.clearCooldown()
					elseif autoparry_settings.must_have_highlight_enabled.Value and lastHighlightExisted then
						print("removed Highlight")
						if _G.highlightRemoved ~= true then
							_G.highlightRemoved = true
							_G.clearCooldown()
						end
					end
				end

				local Balls = InTraining == false and dx9.FindFirstChild(workspace, "Balls") or InTraining == true and dx9.FindFirstChild(workspace, "TrainingBalls")
				ballsFolderExists = Balls ~= nil and Balls ~= 0 and true or false
				if ballsFolderExists then
					local balls = {}
					
					for i,v in pairs(dx9.GetChildren(Balls)) do
						local name = dx9.GetName(v)
						local vtype = dx9.GetType(v)
						if vtype == "Part" then
							local t = balls[name]
							if not t then
								t = {}
								balls[name] = t
							end

							local ballvel = dx9.GetVelocity(v)
							local spd = math.sqrt(ballvel.x^2 + ballvel.y^2 + ballvel.z^2)

							if t.spd == nil or t.spd == 0 or spd > t.spd then
								t.name = name
								t.ballvel = ballvel
								t.spd = spd
								t.ball = v
							end
						end
					end

					for i,t in pairs(balls) do
						if not passedBallChecks then
							local name = t.name
							local v = t.ball
							local ballvel = t.ballvel
							local spd = t.spd

							local lpos = dx9.GetPosition(my_root) or local_player_table.Position
							local ballpos = dx9.GetPosition(v)
							local toPlayerFromBallPos = {
								x = lpos.x - ballpos.x;
								y = lpos.y - ballpos.y;
								z = lpos.z - ballpos.z;
							}
							local dist = _G.Get_Distance(lpos, ballpos)
							local unitToPlayerFromBallPos = {
								x = toPlayerFromBallPos.x / dist;
								y = toPlayerFromBallPos.y / dist;
								z = toPlayerFromBallPos.z / dist;
							}
							
							if spd < 0.01 then
								spd = 0.01
							end
							local unitBallvel = {
								x = ballvel.x / spd;
								y = ballvel.y / spd;
								z = ballvel.z / spd;
							}
							--local dot = toPlayer.x * ballvel.x + toPlayer.y * ballvel.y + toPlayer.z + ballvel.z
							local dot = unitToPlayerFromBallPos.x * unitBallvel.x + unitToPlayerFromBallPos.y * unitBallvel.y + unitToPlayerFromBallPos.z * unitBallvel.z

							local eta = dist / spd
							local predictedPos = {
								x = ballpos.x + ballvel.x * (1/current_fps);
								y = ballpos.y + ballvel.y * (1/current_fps);
								z = ballpos.z + ballvel.z * (1/current_fps);
							}
							local isFrozenThreat = spd < 5
							
							local isFacingMe = dot > 0
						
							local function attemptClick()
								if _G.devmode then
									--print("["..name.."] | frozen: "..tostring(isFrozenThreat).." | dist: "..dist.." | spd: "..spd.." | eta:"..eta.." | dot: "..dot)
								end
								passedBallChecks = true
							end

							if isFrozenThreat and dist <= 10 then
								if autoparry_settings.maximum_reach_enabled.Value ~= true or autoparry_settings.maximum_reach_enabled.Value and dist <= autoparry_settings.maximum_reach.Value then
									if _G.devmode then
										--print("1")
									end
									attemptClick()
								end
							elseif isFacingMe then
								if autoparry_settings.minimum_distance_enabled.Value and dist <= autoparry_settings.minimum_distance.Value then
									if _G.devmode then
										--print("2")
									end
									attemptClick()
								elseif autoparry_settings.maximum_eta_enabled.Value or autoparry_settings.maximum_reach_enabled.Value then
									if autoparry_settings.maximum_reach_enabled.Value ~= true or autoparry_settings.maximum_reach_enabled.Value and dist <= autoparry_settings.maximum_reach.Value then
										if autoparry_settings.maximum_eta_enabled.Value ~= true or autoparry_settings.maximum_eta_enabled.Value and eta <= autoparry_settings.maximum_eta.Value then
											if _G.devmode then
												--print("3")
											end
											attemptClick()
										end
									end
								end
							end
						end
					end

					if passedBallChecks then
						print("Attempt Click @ "..os.clock())
						if autoparry_settings.must_have_highlight_enabled.Value then
							if newHighlightExists then
								passedHighlightCheck1 = true
							end
						else
							passedHighlightCheck1 = true
						end

						if passedHighlightCheck1 then
							if _G.nextParryTime == nil or _G.nextParryTime ~= nil and _G.nextParryTime < os.clock() then
								passedClickChecks = true
							elseif _G.devmode then
								print(_G.nextParryTime-os.clock().." seconds left")
							end
						end
						
						if passedClickChecks then
							_G.nextParryTime = os.clock() + autoparry_settings.click_cooldown.Value
							--if (autoparry_settings.click_cooldown.Value > 0) then
								--_G.nextParryTime = os.clock() + autoparry_settings.click_cooldown.Value

								--if _G.devmode then
									--print("nextParryTime: ".._G.nextParryTime)
								--end
							--end
							if _G.devmode then
								print("Click @ "..os.clock())
							end
							dx9.Mouse1Click()
						end
					end
				end
			end
		end
	end
end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end