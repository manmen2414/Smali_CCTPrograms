local Terminated = false;
local errorCount = -1;

local function bootGPS()
    --[[local _, NormalGPS = pcall(require, "GPS")
    local _, PocketGPS = pcall(require, "GPSPocket")
    if NormalGPS == "Terminated" or PocketGPS == "Terminated" then
        print("Terminated...")
        return true;
    end]]
    local NormalGPSSucessed = shell.execute("GPS")
    local PocketGPSSucessed = shell.execute("GPSPocket")
    if NormalGPSSucessed or PocketGPSSucessed then
        return true;
    end
    return false;
end
repeat
    errorCount = errorCount + 1
    Terminated = bootGPS()
until Terminated;
print("----Terminated----")
print("errorCount: " .. errorCount)
