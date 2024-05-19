term.clear()
term.setCursorPos(1, 1);
local ApproachedRedStoneSide = { "front" }
local Channel = 31414
local ModemIsWireless = true
--[[local TrainNameRule = "Mame%-..([0-9][0-9])"
local STypeSelector = {
    ["Something"] = 1,
    ["01"] = 1,
    ["02"] = 3
}
local FormationSelector = {
    ["Something"] = 0,
    ["01"] = 2,
    ["02"] = 1
}]]
local TrainNameRule = "(.+)"
local STypeSelector = { ["Something"] = 1 }
local FormationSelector = { ["Something"] = 0 }

local modem = nil;
local station = peripheral.find("Create_Station")
local CannnotCoreConnecon = 0;
local CheckConnected = false;
local monitors = {}
local Registed = false;
local NextTrainID = "Something"
local NextTrainName = "Something"
local QueuedTrainID = "Something"
local QueuedTrainName = "Something"
local WentTrainID = "_"
local peripherals = peripheral.getNames()
local STypes = { "LOCAL", "RAPID", "EXPRS", "LEXPR", }
local STypeColors = { colors.lime, colors.yellow, colors.orange, colors.red }
local Poses = {
    ["Type"] = { 1, 1 },
    ["Name"] = { 6, 1 },
    ["Posion"] = { 1, 2 },
    ["Station"] = { 1, 3 },
    ["Time"] = { 15, 3 },
}
local CPrint = function(t, c)
    if term.isColor then
        term.setTextColor(c)
    end
    print(t)
    term.setTextColor(colors.white)
end
local function ToALLMonitor(act, ...)
    for index, value in ipairs(monitors) do
        value[act](...)
    end
end
local function Modem(action, ...)
    if type(modem) == "table" then
        return modem[action](...)
    end
    return nil
end

if ModemIsWireless then
    for index, value in ipairs({ "left", "right", "top", "bottom", "back", "front" }) do
        local sideP = peripheral.wrap(value) or {}
        if ((sideP.isWireless) or (function() return false; end))() then
            modem = sideP;
            break;
        end
        if index == 6 then
            modem = "Not Found"
        end
    end
else
    modem = peripherals.find("modem") or "Not Found"
end

print(modem)
if modem == "Not Found" then
    CPrint("No wireless mode!", colors.yellow)
end
local TransmitedMessage = {}
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
            From = station.getStationName(),
            FromID = os.getComputerID(),
            To = To,
            Type = TransmitType,
            TrainName = TrainName,
            Message = Message,
            Schedule = Schedule
        }
        TransmitedMessage[#TransmitedMessage + 1] = message
        if not Sended then
            Modem("transmit", Channel, Channel, message)
        end
        Sended = true;
    end,
    createReply = function(ReceivedMessage, Message)
        local message = {
            TransmitID = ReceivedMessage.TransmitID,
            From = station.getStationName(),
            FromID = os.getComputerID(),
            To = ReceivedMessage.From,
            Type = "Reply",
            ReceivedMessage = ReceivedMessage,
            Message = Message,
        }
        Modem("transmit", Channel, Channel, message)
    end,
    processReset = function(m)
        TrainNameRule = m.Message.TrainNameRule;
        STypeSelector = m.Message.STypeSelector;
        FormationSelector = m.Message.FormationSelector;
    end
}

