--[[local function OnSessionLoaded()

    -- Define global variables
    HasPrinted = {}

    function printTableAddress(t)
        for k, v in pairs(t) do
            print(k, v)
        end
    end

    function printTable(tbl, indent)
        if not indent then indent = 0 end

        for k, v in pairs(tbl) do
            formatting = string.rep("  ", indent) .. k .. ": "

            if type(v) == "table" then
                print(formatting)
                printTable(v, indent+1)
            else
                print(formatting .. tostring(v))
            end
        end
    end

    -- Without JSON beautify in SE this will have to do
    function beautifyJson(json)
        local result = ""
        local indent = 0
        local inString = false
        local currentChar = ""

        for i = 1, #json do
            currentChar = json:sub(i, i)

            if currentChar == '"' and json:sub(i - 1, i - 1) ~= "\\" then
                inString = not inString
            end

            if inString then
                result = result .. currentChar
            else
                if currentChar == "{" or currentChar == "[" then
                    indent = indent + 2
                    result = result .. currentChar .. "\n" .. string.rep(" ", indent)
                elseif currentChar == "}" or currentChar == "]" then
                    indent = indent - 2
                    result = result .. "\n" .. string.rep(" ", indent) .. currentChar
                elseif currentChar == "," then
                    result = result .. currentChar .. "\n" .. string.rep(" ", indent)
                else
                    result = result .. currentChar
                end
            end
        end
        return result
    end

    function writeDefaultConfig()
        -- Define the default configuration
        local defaultConfigRaw = '{"Spells":{"TCoESpells":{"Enabled":true},"Cantrips":{"Enabled":true}}}'

        -- Beautify the JSON string
        local defaultConfig = beautifyJson(defaultConfigRaw)

        -- Write the default configuration to the file
        Ext.IO.SaveFile("5eSpells.json", defaultConfig)
    end

    function readJsonFile()
        -- Load the file and get its content
        local status, json = pcall(Ext.IO.LoadFile, "5eSpells.json")

        -- Check if the file was loaded successfully
        if not status or not json then
            print(string.format("INFO: Couldn't load: %%LOCALAPPDATA%%\\Larian Studios\\Baldur's Gate 3\\Script Extender\\%s. Applying default configuration", json or "5eSpells.json"))

            -- If the file is not present or fails to load, write the default config file
            writeDefaultConfig()

            -- Try to load the file again after writing the default config
            status, json = pcall(Ext.IO.LoadFile, "5eSpells.json")

            -- If the file still fails to load, return nil
            if not status or not json then
                print("ERROR: Failed to load config file after writing default config")
                return nil
            end
        end

        -- Parse the JSON string into a Lua table
        local status, result = pcall(Ext.Json.Parse, json)

        -- Check if the JSON was parsed successfully
        if not status then
            print(string.format("ERROR: Failed to parse JSON: %s", result)) -- result contains the error message
            return nil
        end

        -- Assign the result to the global ConfigTable
        ConfigTable = result

        -- Print the entire table for debugging only if HasPrinted is false
        if not HasPrinted["ConfigTable"] and Ext.Debug.IsDeveloperMode() then
            printTableAddress(ConfigTable)
            printTable(ConfigTable)
            HasPrinted["ConfigTable"] = true
        end
    end

    -- Call the readJsonFile function to read the JSON file and store the returned table in ConfigTable
    readJsonFile()

	local spellsconfig = ConfigTable["Spells"]["TCoESpells"]
	local enabled = spellsconfig["Enabled"]
	if	enabled == true then
		_D("TCoE Spells Enabled")
	end
end
Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)--]]