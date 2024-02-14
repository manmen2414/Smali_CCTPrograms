-- Need to str2signal.lua
local monter = peripheral.find("monitor")
local lastvalue = ""
print("url:")
local url = read()
term.clear()
term.getCursorPos(1, 1)
while true do
    local value = http.get(url, { ["ngrok-skip-browser-warning"] = true }).readAll()
    if value == lastvalue then else
        monter.clear()
        monter.setCursorPos(1, 1)
        monter.write(value)
        lastvalue = value;
    end
    sleep(2)
end
