turtle.refuel()
repeat
    if not turtle.detect() then
        turtle.forward()
    else
        turtle.turnRight()
    end
until false
