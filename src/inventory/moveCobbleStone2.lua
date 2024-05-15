local peripherals = peripheral.getNames()
local To = "storagedrawers:standard_drawers_1_3"
local Slot = { From = 1, To = 2 }

while true do
    for index, value in ipairs(peripherals) do
        local pe = peripheral.wrap(value)
        if value ~= To and peripheral.hasType(value, "inventory") then
            pe.pushItems(To, Slot.From, nil, Slot.To)
        end
    end
end
