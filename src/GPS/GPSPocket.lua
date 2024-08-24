---(Advanced) Player Detector Pocket Computer is requested.
local function RequireSafe(path)
    local sucessed, answer = pcall(require, path)
    if sucessed then
        return answer;
    end
    return false;
end
local Position = RequireSafe("position")
local health = RequireSafe("health")
local teamview = RequireSafe("teamview")

term.clear();
term.setCursorPos(1, 1);
print("GPS+ Pocket v1.1.0")

local Getdimensions = function(player)
    local dimensions = {
        ["minecraft:overworld"] = colors.green,
        ["minecraft:the_nether"] = colors.red,
        ["allthemodium:the_beyond"] = colors.yellow
    }
    if dimensions[player] then
        return dimensions[player];
    end
    return colors.white
end
---@type [string, number, number, number, string, number][]
local posArray = {};
local framerate = 0.25;
local function Writer()
    for index, value in ipairs(posArray) do
        term.setCursorPos(1, index * 2)
        term.setTextColor(colors.white)
        if (teamview) then
            term.setTextColor(teamview(value[1]))
        end
        print(value[1])
        if value[2] == nil then
            term.setTextColor(colors.red)
            term.write("Failed to get data.")
        else
            term.setTextColor(Getdimensions(value[5]))
            term.write(("%-4d %-3d %-4d"):format(value[2], value[3], value[4]))
            term.setTextColor(colors.white)
            term.write(" | ")
            if (health) then
                local PlayerHealth = health(value[1])
                if 10 < PlayerHealth then
                    term.setTextColor(colors.lime)
                elseif 5 < PlayerHealth then
                    term.setTextColor(colors.orange)
                else
                    term.setTextColor(colors.red)
                end
                term.write(string.format("%2d", PlayerHealth))
            end
            term.setTextColor(colors.white)
            term.write(" |")
        end
        print("                                                  ")
    end
end
os.startTimer(framerate)
repeat
    local event, side, x, y = os.pullEventRaw();
    if event == "timer" then
        posArray = Position()
        Writer()
        os.startTimer(framerate)
    elseif event == "terminate" then
        return true;
    end
until false
return true;
