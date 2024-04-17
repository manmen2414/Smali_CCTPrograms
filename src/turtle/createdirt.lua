local function SelectItem(itemID)
    for i = 1, 16, 1 do
        if (turtle.getItemDetail(i) or { name = "" }).name == itemID then
            return turtle.select(i)
        end
    end
    return false;
end

repeat
    local detectble, detected = turtle.inspect()

    if detectble then
        if detected.name == "minecraft:coarse_dirt" then
            if SelectItem("minecraft:diamond_hoe") then
                turtle.place()
            else
                error("I cant find hoe")
            end
        elseif detected.name == "minecraft:dirt" then
            turtle.dig("left")
        end
    elseif SelectItem("minecraft:coarse_dirt") then
        turtle.place()
    end
until false
