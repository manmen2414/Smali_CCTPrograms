local count = 0;
if turtle.refuel() then
    while true do
        if count == 5 then
            turtle.turnRight()
            count = 0;
        else
            turtle.forward()
            count = count + 1;
        end
    end
else
    error("No fuel!")
end
