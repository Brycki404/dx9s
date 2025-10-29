--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

BallCache = _G.BallCache or {}
if _G.BallCache == nil then
	_G.BallCache = BallCache
	BallCache = _G.BallCache
end

Config = _G.Config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
	};
	settings = {
		menu_toggle_keybind = "[F2]";

		game = 1; -- 1 = "Blade Ball", 2 = "Death Ball"
		fps = 1; -- 1 = 60, 2 = 120, 3 = 144, 4 = 240

		maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;

		autoparry_enabled = true;
		autoparry_keybind = "[F4]";
		must_have_highlight_enabled = true;
		maximum_reach_enabled = true;
		maximum_eta_enabled = true;
		maximum_reach = 60;
		maximum_eta = 0.55;
		prediction_visualizer_enabled = true;
	};
}
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

if _G.clickedForThisHighlight == nil then
	_G.clickedForThisHighlight = false
end

if _G.highlightSwapped == nil then
	_G.highlightSwapped = false
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

Interface = Lib_ui:CreateWindow({
	Title = "Ball Auto Parry | dx9ware | By @Brycki";
	Size = { 500, 500 };
	Resizable = true;

	ToggleKey = Config.settings.menu_toggle_keybind;

	FooterToggle = true;
	FooterRGB = true;
	FontColor = { 255, 255, 255 };
	MainColor = { 25, 25, 25 };
	BackgroundColor = { 20, 20, 20 };
	AccentColor = { 255, 50, 255 };
	OutlineColor = { 40, 40, 40 };
})

Tabs = {}
Tabs.game = Interface:AddTab("Game")
Tabs.debugging = Interface:AddTab("Debugging")

Groupboxes = {}
Groupboxes.game_settings = Tabs.game:AddLeftGroupbox("Game Settings")
Groupboxes.autoparry_settings = Tabs.game:AddRightGroupbox("Auto Parry")
Groupboxes.debugging = Tabs.debugging:AddMiddleGroupbox("Debugging")

