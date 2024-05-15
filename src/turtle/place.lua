while true do
    turtle.digUp("left")
    turtle.placeUp()
    sleep(10)
    if turtle.getSelectedSlot() == 1 then
        turtle.select(2)
    else
        turtle.select(1)
    end
end
