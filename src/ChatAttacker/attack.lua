---https://stackoverflow.com/questions/656199/search-for-an-item-in-a-lua-list
function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

local reader = fs.open("user_list.json", "r")
---@type {blacklist:string[],blacklist_enable:boolean,whitelist:string[],whitelist_enable:boolean}
local setting = textutils.unserialiseJSON(reader.readAll());
reader.close();

local peripherals = peripheral.getNames();
local playerDetector = peripheral.find("playerDetector");
---@type table[]
local chatBoxs = {};

for _, name in ipairs(peripherals) do
    local perip = peripheral.wrap(name);
    if peripheral.getType(perip) == "chatBox" then
        chatBoxs[#chatBoxs + 1] = perip;
    end
end

---@type function[]
local functions = {};
local link = "https://www.youtube.com/watch?v=dQw4w9WgXcQ";

for _, perip in ipairs(chatBoxs) do
    functions[#functions + 1] = function()
        pcall(function()
            repeat
                local users = playerDetector.getOnlinePlayers();
                local blacklistedUsers = users;
                if setting.blacklist_enable then
                    blacklistedUsers = {};
                    for _, user in ipairs(users) do
                        if Set(setting.blacklist)[user] then
                            blacklistedUsers[#blacklistedUsers + 1] = user;
                        end
                    end
                end
                local whitelistedUsers = blacklistedUsers;
                if setting.whitelist_enable then
                    whitelistedUsers = {};
                    for _, user in ipairs(users) do
                        if not Set(setting.whitelist)[user] then
                            whitelistedUsers[#whitelistedUsers + 1] = user;
                        end
                    end
                end
                users = whitelistedUsers;
                for index, user in ipairs(users) do
                    local message = {
                        text = ((" "):rep(50, " ")):rep(10, "\n"),
                        clickEvent = {
                            action = "open_url",
                            value = link,
                        }

                    }
                    local json = textutils.serialiseJSON(message)
                    perip.sendFormattedMessage(json, user)
                end
            until false
        end)
    end
end

repeat
    parallel.waitForAny(table.unpack(functions))
until false
