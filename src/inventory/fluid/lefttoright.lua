-- left up bottom right front back
local From = peripheral.wrap("left")
local To = "right"
repeat
    pcall(function()
        repeat
            From.pushFluid(To)
        until false
    end
    )
until false
