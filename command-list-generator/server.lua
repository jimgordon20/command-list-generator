local function fetchAllCommands()
    local commands = GetRegisteredCommands()
    local commandList = {}
    for _, command in ipairs(commands) do
        table.insert(commandList, command.name)
    end
    return commandList
end
local function printCommands(commands)
    print("=== Registered Commands ===")
    for _, command in ipairs(commands) do
        print(command)
    end
end
local function saveToFile(commands)
    local fileName = Config.FileName or "commands_list.json"
    local filePath = ("resources/%s/%s"):format(GetCurrentResourceName(), fileName)
    local file = io.open(filePath, "w")
    if file then
        file:write(json.encode(commands, { indent = true }))
        file:close()
        print("^2[Success]^0 Commands saved to " .. filePath)
    else
        print("^1[Error]^0 Could not write to file " .. filePath)
    end
end
local function debugPrint(message)
    if Config.Debug then
        print("^3[Debug]^0 " .. message)
    end
end
local function handleCommands()
    debugPrint("Fetching all registered commands...")
    local commands = fetchAllCommands()
    if Config.OutputMode == "print" then
        debugPrint("Output mode set to print. Printing commands...")
        printCommands(commands)
    elseif Config.OutputMode == "file" then
        debugPrint("Output mode set to file. Saving commands to JSON...")
        saveToFile(commands)
    else
        print("^1[Error]^0 Invalid output mode in config.")
    end
end

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        debugPrint("Resource started. Running handleCommands()...")
        handleCommands()
    end
end)