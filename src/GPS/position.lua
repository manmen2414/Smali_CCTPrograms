local ComputerPOS = { x = 8, y = 74, z = 1 }
local pD = peripheral.find("playerDetector")
term.clear()
---@return [string,number,number,number,string,number][]
local function get()
    local arr = {};
    local players = pD.getOnlinePlayers()
    term.setCursorPos(1, 1)
    local sortmax = 0;
    for index, name in ipairs(players) do
        if sortmax < #name then
            sortmax = #name
        end
    end
    for index, name in ipairs(players) do
        local pos = pD.getPlayerPos(name)
        if not pos.x then
            arr[#arr + 1] = { name, nil }
        else
            local distance = 0;
            distance = distance + math.abs(ComputerPOS.x - pos.x)
            distance = distance + math.abs(ComputerPOS.y - pos.y)
            distance = distance + math.abs(ComputerPOS.z - pos.z)
            arr[#arr + 1] = { name, pos.x, pos.y, pos.z, pos.dimension, distance };
        end
    end
    return arr;
end

return get
