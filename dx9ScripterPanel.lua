--indent size 4
local startTime = os.clock()

config = _G.config or {
	urls = {
		DXLibUI = "https://raw.githubusercontent.com/Brycki404/DXLibUI/refs/heads/main/main.lua";
        LibESP = "https://raw.githubusercontent.com/Brycki404/DXLibESP/refs/heads/main/main.lua";
		repr = "https://raw.githubusercontent.com/Ozzypig/repr/refs/heads/master/repr.lua"
	};
	settings = {
		menu_toggle_keybind = "[F2]";

		maximum_Hz_Cache = 15;
		Sec_precision = 4;
		Hz_precision = 0;
	};
}
if _G.config == nil then
	_G.config = config
	config = _G.config
end

if _G.countTableEntries == nil then
	_G.countTableEntries = function(t)
		local count = 0
		if t then
			for _ in pairs(t) do
				count = count + 1
			end
		end
		return count
	end
end
countTableEntries = _G.countTableEntries

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

if _G.deepSearchCache == nil then
	_G.deepSearchCache = {
		Searching = false;
		InstancesSearched = 0;
		Tree = {};
		Hits = {};
	}
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

repr = loadstring(dx9.Get(config.urls.repr))()

lib_ui = loadstring(dx9.Get(config.urls.DXLibUI))()

lib_esp = loadstring(dx9.Get(config.urls.LibESP))()

interface = lib_ui:CreateWindow({
	Title = "Scripter Panel | dx9ware | By @Brycki";
	Size = { 500, 500 };
	Resizable = true;

	ToggleKey = config.settings.menu_toggle_keybind;

	FooterToggle = true;
	FooterRGB = true;
	FontColor = { 255, 255, 255 };
	MainColor = { 25, 25, 25 };
	BackgroundColor = { 20, 20, 20 };
	AccentColor = { 255, 50, 255 };
	OutlineColor = { 40, 40, 40 };
})

tabs = {}
tabs.debug = interface:AddTab("Debug")
tabs.deepsearch = interface:AddTab("Deep Search")

groupboxes = {}
groupboxes.debug = tabs.debug:AddMiddleGroupbox("Debugging")
groupboxes.deepsearch = tabs.deepsearch:AddMiddleGroupbox("Deep Search")

