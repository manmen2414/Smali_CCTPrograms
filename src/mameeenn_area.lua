local args = { "Welcome to mameeenn area!", "You need to Authmation.", "Please touch the screen." }
local monitor = peripheral.find("monitor")

monitor.clear();
while true do
    if redstone.getInput("left") then
        for indexA, valueA in ipairs(args) do
            monitor.setCursorPos(1, indexA)
            local arg = {};
            local gmatchfunc = valueA:gmatch(".")
            for i = 1, #valueA, 1 do
                arg[i] = gmatchfunc();
            end
            for _, valueB in ipairs(arg) do
                monitor.write(valueB)
                sleep(0.05)
            end
        end

        local event, side, x, y = os.pullEvent("monitor_touch")
        redstone.setOutput("front", true)
        sleep(2)
        redstone.setOutput("front", false)
        monitor.clear();
    else
        sleep(0.5)
    end
end
