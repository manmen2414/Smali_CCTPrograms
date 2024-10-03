if not turtle then
    error("Please run on turtle.")
end
repeat
    turtle.dig();
    turtle.digUp();
    if not turtle.detectDown() then
        local selected = 0;
        --- If turtle don't have any block, Skip place block event.
        while turtle.getItemCount() == 0 and selected < 17 do
            turtle.select(((turtle.getSelectedSlot) % 16) + 1)
            selected = selected + 1;
        end
        if selected < 17 then
            turtle.placeDown();
        else
            print(os.date():match("[0-9][0-9]:[0-9][0-9]:[0-9][0-9]") .. "  I have no blocks!")
        end
    end
    turtle.forward()
until false
