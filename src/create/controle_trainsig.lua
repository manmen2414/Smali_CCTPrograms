local function show(COLOR)
    term.clear()
    term.setCursorPos(1, 1)
    local LEDS = #COLOR
    local x, y = term.getSize()
    local oneLEDsize = (((y - (LEDS - 1) * 2)) / LEDS)
    if oneLEDsize % 5 ~= 0 then
        error("mismatched moniter and LEDS!")
    end
    local LineText = ""
    local output = "";
    for i = 0, x - 1, 1 do
        LineText = LineText .. " ";
    end
    for i = 1, LEDS, 1 do
        output = "";
        for n = 1, oneLEDsize, 1 do
            if n == oneLEDsize then
                output = output .. LineText;
            elseif (i == LEDS) and (n == oneLEDsize - 1) then
                output = output .. LineText;
                break;
            else
                output = output .. LineText .. "\n";
            end
        end
        if COLOR[i] == "R" then
            term.setBackgroundColour(colors.red)
        elseif COLOR[i] == "Y" then
            term.setBackgroundColour(colors.yellow)
        elseif COLOR[i] == "G" then
            term.setBackgroundColour(colors.green)
        elseif COLOR[i] == "_" then
            term.setBackgroundColour(colors.black)
        end
        print(output)
        term.setBackgroundColour(colors.gray)
        if i ~= LEDS then
            print(LineText .. "\n" .. LineText)
        end
    end
    term.setBackgroundColour(colors.black)
end

term.clear()
term.setCursorPos(1, 1)
local color = {
}
--[[while true do
    print("R/Y/G/_/end:")
    local input = read()
    if input == "end" then
        break;
    else
        color[#color + 1] = input;
    end
end
show(color)
while true do
    show({ "R", "Y", "G" });
    sleep(1)
    show({ "Y", "G", "R" });
    sleep(1)
    show({ "G", "R", "Y" });
    sleep(1)
end]]

return show;
