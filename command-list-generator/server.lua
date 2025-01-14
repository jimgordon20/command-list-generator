-- v1.1
local function fetchAllCommands()
    local commands = GetRegisteredCommands()
    if not commands then
        logMessage("^1[Error]^0 Failed to fetch commands.")
        return {}
    end

    local commandList = {}
    for _, command in ipairs(commands) do
        table.insert(commandList, command.name)
    end
    return commandList
end

local function printCommands(commands)
    logMessage("^2[Info]^0 === Registered Commands ===")
    for _, command in ipairs(commands) do
        print(command)
    end
end

local function saveToFile(commands)
    local fileName = Config.FileName or "commands_list.json"
    local filePath = ("resources/%s/%s"):format(GetCurrentResourceName(), fileName)
    
    local file, err = io.open(filePath, "w")
    if file then
        file:write(json.encode(commands, { indent = true }))
        file:close()
        logMessage("^2[Success]^0 Commands saved to: " .. filePath)
    else
        logMessage("^1[Error]^0 Failed to save commands to file. Error: " .. (err or "unknown"))
    end
end

local function logMessage(message)
    print(message)
end

local function debugPrint(message)
    if Config.Debug then
        logMessage("^3[Debug]^0 " .. message)
    end
end

local function validateConfig()
    if Config.OutputMode ~= "print" and Config.OutputMode ~= "file" then
        logMessage("^1[Error]^0 Invalid Config.OutputMode. Use 'print' or 'file'.")
        return false
    end
    return true
end

local function handleCommands()
    if not validateConfig() then return end

    debugPrint("Fetching all registered commands...")
    local commands = fetchAllCommands()

    if #commands == 0 then
        logMessage("^1[Warning]^0 No commands found.")
        return
    end

    if Config.OutputMode == "print" then
        debugPrint("Output mode set to 'print'. Displaying commands in console...")
        printCommands(commands)
    elseif Config.OutputMode == "file" then
        debugPrint("Output mode set to 'file'. Saving commands to JSON file...")
        saveToFile(commands)
    end
end

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        debugPrint("Resource started. Running handleCommands()...")
        handleCommands()
    end
end)
AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        debugPrint("Resource started. Running handleCommands()...")
        handleCommands()
    end
end)
