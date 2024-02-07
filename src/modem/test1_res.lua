local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(15)
local event, side, channel,replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 15
print("Received a reply: " .. tostring(message))
modem.transmit(43, 15, "Hello, world!")



