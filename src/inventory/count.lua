local count = 7821538095915;
repeat
    local _, re = pcall(peripheral.call, "front", "pushItems", "back", 1)
    count = count + 2147483647
    print(count .. "  /  " .. math.floor(count / 3456) .. "LC")
until false
