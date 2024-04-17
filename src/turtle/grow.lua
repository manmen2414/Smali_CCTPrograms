---Inspect to Down, and check growed.
---@return boolean
local function IfGrow()
    local _, RawTable = turtle.inspectDown();
    if RawTable.state ~= nil then
        if RawTable.state.age ~= nil then
            return RawTable.state.age == 7;
        end
    end
    return false;
end
local function SelectItem(itemID)
    for i = 1, 16, 1 do
        if (turtle.getItemDetail(i) or { name = "" }).name == itemID then
            return turtle.select(i)
        end
    end
    return false;
end
local function BrakeAndPlace()
    if IfGrow() then
        if turtle.digDown("right") then
            if SelectItem("minecraft:wheat_seeds") then
                return turtle.placeDown()
            end
        end
    end
    return false;
end

local actions = {
    { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 3, 1, 3 },
    { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 2, 1, 2 },
    { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 3, 1, 3 },
    { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 1 }, { 3, 1, 1, 1, 3 } }
local level = 0;
local function ForwardFarm()
    if turtle.getFuelLevel() == 0 then
        turtle.refuel()
    end
    level = level + 1;
    local action = actions[level];
    for index, value in ipairs(action) do
        if value == 1 then
            turtle.forward()
        elseif value == 2 then
            turtle.turnLeft()
        elseif value == 3 then
            turtle.turnRight()
        end
    end
    if #actions == level then
        level = 0;
    end
end



for index, value in ipairs(actions) do
    if turtle.getFuelLevel() == 0 then
        turtle.refuel()
    end
    BrakeAndPlace();
    ForwardFarm()
end
