--indent size 4

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/B0NBunny/DXLibUI/refs/heads/main/main.lua";
	};
	settings = {
		menu_toggle_keybind = "[F3]";
		autoparry_enabled = true;
		autoparry_keybind = "[F4]";
		game = 1; -- 1 = "Blade Ball", 2 = "Death Ball"
	};
};
if _G.config == nil then
	_G.config = config
	config = _G.config
end

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

interface = lib_ui:CreateWindow({
	Title = "Auto Parry Ball | dx9ware | By @Brycki";
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
}

groupboxes = {
	autoparry_settings = tabs.settings:AddLeftGroupbox("Auto Parry");
}

autoparry_settings = {
	enabled = groupboxes.autoparry_settings
		:AddToggle({
			Default = config.settings.autoparry_enabled;
			Text = "ESP Enabled";
		})
		:OnChanged(function(value)
			lib_ui:Notify(value and "[settings] Enabled Auto Parry" or "[settings] Disabled Auto Parry", 1)
		end);

	game = groupboxes.autoparry_settings
		:AddDropdown({
			Text = "Game";
			Default = config.settings.game;
			Values = { "Blade Ball", "Death Ball" };
		})
		:OnChanged(function(value)
			lib_ui:Notify("[settings] Game: " .. value, 1)
		end);
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
local_player_table = dx9.get_localplayer()

current_game = _G.Get_Index("game", autoparry_settings.game.Value)

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
	local_player = local_player_table
end

function get_local_player_name()
	if dx9.GetType(local_player) == "Player" then
		return dx9.GetName(local_player)
	else
		return local_player_table.Info.Name
	end
end

local_player_name = get_local_player_name()

my_player = dx9.FindFirstChild(services.players, local_player_name)
my_character = nil
my_head = nil
my_root = nil
my_humanoid = nil

local PlayerCharacterFolder = nil
if current_game == 1 then
	PlayerCharacterFolder = dx9.FindFirstChild(workspace, "Alive")
end

if PlayerCharacterFolder == nil or PlayerCharacterFolder == 0 then
	return
end

if my_player == nil or my_player == 0 then
	return
elseif my_player ~= nil and my_player ~= 0 then
	my_character = dx9.FindFirstChild(PlayerCharacterFolder, local_player_name)
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

if _G.AutoParry_BladeBall_Task == nil then
	_G.AutoParry_BladeBall_Task = function()
		local Balls = dx9.FindFirstChild(workspace, "Balls")

		for i,v in pairs(dx9.GetChildren(Balls)) do
			local ballpos = dx9.GetPosition(v)
			local vel = dx9.GetVelocity(v)
			local speed = math.sqrt(vel.x^2+vel.y^2+vel.z^2)
			local velocity = vel.x + vel.y + vel.z

   local lpos = local_player_table.Position
			local x = (lpos.x-ballpos.x)*(lpos.x-ballpos.x)
			local y = (lpos.y-ballpos.y)*(lpos.y-ballpos.y)
			local z = (lpos.z-ballpos.z)*(lpos.z-ballpos.z)
			local distance = math.floor(math.sqrt(x+y+z))

			local highlight = dx9.FindFirstChild(my_character, "Highlight")
			if highlight and highlight ~= 0 and distance <= 60 and distance / velocity <= 0.55 then
				dx9.Mouse1Click()
			end
		end
	end
end

if autoparry_settings.enabled.Value then
	if current_game == 1 then
		if _G.AutoParry_BladeBall_Task then
			_G.AutoParry_BladeBall_Task()
		end
	end
end