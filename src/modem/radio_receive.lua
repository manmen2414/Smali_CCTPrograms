local modem = peripheral.find("modem") or error("No modem attached", 0)
local speaker = peripheral.find("speaker") or error("No speaker attached", 0)
local receive = 72
modem.open(receive)

local event, side, channel, replyChannel, message, distance

local i = false

while true do
    repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == receive
    print("Received Song URL: ", tostring(message))
    shell.run("speaker play", message)
end
