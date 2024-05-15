local PSI = peripheral.wrap("create:portable_storage_interface_0")
local Chest = peripheral.wrap("minecraft:chest_8")
local IM = require("inventoryM")
repeat
    if PSI.size() == 0 then
        sleep(0.5)
    else
        IM.Move(PSI, Chest, "minecraft:wheat")
    end
until false
