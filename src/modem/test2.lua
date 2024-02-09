local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(19132) -- Open 19132 so we can receive replies
modem.transmit(25565, 19132,value)
local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 19132

print("Received a reply: " .. tostring(message))