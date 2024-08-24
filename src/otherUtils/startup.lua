local programs = {

}



local function ColorPrint(text, color)
    if term.isColor then
        term.setTextColor(color)
    end
    print(text)
    term.setTextColor(colors.white)
end

local SUfs = fs.open("startup.lua", "r")
local BstartupSplited = {}
local BstartupAll = SUfs.readAll();
SUfs.close();
SUfs = fs.open("startup.lua", "r")
while true do
    local BstartupLine = SUfs.readLine()
    if BstartupLine == nil then
        SUfs.close();
        break;
    else
        BstartupSplited[#BstartupSplited + 1] = BstartupLine
    end
end

local function check()
    SUfs = fs.open("startup.lua", "r")
    if BstartupAll ~= SUfs.readAll() then
        local AstartupSplited = {}
        SUfs.close()
        SUfs = fs.open("startup.lua", "r")
        while true do
            local AstartupLine = SUfs.readLine()
            if AstartupLine == nil then
                SUfs.close();
                break;
            else
                AstartupSplited[#AstartupSplited + 1] = AstartupLine
            end
        end
        term.clear()
        term.setCursorPos(1, 1)
        ColorPrint("Exited", colors.red)
        ColorPrint("startup changed!", colors.yellow)
        term.write("startup name:")
        local name = read();
        local TSUfs = fs.open(name .. ".lua", "w")
        for index, value in ipairs(AstartupSplited) do
            TSUfs.writeLine(value)
        end
        TSUfs.close()
        fs.delete("startup.lua")
        SUfs = fs.open("startup.lua", "w")
        for index, value in ipairs(BstartupSplited) do
            if index == 2 then
                SUfs.writeLine("\"" .. name .. "\",")
            end
            SUfs.writeLine(value)
        end
        SUfs.close()
    end
end

local rawexit = shell.exit
local rawsreboot = shell.reboot
local raworeboot = os.reboot

shell.exit = function()
    check()
    rawexit()
end

shell.reboot = function()
    check()
    rawsreboot()
end


os.reboot = function()
    check()
    raworeboot()
end


term.clear()
term.setCursorPos(1, 1)
if #programs == 0 then
    shell.run("shell")
else
    programs[#programs + 1] = "Craftos"
    local selecting = 1
    while true do
        term.clear()
        term.setCursorPos(1, 1)
        print("Boot Menu")
        local Enter = "";
        for index, value in ipairs(programs) do
            if selecting == index then
                term.write("\16")
                Enter = value
            else
                term.write(" ")
            end
            print(" " .. index .. ". " .. value)
        end
        local _, key, _ = os.pullEvent("key")
        if keys.getName(key) == "up" and (selecting ~= 1) then
            selecting = selecting - 1;
        elseif keys.getName(key) == "down" and (selecting ~= #programs) then
            selecting = selecting + 1;
        elseif keys.getName(key) == "enter" then
            term.clear()
            term.setCursorPos(1, 1)
            if Enter == "Craftos" then
                shell.run("shell")
            else
                shell.run(Enter)
            end
            break;
        end
    end
end
check()


rawexit()
