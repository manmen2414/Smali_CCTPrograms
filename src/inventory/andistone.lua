local item = peripheral.wrap("storagedrawers:standard_drawers_2_0")
local basin = peripheral.wrap("create:basin_0")
local alloy = peripheral.wrap("storagedrawers:standard_drawers_1_0")

while true do
    item.pushItems(peripheral.getName(basin), 2)
    item.pushItems(peripheral.getName(basin), 3)
    basin.pushItems(peripheral.getName(alloy), 10)
    sleep(0.5)
end
