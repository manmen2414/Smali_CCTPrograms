local ports = { 32001, 32002, 32003, 32004, 65535, 65533 }
local wireSide = "back"
local wirelessSide = "front"
local wire = peripheral.wrap(wireSide)
local wireless = peripheral.wrap(wirelessSide)
wire.closeAll()
wireless.closeAll()
---console
term.clear()
term.setCursorPos(1, 1)

print("[startup: Wire2Wireless]")
print("Forwarding ports:")
for index, value in ipairs(ports) do
    wire.open(value)
    wireless.open(value)
    print(value)
end

repeat
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if side == wireSide then
        wireless.transmit(channel, replyChannel, message)
    elseif side == wirelessSide then
        wire.transmit(channel, replyChannel, message)
    end
until false
