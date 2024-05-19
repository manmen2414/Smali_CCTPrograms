--#require monitor.lua
local Monitor = require("monitor")
local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")
monitor.setTextScale(0.5)
Monitor.ResetConsole()
repeat
    modem.open(31414)
    local event, side, channel, replyChannel, M, distance = os.pullEvent("modem_message")

    monitor.setTextColor(colors.yellow)
    Monitor.Write(M.Type .. " ")
    monitor.setTextColor(colors.white)
    Monitor.Write(M.From .. "\26" .. M.To .. " ")
    monitor.setTextColor(colors.green)
    Monitor.Write((M.TrainName or "nil") .. " ")
    if M.Message then
        Monitor.WriteLine(textutils.serialiseJSON(M.Message), colors.gray)
    else
        Monitor.WriteLine("(nil)", colors.gray)
    end
until false
