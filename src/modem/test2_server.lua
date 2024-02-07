local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(25565) -- Open 25565 so we can receive replies
local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 25565
modem.transmit(19132, 25565,array[message])
print("Received a reply: " .. tostring(message))