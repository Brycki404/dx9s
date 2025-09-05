--indent size 4
dx9 = dx9 --in VS Code, this gets rid of a ton of problem underlines
local startTime = os.clock()

Config = _G.Config or {
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
if _G.Config == nil then
	_G.Config = Config
	Config = _G.Config
end

if _G.CountTableEntries == nil then
	_G.CountTableEntries = function(t)
		local count = 0
		if t then
			for _ in pairs(t) do
				count = count + 1
			end
		end
		return count
	end
end
CountTableEntries = _G.CountTableEntries

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

repr = loadstring(dx9.Get(Config.urls.repr))()

Lib_ui = loadstring(dx9.Get(Config.urls.DXLibUI))()

Lib_esp = loadstring(dx9.Get(Config.urls.LibESP))()

Interface = Lib_ui:CreateWindow({
	Title = "Scripter Panel | dx9ware | By @Brycki";
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
Tabs.debug = Interface:AddTab("Debug")
Tabs.deepsearch = Interface:AddTab("Deep Search")

Groupboxes = {}
Groupboxes.debug = Tabs.debug:AddMiddleGroupbox("Debugging")
Groupboxes.deepsearch = Tabs.deepsearch:AddMiddleGroupbox("Deep Search")

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

Deepsearch = {}
Groupboxes.deepsearch:AddTitle("Instructions")
Groupboxes.deepsearch:AddLabel("Hover over the UI elements below to read a tooltip for them.")
Groupboxes.deepsearch:AddLabel("Text Boxes do not yet have a cursor, so follow the instructions below:")
Groupboxes.deepsearch:AddLabel("When typing:")
Groupboxes.deepsearch:AddLabel("[LEFT SHIFT] and [RIGHT SHIFT] to toggle capslock")
Groupboxes.deepsearch:AddLabel("[SUBTRACT] on your NumPad to type dashes and underscores")
Groupboxes.deepsearch:AddLabel("[ENTER/RETURN] to stop typing")
Groupboxes.deepsearch:AddLabel("[SPACEBAR] to type a space")
Groupboxes.deepsearch:AddLabel("[BACKSPACE] to delete the last character")
Groupboxes.deepsearch:AddBorder()
Deepsearch.searchbox = Groupboxes.deepsearch:AddTextBox({
	Index = "deepsearch_searchbox";
	Placeholder = ">>INSTANCE NAME HERE<<";
}):AddTooltip("Search For All Instances With This Name")
Groupboxes.deepsearch:AddLabel(Deepsearch.searchbox.Capslock and "Capslock: ENABLED" or "Capslock: DISABLED", Deepsearch.searchbox.Capslock and {0, 255, 0} or {255, 0, 0})
Deepsearch.exactmatch = Groupboxes.deepsearch:AddToggle({
	Index = "deepsearch_exactmatch";
	Text = "Exact Match";
	Default = false;
}):AddTooltip("Whether Or Not The Instance Name You Search For Has To Be An Exact Match"):OnChanged(function(value)
	Lib_ui:Notify("Toggled Exact Match to "..tostring(value), 1)
end)

Datamodel = dx9.GetDatamodel()
Workspace = dx9.FindFirstChild(Datamodel, "Workspace")

local reprSettings = {
	pretty = true;              -- print with \n and indentation?
	semicolons = true;          -- when printing tables, use semicolons (;) instead of commas (,)?
	sortKeys = false;             -- when printing dictionary tables, sort keys alphabetically?
	spaces = 2;                  -- when pretty printing, use how many spaces to indent?
	Tabs = false;                -- when pretty printing, use Tabs instead of spaces?
	robloxFullName = false;      -- when printing Roblox objects, print full name or just name? 
	robloxProperFullName = false; -- when printing Roblox objects, print a proper* full name?
	robloxClassName = false;      -- when printing Roblox objects, also print class name in parens?
}

function ShallowCopy(tbl)
	local t = {}
	for key, value in pairs(tbl) do
		t[key] = value
	end
	return t
end

function FindPath(tbl, targetIndex, currentPath)
    currentPath = currentPath or {}

    for key, value in pairs(tbl) do
		local newPath = ShallowCopy(currentPath)
        table.insert(newPath, key)
		
        if key == targetIndex then
            return newPath
        elseif type(value) == "table" then
            local result = FindPath(value, targetIndex, newPath)
            if result then
                return result
            end
        end
    end

    return nil
end

-- Helper to format the path as a string
function FormatPath(path)
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
		if Workspace ~= nil and Workspace ~= 0 then
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
							if instance ~= Workspace then
								if instanceName ~= nil and type(instanceName) == "string" then
									if Deepsearch.exactmatch.Value then
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

			Search(Workspace, _G.deepSearchCache.Tree)
		end
	end
end

Deepsearch.searchbutton = Groupboxes.deepsearch:AddButton("Search", function()
	local searchTerm = Deepsearch.searchbox:GetValue()
	if searchTerm then
		if not _G.deepSearchCache.Searching then
			_G.deepSearchCache.Searching = true;
			Lib_ui:Notify("Searching for '"..searchTerm.."'", 1)
			DeepSearch(searchTerm)
			print(repr(_G.deepSearchCache.Tree, reprSettings))
			print(repr(_G.deepSearchCache.Tree, reprSettings))
			print("Hits:", CountTableEntries(_G.deepSearchCache.Hits))
			for i, instance in pairs(_G.deepSearchCache.Hits) do
				local path = FindPath(_G.deepSearchCache.Tree, instance)
				if path then
					print("\nPath to value:", FormatPath(path), ", "..tostring(dx9.GetType(instance)))  --> Output: Path to value: ["user"]["settings"]["theme"], TYPE
				else
					print("\nValue not found.")
				end
			end
			_G.deepSearchCache.Searching = false;
		end
	end
end):AddTooltip("Click To Start A Search")

if _G.deepSearchCache.Searching then
	Groupboxes.deepsearch:AddLabel("Searching in progress...", {255, 255, 0})
else
	Groupboxes.deepsearch:AddLabel("There is no currently running search in progress.", {100, 100, 100})
end
Groupboxes.deepsearch:AddLabel(tostring(_G.deepSearchCache.InstancesSearched or 0).." instances searched")

Services = {
	players = dx9.FindFirstChild(Datamodel, "Players");
}

Local_player = nil
Local_player_table = dx9.get_localplayer()

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
	else
		Local_player_table = dx9.get_localplayer()
		return Local_player_table.Info.Name
	end
end

Local_player_name = Get_local_player_name()

My_player = dx9.FindFirstChild(Services.players, Local_player_name)

if My_player ~= nil and My_player ~= 0 then
    --do stuff

end

local endTime = os.clock()
local elapsedTime = endTime - startTime
if _G.lastElapsedCycleTimesCache ~= nil then
	if #_G.lastElapsedCycleTimesCache >= Config.settings.maximum_Hz_Cache then
		table.remove(_G.lastElapsedCycleTimesCache, 1)
	end
	table.insert(_G.lastElapsedCycleTimesCache, elapsedTime)
end