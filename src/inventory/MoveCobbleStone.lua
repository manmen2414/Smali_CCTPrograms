-- ## REQUIRE utils/inventoryM.lua
local inventoryM = require("inventoryM")


local tur = peripheral.wrap("turtle_2");
local chest = peripheral.wrap("minecraft:chest_1")
local chestto = peripheral.wrap("minecraft:chest_3")


os.startTimer(0.05)
repeat
    local event, param1, param2, param3, param4, param5 = os.pullEvent();
    if event == "timer" then
        inventoryM.Move(chest, chestto, "minecraft:cobblestone", 64)
        term.clear();
        term.setCursorPos(1, 1);
        print("CobbleStone Requester")
        print("Press r key to restart turtle")
        print("Press s key to stop turtle")
        if tur.isOn() then
            print(">>> miner is on<<<")
        end
        local list = #chest.list();
        local size = chest.size();
        print("Slot used: " .. list .. "/" .. size)
        os.startTimer(0.05)
    elseif event == "key" and param1 == 82 then
        if tur.isOn() then
            tur.shutdown();
        end
        tur.turnOn();
        print("shutdown/start turtle...")
    elseif event == "key" and param1 == 83 then
        tur.shutdown();
        print("shutdown turtle...")
    end
until false
