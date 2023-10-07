--[[local userOptionsPath = "ModOptions.json"
local userOptions = {}

local currentMod = Ext.Mod.GetMod(ModuleUUID).Info
local modOptionsPath = "Mods/" .. currentMod.Directory .. "/ScriptExtender/ModOptions.json"
ModOptions = {}

local function S5E_LoadUserOptions()
    local options = Ext.Json.Parse(optionsFile)
    if options[ModuleUUID] ~= nil then
        userOptions = options[ModuleUUID]
    end
end

local function parseEnabledOption(optionName, attributes, enabledOptions, dependencies, conflicts)
    S5E_Set_Add(enabledOptions, optionName)

    for _, dep in pairs(attributes.dependencies) do
        S5E_Set_Add(dependencies, dep)
    end

    for _, con in pairs(attributes.conflicts) do
        S5E_Set_Add(conflicts, con)
    end
end

local function checkMissingDependencies(enabledOptions, dependencies, missingDependencies)
    for dep in pairs(dependencies) do
        if (enabledOptions[dep] == nil or not enabledOptions[dep]) and not missingDependencies[dep] then
            S5E_Set_Add(missingDependencies, dep)
            if next(ModOptions[dep].dependencies) ~= nil then
                checkMissingDependencies(enabledOptions, S5E_Set(ModOptions[dep].dependencies), missingDependencies)
            end
        end
    end
end

local function S5E_ValidateModOptions(forceDependencies)
    forceDependencies = forceDependencies or false
    local enabledOptions = {}
    local dependencies = {}
    local conflicts = {}
    for optionName, attributes in pairs(ModOptions) do
        if attributes.enabled then
            parseEnabledOption(optionName, attributes, enabledOptions, dependencies, conflicts)
        end
    end

    local ok = true
    local missingDependencies = {}
    checkMissingDependencies(enabledOptions, dependencies, missingDependencies)
    if next(missingDependencies) ~= nil then
        ok = false
        if forceDependencies then
            for dep in pairs(missingDependencies) do
                ModOptions[dep].enabled = true
                parseEnabledOption(dep, ModOptions[dep], enabledOptions, dependencies, conflicts)
            end
        end
    end

    local conflictsDetected = {}
    for con in pairs(conflicts) do
        if enabledOptions[con] then
            S5E_Set_Add(conflictsDetected, con)
        end
    end
    if next(conflictsDetected) ~= nil then
        ok = false
    end
end

function S5E_LoadModOptions()

    S5E_LoadUserOptions()

    local optionsFile = Ext.IO.LoadFile(modOptionsPath, "data")

    ModOptions = Ext.Json.Parse(optionsFile)
    for optionName, attributes in pairs(ModOptions) do
        local userOption = userOptions[optionName]
        local enabled = attributes.enabled
        local value = attributes.value
        if userOption ~= nil  then
            if userOption.enabled ~= nil then
                enabled = userOption.enabled
            end
            if userOption.value ~= nil then
                value = userOption.value
            end

            enabled  = userOption.enabled or enabled
            value = userOption.value or value
        end
        attributes.enabled = enabled
        attributes.value = value

        local filteredDependencies = {}
        for _, dep in pairs(attributes.dependencies) do
            if ModOptions[dep] ~= nil then
                table.insert(filteredDependencies, dep)
            end
        end
        attributes.dependencies = filteredDependencies

        local filteredConflicts = {}
        for _, con in pairs(attributes.conflicts) do
            if ModOptions[con] ~= nil then
                table.insert(filteredConflicts, con)
            end
        end
        attributes.conflicts = filteredConflicts
    end

    S5E_ValidateModOptions(true)

end

function IsModOptionEnabled(modOption)
    return ModOptions[modOption] ~= nil and ModOptions[modOption].enabled
end--]]