Debugging = {}
Debugging.console = Groupboxes.debugging:AddToggle({
		Default = false;
		Text = "Console Enabled";
	})
	:OnChanged(function(value)
		Lib_ui:Notify(value and "[debugging] Enabled Console" or "[debugging] Disabled Console", 1)
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
Debugging.sec = Groupboxes.debugging:AddLabel("Avg. Program Cycle: ".._G.averageSec.." s")
Debugging.hz = Groupboxes.debugging:AddLabel("Avg. Program Cycle: ".._G.averageHz.." Hz")
Debugging.clock = Groupboxes.debugging:AddLabel("clock: "..os.clock())

Game_settings = {}
Game_settings.game = Groupboxes.game_settings:AddDropdown({
		Text = "Game";
		Default = Config.settings.game;
		Values = { "Blade Ball", "Death Ball" };
	})
	:OnChanged(function(value)
		Lib_ui:Notify("[settings] Game: " .. value, 1)
	end)
Game_settings.fps = Groupboxes.game_settings:AddDropdown({
		Text = "Your Game's FPS";
		Default = Config.settings.fps;
		Values = { "60", "120", "144", "240" };
	})
	:OnChanged(function(value)
		Lib_ui:Notify("[settings] FPS: " .. value, 1)
	end)

Autoparry_settings = {}
Autoparry_settings.enabled = Groupboxes.autoparry_settings:AddToggle({
			Default = Config.settings.autoparry_enabled;
			Text = "Auto Parry Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Auto Parry" or "[settings] Disabled Auto Parry", 1)
		end)
Autoparry_settings.must_have_highlight_enabled = Groupboxes.autoparry_settings:AddToggle({
			Default = Config.settings.must_have_highlight_enabled;
			Text = "Must Have Highlight Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Must Have Highlight" or "[settings] Disabled Must Have Highlight", 1)
		end)
Groupboxes.autoparry_settings:AddBorder()
Autoparry_settings.maximum_reach_enabled = Groupboxes.autoparry_settings:AddToggle({
			Default = Config.settings.maximum_reach_enabled;
			Text = "Max. Reach Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Maximum Reach" or "[settings] Disabled Maximum Reach", 1)
		end)
Autoparry_settings.maximum_reach = Groupboxes.autoparry_settings:AddSlider({
		Default = Config.settings.maximum_reach;
		Text = "Max. Reach";
		Min = 0;
		Max = 100;
		Rounding = 0;
	}):AddTooltip("The maximum distance that you can parry from")
Groupboxes.autoparry_settings:AddBorder()
Autoparry_settings.maximum_eta_enabled = Groupboxes.autoparry_settings:AddToggle({
			Default = Config.settings.maximum_eta_enabled;
			Text = "Max. Arrival Time Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Maximum Arrival Time" or "[settings] Disabled Maximum Arrival Time", 1)
		end)
Autoparry_settings.maximum_eta = Groupboxes.autoparry_settings:AddSlider({
		Default = Config.settings.maximum_eta;
		Text = "Max. Arrival Time";
		Min = 0;
		Max = 1.25;
		Rounding = 2;
	}):AddTooltip("The maximum amount of estimated seconds away the ball is from you at which you will parry")
Autoparry_settings.prediction_visualizer_enabled = Groupboxes.autoparry_settings:AddToggle({
			Default = Config.settings.prediction_visualizer_enabled;
			Text = "Prediction Visualizer Enabled";
		})
		:OnChanged(function(value)
			Lib_ui:Notify(value and "[settings] Enabled Prediction Visualizer" or "[settings] Disabled Prediction Visualizer", 1)
		end)

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

Datamodel = dx9.GetDatamodel()
Workspace = dx9.FindFirstChild(Datamodel, "Workspace")
Services = {
	players = dx9.FindFirstChild(Datamodel, "Players");
}

Local_player = nil
--Local_player_table = dx9.get_localplayer()
Current_game = _G.Get_Index("game", Game_settings.game.Value)
Current_fps = Game_settings.fps and Game_settings.fps.Value and tonumber(Game_settings.fps.Value) or 60

if Local_player == nil then
	for _, player in pairs(dx9.GetChildren(Services.players)) do
		local pgui = dx9.FindFirstChild(player, "PlayerGui")
		if pgui ~= nil and pgui ~= 0 then
			Local_player = player
			break
		end
	end
end

function Get_local_player_name()
	if Local_player ~= nil and Local_player ~= 0 and dx9.GetType(Local_player) == "Player" then
		return dx9.GetName(Local_player)
	--[[else
		Local_player_table = dx9.get_localplayer()
		return Local_player_table.Info.Name]]
	end
end

Local_player_name = Get_local_player_name()

My_player = dx9.FindFirstChild(Services.players, Local_player_name)
My_character = nil
My_root = nil

local attemptedClick = false
local clicked = false

local passedParriedCheck = false
local passedBallChecks = false
local passedHighlightChecks = false

if My_player ~= nil and My_player ~= 0 then
	if Autoparry_settings.enabled.Value then
		if Current_game == 1 then
			--Blade Ball
			local AliveFolder = dx9.FindFirstChild(Workspace, "Alive")
			local DeadFolder = dx9.FindFirstChild(Workspace, "Dead")

			local InTraining = false

			if AliveFolder ~= nil and AliveFolder ~= 0 then
				My_character = dx9.FindFirstChild(AliveFolder, Local_player_name)
			end

			local characterExists = My_character ~= nil and My_character ~= 0 and true or false

			if not characterExists then
				if DeadFolder ~= nil and DeadFolder ~= 0 then
					My_character = dx9.FindFirstChild(DeadFolder, Local_player_name)
					InTraining = true
					characterExists = My_character ~= nil and My_character ~= 0 and true or false
				end
			end
			
			local lastParryHighlight = _G.parryHighlight
			local lastFakeHighlight = _G.fakeHighlight
			local lastHighlight = _G.highlight
			local newHighlight = nil
			local newParryHighlight = nil
			local newFakeHighlight = nil
			local lastHighlightExisted = lastHighlight ~= nil and lastHighlight ~= 0 and true or false
			local lastParryHighlightExisted = lastParryHighlight ~= nil and lastParryHighlight ~= 0 and true or false
			local lastFakeHighlightExisted = lastFakeHighlight ~= nil and lastFakeHighlight ~= 0 and true or false
			local newHighlightExists = false
			local newParryHighlightExists = false
			local newFakeHighlightExists = false
			
			characterExists = My_character ~= nil and My_character ~= 0 and true or false
			local rootExists = false
			local ballsFolderExists = false
			local selected_spd = nil
			local selected_eta = nil

			if characterExists then
				My_root = dx9.FindFirstChild(My_character, "HumanoidRootPart")
			end
			
			rootExists = My_root and My_root ~= 0 and true or false

			if not characterExists or not rootExists then
				_G.BallCache = {}
				print("no character")
				_G.waitingForBallReturn1 = false
				_G.waitingForBallReturn2 = false
				_G.waitingForBallReturn3 = false
			elseif characterExists and rootExists then
				newHighlight = dx9.FindFirstChild(My_character, "Highlight")
				newHighlightExists = newHighlight ~= nil and newHighlight ~= 0 and true or false
				newParryHighlight = dx9.FindFirstChild(My_character, "ParryHighlight")
				newParryHighlightExists = newParryHighlight ~= nil and newParryHighlight ~= 0 and true or false
				newFakeHighlight = dx9.FindFirstChild(My_character, "FAKE_HIGHLIGHT")
				newFakeHighlightExists = newFakeHighlight ~= nil and newFakeHighlight ~= 0 and true or false

				if newHighlight ~= lastHighlight then
					_G.highlight = newHighlight
					if not _G.highlightSwapped then
						if newHighlightExists then
							_G.clickedForThisHighlight = false
							_G.highlightSwapped = true
						end
					end
				end

				if newParryHighlight ~= lastParryHighlight then
					_G.parryHighlight = newParryHighlight
				end

				if newFakeHighlight ~= lastFakeHighlight then
					_G.fakeHighlight = newFakeHighlight
					if not _G.highlightSwapped then
						if newFakeHighlightExists then
							_G.clickedForThisHighlight = false
							_G.highlightSwapped = true
						end
					end
				end

				if not newParryHighlightExists then
					passedParriedCheck = true
				end

				if Autoparry_settings.must_have_highlight_enabled.Value then
					if newHighlightExists or newFakeHighlightExists then
						passedHighlightChecks = true
					end
				else
					passedHighlightChecks = true
				end

				local lpos = dx9.GetPosition(My_root) --or Local_player_table.Position
				local lvel = dx9.GetVelocity(My_root)
				local lpredictedpos = {
					x = lpos.x + lvel.x * (1/Current_fps);
					y = lpos.y + lvel.y * (1/Current_fps);
					z = lpos.z + lvel.z * (1/Current_fps);
				}

				local Balls = InTraining == false and dx9.FindFirstChild(Workspace, "Balls") or InTraining == true and dx9.FindFirstChild(Workspace, "TrainingBalls")
				ballsFolderExists = Balls ~= nil and Balls ~= 0 and true or false
				if ballsFolderExists then
					local BallsChildren = dx9.GetChildren(Balls) or {}
					local currentBallName = nil

					for i, v in pairs(BallsChildren) do
						local vtype = dx9.GetType(v)
						if vtype == "Part" then
							local memaddress = tostring(v)
							local name = dx9.GetName(v)
							currentBallName = name
							local t = _G.BallCache[name]
							if not t then
								t = {}
								_G.BallCache[name] = t
							end

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
							
							local ballvel = dx9.GetVelocity(v)
							local spd = math.sqrt(ballvel.x^2 + ballvel.y^2 + ballvel.z^2)
							
							if spd <= 0 then
								if Autoparry_settings.prediction_visualizer_enabled.Value then
									local predictedScreenPos = dx9.WorldToScreen({ballpos.x, ballpos.y, ballpos.z})
									dx9.DrawCircle({predictedScreenPos.x, predictedScreenPos.y}, {0, 0, 255}, 10)
								end
								if v ~= t.ball then
									t.ballpos = ballpos
									t.dist = dist
								elseif v == t.ball then
									_G.BallCache[name] = nil
								end
							elseif spd > 0 then
								if Autoparry_settings.prediction_visualizer_enabled.Value then
									local predictedScreenPos = dx9.WorldToScreen({ballpos.x, ballpos.y, ballpos.z})
									dx9.DrawCircle({predictedScreenPos.x, predictedScreenPos.y}, {0, 255, 0}, 10)
								end
								local unitBallvel = {
									x = ballvel.x / spd;
									y = ballvel.y / spd;
									z = ballvel.z / spd;
								}
								--local dot = toPlayer.x * ballvel.x + toPlayer.y * ballvel.y + toPlayer.z + ballvel.z
								local dot = unitToPlayerFromBallPos.x * unitBallvel.x + unitToPlayerFromBallPos.y * unitBallvel.y + unitToPlayerFromBallPos.z * unitBallvel.z

								local eta = (t.dist ~= nil and t.dist or dist) / spd

								t.ball = v
								t.name = name
								
								t.ballvel = ballvel
								t.spd = spd
								t.dot = dot
								t.eta = eta
								t.predictedBallPos = ballpos
							end
						end
					end

					local predictThisFrame = (_G.lastPredicted == nil or _G.lastPredicted ~= nil and os.clock()-_G.lastPredicted >= (1/Current_fps) and true) or false

					for name, t in pairs(_G.BallCache) do
						if currentBallName ~= nil and name ~= currentBallName then
							_G.BallCache[name] = nil
						elseif currentBallName == name then
							local spd = t.spd
							if spd > 0 then
								local v = t.ball
								local ballpos = t.ballpos
								local dist = t.dist
								local ballvel = t.ballvel
								local dot = t.dot
								local eta = t.eta

								if predictThisFrame then
									local oldPredictedBallPos = t.predictedBallPos
									local newPredictedBallPos = {
										x = oldPredictedBallPos.x + ballvel.x * (1/Current_fps);
										y = oldPredictedBallPos.y + ballvel.y * (1/Current_fps);
										z = oldPredictedBallPos.z + ballvel.z * (1/Current_fps);
									}
									local predictedDist = _G.Get_Distance(lpredictedpos, newPredictedBallPos)
									local predictedEta = predictedDist / spd
									t.predictedBallPos = newPredictedBallPos
									t.predictedDist = predictedDist
									t.predictedEta = predictedEta
								end
								local isFrozenThreat = spd < 5
							
								local isFacingMe = dot > 0

								--[[if _G.consoleEnabled then
									print("["..name.."] | frozen: "..tostring(isFrozenThreat).." | dist: "..dist.." | spd: "..spd.." | eta:"..eta.." | dot: "..dot)
								end]]

								if Autoparry_settings.prediction_visualizer_enabled.Value then
									local predictedScreenPos = dx9.WorldToScreen({t.predictedBallPos.x, t.predictedBallPos.y, t.predictedBallPos.z})
									dx9.DrawCircle({predictedScreenPos.x, predictedScreenPos.y}, {255, 255, 0}, 10)
								end
								
								if not passedBallChecks then
									if isFacingMe then
										if isFrozenThreat and t.predictedDist <= 6 then
											if not Autoparry_settings.maximum_reach_enabled.Value or Autoparry_settings.maximum_reach_enabled.Value and t.predictedDist <= Autoparry_settings.maximum_reach.Value then
												if _G.consoleEnabled then
													--print("1")
												end
												passedBallChecks = true
												selected_eta = t.predictedEta
												selected_spd = spd
												break
											end
										elseif Autoparry_settings.maximum_eta_enabled.Value or Autoparry_settings.maximum_reach_enabled.Value then
											if not Autoparry_settings.maximum_reach_enabled.Value or Autoparry_settings.maximum_reach_enabled.Value and t.predictedDist <= Autoparry_settings.maximum_reach.Value then
												if not Autoparry_settings.maximum_eta_enabled.Value or Autoparry_settings.maximum_eta_enabled.Value and t.predictedEta <= Autoparry_settings.maximum_eta.Value then
													if _G.consoleEnabled then
														--print("2")
													end
													passedBallChecks = true
													selected_eta = t.predictedEta
													selected_spd = spd
													break
												end
											end
										end
									end
								end
							end
						end
					end

					if predictThisFrame then
						_G.lastPredicted = os.clock()
					end
				end

				if passedBallChecks then
					_G.lastAttemptedClick = os.clock()
					attemptedClick = true
					--[[if _G.consoleEnabled then
						print("\nHighlight Address: "..tostring(_G.highlight))
						print("Parry Highlight Address: "..tostring(_G.parryHighlight))
						print("Fake Highlight Address: "..tostring(_G.fakeHighlight).."\n")
					end]]
					if passedHighlightChecks then
						if passedParriedCheck then
							--if _G.clickedForThisHighlight == false then
								_G.highlightSwapped = false
								if (_G.nextParryTime == nil or (_G.nextParryTime ~= nil and os.clock() >= _G.nextParryTime)) then
									_G.nextParryTime = os.clock() + selected_eta * 0.15 --autoparry_settings.cooldown.Value
									if _G.consoleEnabled then
										print("now: "..os.clock())
										print("next: ".._G.nextParryTime)
									end
									if _G.consoleEnabled then
										print("\n\n\nClicked!\n\n\n")
									end
									_G.clickedForThisHighlight = true
									clicked = true
									_G.lastClick = os.clock()
									dx9.Mouse1Click()
								else
									if _G.consoleEnabled then
										print("now: "..os.clock())
										print("remaining: ".._G.nextParryTime - os.clock())
									end
								end
							--end
						end
					end
				end
			end
		end
	end
end

Groupboxes.debugging:AddBorder()
Groupboxes.debugging:AddBlank(15)
Groupboxes.debugging:AddTitle("Highlights")
Debugging.HighlightAddress = Groupboxes.debugging:AddLabel("Highlight Address: "..tostring(_G.highlight), _G.highlight ~= nil and _G.highlight ~= 0 and {0, 255, 0} or {255, 0, 0})
Debugging.ParryHighlightAddress = Groupboxes.debugging:AddLabel("ParryHighlight Address: "..tostring(_G.parryHighlight), _G.parryHighlight ~= nil and _G.parryHighlight ~= 0 and {0, 255, 0} or {255, 0, 0})
Debugging.FakeHighlightAddress = Groupboxes.debugging:AddLabel("FAKE_HIGHLIGHT Address: "..tostring(_G.fakeHighlight), _G.fakeHighlight ~= nil and _G.fakeHighlight ~= 0 and {0, 255, 0} or {255, 0, 0})
Groupboxes.debugging:AddBlank(15)
Groupboxes.debugging:AddTitle("Clicks")
Debugging.AttemptedClick = Groupboxes.debugging:AddLabel("Attempted Click: "..tostring(_G.lastAttemptedClick), attemptedClick and {0, 255, 0} or {255, 0, 0})
Debugging.Clicked = Groupboxes.debugging:AddLabel("Clicked: "..tostring(_G.lastClick), clicked and {0, 255, 0} or {255, 0, 0})
Groupboxes.debugging:AddBlank(15)
Groupboxes.debugging:AddTitle("Checks")
Debugging.ParriedCheck = Groupboxes.debugging:AddLabel("Passed Parried Check: "..tostring(passedParriedCheck), passedParriedCheck and {0, 255, 0} or {255, 0, 0})
Debugging.BallChecks = Groupboxes.debugging:AddLabel("Passed Ball Checks: "..tostring(passedBallChecks), passedBallChecks and {0, 255, 0} or {255, 0, 0})
Debugging.HighlightChecks = Groupboxes.debugging:AddLabel("Passed Highlight Checks: "..tostring(passedHighlightChecks), passedHighlightChecks and {0, 255, 0} or {255, 0, 0})

_G.passedLastParriedCheck = passedParriedCheck
_G.passedLastBallChecks = passedBallChecks
_G.passedLastHighlightChecks = passedHighlightChecks

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= Config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end