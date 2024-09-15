local SLEEP = 1
local perips = peripheral.getNames();
local modems = {};
local complated = 0;
for index, value in ipairs(perips) do
    if value:sub(0, 5) == "modem" then
        modems[#modems + 1] = peripheral.wrap(value)
        peripheral.wrap(value).closeAll();
    end
end

local function foundcheck()
    repeat
        local _, _, ch, _, message, dis = os.pullEvent("modem_message");
        if not fs.exists(ch .. ".json") then
            print("found!!! port:" .. ch)
            local pipe = fs.open(ch .. ".json", "w")
            pipe.write(textutils.serialiseJSON({ message = message, distance = dis }));
            pipe.close()
        end
    until false
end
local ForTheModem = function(modem, from, to)
    return function()
        repeat
            for i = from, to, 128 do
                for j = i, i + 127, 1 do
                    if j < 65536 then
                        modem.open(j)
                    end
                end
                sleep(SLEEP)
                modem.closeAll();
            end
            complated = complated + 1;
            if complated == #modems then
                print("complated!")
                complated = 0
            end
        until false
    end
end


local channelMax = (65536 / #modems) - 1
local funcs = { foundcheck };

print("found " .. #modems .. " modems.")
print("channelMax: " .. channelMax)
print("Loop time: " .. (channelMax + 1) / 128 * SLEEP)

for i = 0, #modems - 1, 1 do
    funcs[#funcs + 1] = ForTheModem(modems[i + 1], (i * channelMax), ((i + 1) * channelMax))
end

parallel.waitForAll(table.unpack(funcs))
