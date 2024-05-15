local pD = peripheral.find("playerDetector")
local function ColorPrint(text, color)
    if term.isColor() then
        term.setTextColor(color)
    end
    print(text)
    term.setTextColor(colors.white)
end
while true do
    term.clear()
    term.setCursorPos(1, 1)
    local players = pD.getOnlinePlayers()
    for index, value in ipairs(players) do
        term.write(value .. " " .. string.char(29) .. " ")
        local pos = pD.getPlayerPos(value)
        local Scolor = colors.brown
        if pos.dimension == "minecraft:overworld" then
            Scolor = colors.green
        elseif pos.dimension == "minecraft:the_nether" then
            Scolor = colors.red
        elseif pos.dimension == "minecraft:the_end" then
            Scolor = colors.yellow
        end
        ColorPrint(("%d %d %d"):format(pos.x, pos.y, pos.z), Scolor)
    end
    sleep(0.5)
end
