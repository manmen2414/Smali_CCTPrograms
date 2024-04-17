local function IsHaveInventorySpace()
    for i = 1, 16, 1 do
        if turtle.getItemCount(i) == 0 then
            return true;
        end
    end
    return false;
end
turtle.refuel()
local moto = turtle.getFuelLevel();
local half = moto / 2
local count = 0;
for i = 1, half - 1, 1 do
    if not IsHaveInventorySpace() or turtle.getFuelLevel() < half then
        break;
    end
    turtle.dig("right")
    turtle.digUp("right")
    turtle.digDown("right")
    turtle.forward()
    count = count + 1;
end
print("Please return!!!")
turtle.turnLeft()
turtle.turnLeft()
for i = 1, count, 1 do
    turtle.forward()
end
