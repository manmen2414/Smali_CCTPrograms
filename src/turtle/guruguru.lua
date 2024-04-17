local circleA = { 8, 2, 2, 1, 1 }
local circleB = { 2, 2 }
local count = 1;
local Isstart = true;
local IsA = true;
local function forward(co)
    for i = 1, co, 1 do
        turtle.forward()
    end
end

if turtle.refuel() then
    while true do
        local function circle(curcleAorB)
            if #curcleAorB == count then
                IsA = not IsA;
                Isstart = false;
                count = 0;
            end
        end
        if IsA then
            --[[if circleA[count] == 8 and not Isstart then
                forward(1);
                turtle.turnRight();
            end]]
            forward(circleA[count]);
            turtle.turnRight();
            forward(1);
            turtle.turnLeft();
            circle(circleA)
        else
            forward(circleB[count]);
            turtle.turnLeft();
            forward(1);
            turtle.turnRight();
            circle(circleB)
        end
        count = count + 1;
    end
else
    error("No fuel!")
end
