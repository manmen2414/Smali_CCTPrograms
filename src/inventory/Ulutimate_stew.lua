local inv = peripheral.wrap("right");
while true do
    if inv.list()[1] ~= nil then
        redstone.setOutput("top", true)
    else
        redstone.setOutput("top", false)
    end
    sleep(0.1)
end
