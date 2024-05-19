local Pubilc = {};
local monitor = peripheral.find("monitor")
local Sx, Sy = monitor.getSize()
local x, y = monitor.getCursorPos()

Pubilc.keysRep = {
    ["apostrophe"] = ":",
    ["semicolon"] = ";",
    ["comma"] = ",",
    ["period"] = ".",
    ["slash"] = "/",
    ["numPadSubtract"] = "-",
    ["minus"] = "-",
    ["space"] = " "
}

---Log Yellow Message
---@param str string
function Pubilc.Warn(str)
    Pubilc.WriteLine(str, colors.yellow);
end

---Log White Message
---@param str string
function Pubilc.Print(str)
    Pubilc.WriteLine(str, colors.white);
end

---Log Red Message
---@param str string
function Pubilc.Error(str)
    Pubilc.WriteLine(str, colors.red);
end

---Scroll console
---@param count integer
function Pubilc.Scroll(count)
    monitor.scroll(count);
end

---Log Message
---@param str string
---@param color color|nil
function Pubilc.WriteLine(str, color)
    if color == nil then
        color = colors.white
    end
    monitor.setTextColor(color)
    Pubilc.Write(str)
    monitor.setTextColor(colors.white)
    if y == Sy then
        Pubilc.Scroll(1)
    else
        y = y + 1;
    end
    monitor.setCursorPos(1, y)
end

---Log Message but don't create new line
---@param str string
function Pubilc.Write(str)
    monitor.write(str)
    x, y = monitor.getCursorPos()
end

---Delete char
---@param Cantdelete integer?
function Pubilc.Backspace(Cantdelete)
    Cantdelete = Cantdelete or -1
    x, y = monitor.getCursorPos()
    if x - 1 == Cantdelete then
        return;
    end
    monitor.setCursorPos(x - 1, y)
    monitor.write(" ")
    monitor.setCursorPos(x - 1, y)
    x, y = monitor.getCursorPos()
end

---Delete chars
---@param count integer
function Pubilc.DeleteChars(count)
    for i = 1, count, 1 do
        Pubilc.Backspace();
    end
end

---Read (Y/N)
---@param question string
---@param color color|nil
function Pubilc.ReadYorN(question, color)
    local ans = Pubilc.ReadLine(question .. "(Y/N)", { "y", "Y", "yes", "no", "N", "n" }, color)
    if ans == "y" or ans == "Y" or ans == "yes" then
        return true;
    elseif ans == "n" or ans == "N" or ans == "no" then
        return false;
    else
        return Pubilc.ReadYorN("", color);
    end
end

---Read
---@param question string
---@param Ans table|nil
---@param color color|nil
---@param options table|nil For example, `{["replaces"]={["/"]="_"}}` -> / is replace to _
function Pubilc.ReadLine(question, Ans, color, options)
    options = options or {}
    repeat
        local text = "";
        if color == nil then
            color = colors.white
        end
        monitor.setTextColor(color)
        Pubilc.Write(question .. ":")
        monitor.setTextColor(colors.white)
        local event, key, is_held = os.pullEvent("key")
        monitor.setCursorBlink(true)
        -- start input
        while key ~= 257 do
            local keystr = keys.getName(key)
            for k, value in pairs(Pubilc.keysRep) do
                if keystr == k then
                    keystr = value
                end
            end
            for k, value in pairs(options["replaces"] or {}) do
                if keystr == k then
                    keystr = value
                end
            end
            -- is it special?
            if keystr == "backspace" then
                Pubilc.Backspace(#question + 1)
                Pubilc.Backspace(#question + 1)
                text = text:sub(1, #text - 1)
            elseif #keystr == 1 then
                text = text .. keystr
            end
            -- ReWrite
            Pubilc.DeleteChars(#text - 1)
            local verified = Ans == nil
            if Ans ~= nil then
                for index, value in ipairs(Ans) do
                    if value == text then
                        verified = true;
                    end
                end
            end
            if verified then
                monitor.setTextColor(colors.green)
            else
                monitor.setTextColor(colors.red)
            end
            Pubilc.Write(text)
            monitor.setTextColor(colors.white)
            --[[if options["predictive"] ~= nil then
                for index, value in ipairs(options["predictive"]) do
                    if value:startsWith(text) then
                        local writeto = value:sub(#text + 1, #value)
                    end
                end
            end]]
            x, y = monitor.getCursorPos();
            event, key, is_held = os.pullEvent("key")
        end
        monitor.setCursorBlink(false)

        local ans = text;
        if Ans == nil then
            Pubilc.WriteLine("")
            return ans;
        end
        for index, value in ipairs(Ans) do
            if value == ans then
                Pubilc.WriteLine("")
                return ans;
            end
        end
        Pubilc.WriteLine("")
        Pubilc.WriteLine("You answer is wrong.")
    until Ans == nil
    x, y = monitor.getCursorPos()
end

---# deprecated Use .ReadLine
---@param question string
---@param Ans table|nil
---@param color color|nil
---@deprecated
function Pubilc.Read(question, Ans, color)
    Pubilc.ReadLine(question, Ans, color)
end

function Pubilc.ResetConsole()
    monitor.clear();
    monitor.setCursorPos(1, 1);
    Sx, Sy = monitor.getSize()
    x, y = monitor.getCursorPos()
end

return Pubilc;
