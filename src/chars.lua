local invent = false
local hex = "0123456789ABCDEF"
print("  " .. hex)
for i = 0, 112, 16 do
    term.setTextColor(colors.white)
    term.write(hex:sub(i / 16 + 1, i / 16 + 1) .. " ")
    for j = 0, 15, 1 do
        local a = i + j;
        if invent then
            if a % 2 == 0 then
                term.setTextColor(colors.lime)
            else
                term.setTextColor(colors.green)
            end
        else
            if a % 2 == 0 then
                term.setTextColor(colors.green)
            else
                term.setTextColor(colors.lime)
            end
        end
        term.write(string.char(a))
    end
    print()
    invent = not invent
end