debugging = {}
debugging.console = groupboxes.debug:AddToggle({
		Default = false;
		Text = "Console Enabled";
	}):OnChanged(function(value)
		lib_ui:Notify(value and "[Debug] Enabled Console" or "[Debug] Disabled Console", 1)
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
debugging.sec = groupboxes.debug:AddLabel("Avg. Program Cycle: ".._G.averageSec.." s")
debugging.hz = groupboxes.debug:AddLabel("Avg. Program Cycle: ".._G.averageHz.." Hz")
debugging.clock = groupboxes.debug:AddLabel("Clock: "..os.clock())

deepsearch = {}
groupboxes.deepsearch:AddTitle("Instructions")
groupboxes.deepsearch:AddLabel("Hover over the UI elements below to read a tooltip for them.")
groupboxes.deepsearch:AddLabel("Text Boxes do not yet have a cursor, so follow the instructions below:")
groupboxes.deepsearch:AddLabel("When typing:")
groupboxes.deepsearch:AddLabel("[LEFT SHIFT] and [RIGHT SHIFT] to toggle capslock")
groupboxes.deepsearch:AddLabel("[SUBTRACT] on your NumPad to type dashes and underscores")
groupboxes.deepsearch:AddLabel("[ENTER/RETURN] to stop typing")
groupboxes.deepsearch:AddLabel("[SPACEBAR] to type a space")
groupboxes.deepsearch:AddLabel("[BACKSPACE] to delete the last character")
groupboxes.deepsearch:AddBorder()
deepsearch.searchbox = groupboxes.deepsearch:AddTextBox({
	Index = "deepsearch_searchbox";
	Placeholder = ">>INSTANCE NAME HERE<<";
}):AddTooltip("Search For All Instances With This Name")
groupboxes.deepsearch:AddLabel(deepsearch.searchbox.Capslock and "Capslock: ENABLED" or "Capslock: DISABLED", deepsearch.searchbox.Capslock and {0, 255, 0} or {255, 0, 0})
deepsearch.exactmatch = groupboxes.deepsearch:AddToggle({
	Index = "deepsearch_exactmatch";
	Text = "Exact Match";
	Default = false;
}):AddTooltip("Whether Or Not The Instance Name You Search For Has To Be An Exact Match"):OnChanged(function(value)
	lib_ui:Notify("Toggled Exact Match to "..tostring(value), 1)
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

datamodel = dx9.GetDatamodel()
workspace = dx9.FindFirstChild(datamodel, "Workspace")

local reprSettings = {
	pretty = true;              -- print with \n and indentation?
	semicolons = true;          -- when printing tables, use semicolons (;) instead of commas (,)?
	sortKeys = false;             -- when printing dictionary tables, sort keys alphabetically?
	spaces = 2;                  -- when pretty printing, use how many spaces to indent?
	tabs = false;                -- when pretty printing, use tabs instead of spaces?
	robloxFullName = false;      -- when printing Roblox objects, print full name or just name? 
	robloxProperFullName = false; -- when printing Roblox objects, print a proper* full name?
	robloxClassName = false;      -- when printing Roblox objects, also print class name in parens?
}

function shallowCopy(tbl)
	local t = {}
	for key, value in pairs(tbl) do
		t[key] = value
	end
	return t
end

function findPath(tbl, targetIndex, currentPath)
    currentPath = currentPath or {}

    for key, value in pairs(tbl) do
		local newPath = shallowCopy(currentPath)
        table.insert(newPath, key)
		
        if key == targetIndex then
            return newPath
        elseif type(value) == "table" then
            local result = findPath(value, targetIndex, newPath)
            if result then
                return result
            end
        end
    end

    return nil
end

-- Helper to format the path as a string
function formatPath(path)
    local str = ""
    for i, key in ipairs(path) do
        str = str .. "[" .. dx9.GetName(tonumber(key)) .. "]"
    end
    return str
end

local instanceNameBlacklist = {
	"AnimSaves"
}

function DeepSearch(searchTerm)
	if searchTerm ~= nil and type(searchTerm) == "string" then
		if workspace ~= nil and workspace ~= 0 then
			_G.deepSearchCache.Tree = {}
			_G.deepSearchCache.Hits = {}
			_G.deepSearchCache.InstancesSearched = 0
			
			function Search(instance, parent)
				local address = tostring(instance)
				local hexaddress = string.format("%x", instance)
				local children = dx9.GetChildren(instance)
				if children then
					if type(children) == "table" then
						local foundInBlacklist = false
						local instanceName = dx9.GetName(instance)
						for i, blacklist in pairs(instanceNameBlacklist) do
							if instanceName == blacklist then
								foundInBlacklist = true
								break
							end
						end
						if not foundInBlacklist then
							if instance ~= workspace then
								if instanceName ~= nil and type(instanceName) == "string" then
									if deepsearch.exactmatch.Value then
										if instanceName == searchTerm then
											table.insert(_G.deepSearchCache.Hits, address)
										end
									else
										if string.find(instanceName, searchTerm, 1, true) then
											table.insert(_G.deepSearchCache.Hits, address)
										end
									end
								end
							end
							_G.deepSearchCache.InstancesSearched = _G.deepSearchCache.InstancesSearched + 1
							if #children == 0 then
								parent[address] = instanceName..", "..tostring(dx9.GetType(instance));
							elseif #children > 0 then
								parent[address] = {};
								for i, child in pairs(children) do
									Search(child, parent[address])
								end
							end
						end
					end
				end
			end

			Search(workspace, _G.deepSearchCache.Tree)
		end
	end
end

deepsearch.searchbutton = groupboxes.deepsearch:AddButton("Search", function()
	local searchTerm = deepsearch.searchbox:GetValue()
	if searchTerm then
		if not _G.deepSearchCache.Searching then
			_G.deepSearchCache.Searching = true;
			lib_ui:Notify("Searching for '"..searchTerm.."'", 1)
			DeepSearch(searchTerm)
			print(repr(_G.deepSearchCache.Tree, reprSettings))
			print(repr(_G.deepSearchCache.Tree, reprSettings))
			print("Hits:", countTableEntries(_G.deepSearchCache.Hits))
			for i, instance in pairs(_G.deepSearchCache.Hits) do
				local path = findPath(_G.deepSearchCache.Tree, instance)
				if path then
					print("\nPath to value:", formatPath(path))  --> Output: Path to value: ["user"]["settings"]["theme"]
				else
					print("\nValue not found.")
				end
			end
			_G.deepSearchCache.Searching = false;
		end
	end
end):AddTooltip("Click To Start A Search")

if _G.deepSearchCache.Searching then
	groupboxes.deepsearch:AddLabel("Searching in progress...", {255, 255, 0})
else
	groupboxes.deepsearch:AddLabel("There is no currently running search in progress.", {100, 100, 100})
end
groupboxes.deepsearch:AddLabel(tostring(_G.deepSearchCache.InstancesSearched or 0).." instances searched")

services = {
	players = dx9.FindFirstChild(datamodel, "Players");
}

local_player = nil
local_player_table = dx9.get_localplayer()
current_fps = game_settings.fps and game_settings.fps.Value and tonumber(game_settings.fps.Value) or 60

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
	if local_player ~= nil and local_player ~= 0 and dx9.GetType(local_player) == "Player" then
		return dx9.GetName(local_player)
	else
		local_player_table = dx9.get_localplayer()
		return local_player_table.Info.Name
	end
end

local_player_name = get_local_player_name()

my_player = dx9.FindFirstChild(services.players, local_player_name)

if my_player ~= nil and my_player ~= 0 then
    --do stuff

end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end

print("end")