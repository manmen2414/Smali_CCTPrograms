local Channel = 31414
local TrainNameRule = "Mame%-..([0-9][0-9])"
local STypeSelector = {
    ["Something"] = 1,
    ["01"] = 3,
    ["02"] = 4
}
local FormationSelector = {
    ["Something"] = 0,
    ["01"] = 2,
    ["02"] = 1
}

local Stations = {}
local STypes = { "LOCAL", "RAPID", "EXPRS", "LEXPR", }
local STypeColors = { colors.lime, colors.yellow, colors.orange, colors.red }
local m = peripheral.find("modem")
local NW = {
    Sended = false,
    ---@enum
    TransmitType = { Next = "Next", Reply = "Reply", Reset = "Reset", Register = "register" },
    ---@param To string
    ---@param TransmitType string
    ---@param TrainName string
    ---@param Message any
    ---@param Schedule table
    createMessage = function(To, TransmitType, TrainName, Message, Schedule)
        local message = {
            TransmitID = math.random(2147483647),
            From = "TrainCore",
            FromID = os.getComputerID(),
            To = To,
            Type = TransmitType,
            TrainName = TrainName,
            Message = Message,
            Schedule = Schedule
        }
        m.transmit(Channel, Channel, message)
    end,
    createReply = function(ReceivedMessage, Message)
        local message = {
            TransmitID = ReceivedMessage.TransmitID,
            From = "TrainCore",
            FromID = os.getComputerID(),
            To = ReceivedMessage.From,
            Type = "Reply",
            ReceivedMessage = ReceivedMessage,
            Message = Message,
        }
        m.transmit(Channel, Channel, message)
    end,
    processReset = function(message)
        TrainNameRule = message.TrainNameRule;
        STypeSelector = message.STypeSelector;
        FormationSelector = message.FormationSelector;
    end
}
term.clear()
term.setCursorPos(1, 1)
term.setTextColor(colors.pink)
print("Port: " .. Channel)
term.setTextColor(colors.yellow)
print("Rule: " .. TrainNameRule)
for key, value in pairs(STypeSelector) do
    term.setTextColor(STypeColors[value])
    term.write(STypes[value] .. "/")
    term.setTextColor(colors.lightBlue)
    term.write(FormationSelector[key] .. "  ")
    term.setTextColor(colors.brown)
    term.write(key)
    print()
end
m.open(Channel)
os.startTimer(2)
local terminated = false;
repeat
    local event, side, channel, replyChannel, message, distance = os.pullEventRaw()
    if event == "modem_message" then
        if message.To == "TrainCore" then
            if message.Type == NW.TransmitType.Register then
                Stations[#Stations + 1] = message.From
                term.setTextColor(colors.white)
                term.write("Registed: ")
                term.setTextColor(colors.green)
                print(message.From)
                NW.createReply(message, "OK")
            end
        end
    elseif event == "terminate" then
        terminated = true;
    elseif event == "timer" then
        NW.createMessage("ALLSTATION", NW.TransmitType.Reset, "Core",
            {
                TrainNameRule = TrainNameRule,
                STypeSelector = STypeSelector,
                FormationSelector = FormationSelector,
                Stations =
                    Stations
            }, {})
        os.startTimer(2)
    end
until terminated