CPrint("Connected monitors:", colors.lime)
for index, value in ipairs(peripherals) do
    if value:match("monitor_[0-9]+") then
        monitors[#monitors + 1] = peripheral.wrap(value)
        print(tonumber(value:sub(9)) .. " : " .. value)
    end
end
ToALLMonitor("clear")
ToALLMonitor("setCursorPos", 1, 1)
ToALLMonitor("setTextScale", 1.5)
ToALLMonitor("write", "Connected!")

ToALLMonitor("clear")
ToALLMonitor("setCursorPos", 1, 1)
local terminated = false;
NW.createMessage("TrainCore", NW.TransmitType.Register, "", nil, {})
Modem("open", Channel)
os.startTimer(0.25)
repeat
    local event, side, channel, replyChannel, message, distance = os.pullEventRaw()
    if event == "terminate" then
        terminated = true;
    elseif event == "modem_message" then
        local ToMY = message.To == station.getStationName() or message.To == "ALLSTATION"
        if message.Type == NW.TransmitType.Next and ToMY then
            local TrainID = string.match(message.TrainName, TrainNameRule) or "Something"
            QueuedTrainID = TrainID
            QueuedTrainName = message.TrainName
        elseif message.Type == NW.TransmitType.Reset and ToMY then
            local x, y = term.getCursorPos()
            term.setCursorPos(46, 1)
            term.write("     ")
            term.setCursorPos(x, y)
            if CannnotCoreConnecon > 16 then
                NW.createMessage("TrainCore", NW.TransmitType.Register, "", nil, {})
            end
            CannnotCoreConnecon = 0;
            NW.processReset(message);
        elseif message.Type == NW.TransmitType.Reply and ToMY then
            if message.ReceivedMessage.Type == NW.TransmitType.Register then
                Registed = true;
            end
        end
    elseif event == "timer" then
        CannnotCoreConnecon = CannnotCoreConnecon + 1
        if CannnotCoreConnecon > 16 then
            local x, y = term.getCursorPos()
            term.setCursorPos(46, 1)
            term.setTextColor(colors.red)
            term.write("\42Core")
            term.setCursorPos(x, y)
            term.setTextColor(colors.white)
        end
        --#region Write Situation
        local SpeedType = STypeSelector[NextTrainID] or 1
        if NextTrainID ~= WentTrainID then
            ToALLMonitor("setCursorPos", table.unpack(Poses["Type"]))
            ToALLMonitor("setTextColor", STypeColors[SpeedType])
            ToALLMonitor("write", STypes[SpeedType])
            ToALLMonitor("setCursorPos", table.unpack(Poses["Name"]))
            ToALLMonitor("setTextColor", colors.white)
            ToALLMonitor("write", NextTrainName .. "                                 ")
        else
            ToALLMonitor("setCursorPos", table.unpack(Poses["Type"]))
            ToALLMonitor("write", "                                ")
        end
        ToALLMonitor("setCursorPos", table.unpack(Poses["Posion"]))
        if station.isTrainPresent() then
            ToALLMonitor("setTextColor", colors.green)
            ToALLMonitor("write", " Train Approached   ")
        elseif station.isTrainImminent() then
            ToALLMonitor("setTextColor", colors.red)
            ToALLMonitor("write", "\04Train Approaching")
        elseif station.isTrainEnroute() then
            ToALLMonitor("setTextColor", colors.yellow)
            ToALLMonitor("write", "\03Train Enrouteing  ")
        else
            ToALLMonitor("write", "                    ")
            if not Sended then
                NextTrainID = QueuedTrainID
                NextTrainName = QueuedTrainName
            end
            for _, value in ipairs(ApproachedRedStoneSide) do
                redstone.setOutput(value, false)
            end
        end
        ToALLMonitor("setCursorPos", table.unpack(Poses["Station"]))
        ToALLMonitor("setTextColor", colors.gray)
        ToALLMonitor("write", station.getStationName())
        ToALLMonitor("setCursorPos", table.unpack(Poses["Time"]))
        ToALLMonitor("setTextColor", colors.brown)
        if #textutils.formatTime(os.time("local"), true) == 4 then
            ToALLMonitor("write", "0" .. textutils.formatTime(os.time("local"), true))
        else
            ToALLMonitor("write", textutils.formatTime(os.time("local"), true))
        end
        --#endregionWrite Situation
        --#region TrainPresentActions
        if station.isTrainPresent() then
            if not Sended then
                for _, value in ipairs(ApproachedRedStoneSide) do
                    redstone.setOutput(value, true)
                end
                if station.isTrainPresent() and station.hasSchedule() then
                    local Sch = station.getSchedule()
                    local MyID = -1;
                    local To = ""
                    for index, entrie in ipairs(Sch.entries) do
                        if station.isTrainPresent() and entrie.instruction.data.text == station.getStationName() then
                            MyID = index;
                            break;
                        end
                    end
                    if MyID > -1 then
                        local next = Sch.entries[MyID + 1]
                        if next == nil then
                            next = Sch.entries[1]
                        end

                        if station.isTrainPresent() and next ~= nil then
                            To = next.instruction.data.text
                            NW.createMessage(To, NW.TransmitType.Next, station.getTrainName(), nil, Sch)
                        end
                    end
                end
            end
        else
            if Sended then
                Sended = false;
                WentTrainID = NextTrainID
                NextTrainID = QueuedTrainID
                NextTrainName = QueuedTrainName
            end
        end
        --#endregion TrainPresentActions
        os.startTimer(0.25)
    end
until terminated
