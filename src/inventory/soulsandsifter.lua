local inventoryM = require("inventoryM")
local cobbleOUT = peripheral.wrap("storagedrawers:standard_drawers_1_1")
local cobbleOUT2 = peripheral.wrap("storagedrawers:standard_drawers_1_2")
local cobbleIN = peripheral.wrap("create:crushing_wheel_controller_0")
local sandOUT = peripheral.wrap("create:chute_1")
local sandIN = peripheral.wrap("create:chute_0")
local soulOUT = peripheral.wrap("create:smart_chute_0")
local soulIN_sifterOUT = {
    peripheral.wrap("createsifter:brass_sifter_0"),
    peripheral.wrap("createsifter:brass_sifter_1"),
    peripheral.wrap("createsifter:brass_sifter_2")
}
local sifterIN = peripheral.wrap("storagedrawers:standard_drawers_4_0")
local oilIN = peripheral.wrap("create:fluid_tank_1")
local oilOUT = peripheral.wrap("create:fluid_tank_0")
local gn = peripheral.getName

while true do
    if (soulOUT.list()[1] or { count = -1 }).count < 16 then
        cobbleOUT2.pushItems(gn(cobbleOUT), 2)
        cobbleOUT.pushItems(gn(cobbleIN), 2)
        sandOUT.pushItems(gn(sandIN), 1)
    end
    for index, value in ipairs(soulIN_sifterOUT) do
        soulOUT.pushItems(gn(value), 1, 21)
        value.pushItems(gn(sifterIN), 2)
        value.pushItems(gn(sifterIN), 3)
        value.pushItems(gn(sifterIN), 4)
    end
    oilIN.pushFluid(peripheral.getName(oilOUT))
    sleep(3)
end
