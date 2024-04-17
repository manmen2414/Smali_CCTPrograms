local item = "minecraft:wheat_seeds"


local function SelectItem(itemID)
    for i = 1, 16, 1 do
        if (turtle.getItemDetail(i) or { name = "" }).name == itemID then
            return turtle.select(i)
        end
    end
    return false;
end
repeat
    SelectItem(item)
    turtle.placeDown()
until false
