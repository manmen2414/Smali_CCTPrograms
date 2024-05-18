-- # need http/WebHookDiscord.lua
local monitor = peripheral.wrap("monitor_7")
local time = 0.05;
local url =
"https://discord.com/api/webhooks/1137377531322970205/LlMskpsrv8CDMZtFHNkyqfjPSjpku0i19QGQB7r9BFHOVpJIAsICQ7yWd4i3v6it1BCJ"
local WebHook = require("WebhookDiscord")
local sendtext = "Someone approached.<@778582802504351745>"
local showtext = { "STOP!", "If you go,", "you will be PUNISHED." }
local sended = false;
monitor.setTextColor(colors.red)
monitor.setTextScale(2)
repeat
    if redstone.getInput("front") and not sended then
        WebHook(url, sendtext, "CC:Tweaked", "https://tweaked.cc/pack-26318f36.png")
        sended = true;
        for index, value in ipairs(showtext) do
            for i = 1, #value, 1 do
                monitor.write(value:sub(i, i))
                sleep(time)
            end
            local _, y = monitor.getCursorPos();
            monitor.setCursorPos(1, y + 1)
        end
        sleep(3)
    end
    if not redstone.getInput("front") and sended then
        sended = false;
        monitor.clear()
        monitor.setCursorPos(1, 1)
    end
    sleep(0.1)
until false
