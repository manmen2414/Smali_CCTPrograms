local idAndMCID = {
    inventoryManager_4 = "AM_107ryu",
    inventoryManager_5 = "Motchii709",
    inventoryManager_6 = "AutumnMouse578"
}
local Reversed = {};
for key, value in pairs(idAndMCID) do
    Reversed[value] = key;
end
local ifwebhook = require("webhook")

return {
    Open_Chat = "t",
    ifLowerHP = 4,
    remove = function(sendPlayer)
        if Reversed[sendPlayer] then
            local invManager = peripheral.wrap(Reversed[sendPlayer])
            local beforecount = -1;
            repeat
                beforecount = invManager.removeItemFromPlayer("front", {})
            until beforecount == 0
            if ifwebhook then
                ifwebhook.SendEmergency(sendPlayer .. " used Item Teleporter.")
            end
        end
    end
}
