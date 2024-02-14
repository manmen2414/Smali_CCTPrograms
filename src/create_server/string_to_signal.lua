local signal = {
    safe = false,
    warning = false
}
function Str2Signal(str)
    local value = tonumber(str)
    if value ~= nil then
        signal.safe = value < 2
        if value > 1 then
            signal.warning = (value % 2 == 0)
        end
    else
        error("str is not String!")
    end
end
