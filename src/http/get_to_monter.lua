local monter = peripheral.find("monter")
local url
local lastvalue = ""
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
