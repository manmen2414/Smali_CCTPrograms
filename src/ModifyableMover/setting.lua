local Potion = require("gui").Potion;
local GUI = require("gui").GUI;
local Term = Potion.termSize();
local v2 = Potion.newVector2;
local wait = GUI.WaitForAllButtonOrInput;
local settingRead = fs.open("setting.json", "r")
---@type {from: string,to: string,max_amount: number|nil,filter: ({slot: number}|{id: string}|{tag: string})|nil}[]
local setting = textutils.unserialiseJSON(settingRead.readAll());

repeat
    term.setBackgroundColor(colors.lightGray)
    Term:clear();

    local Add = GUI.Button(v2(2, 3):to(9, 3), " + Add", colors.lightBlue, colors.black, function()
        local peripherals = peripheral.getNames()
        local from, to, slot, id, count;
        Term:clear();
        GUI.Text(v2(1, 1), "Add Component", colors.orange)

        GUI.Text(v2(2, 6), "Filter(One or none): ", colors.white)

        local From = GUI.Input(v2(2, 3):to(30, 3), "[From]", colors.yellow, colors.black, false, peripherals,
            function(t) from = t; end);
        local To = GUI.Input(v2(2, 4):to(30, 4), "[To]", colors.pink, colors.black, false, peripherals,
            function(t) to = t; end);
        local Slot = GUI.Input(v2(2, 7):to(8, 7), "Slot", colors.white, colors.black, false, {},
            function(t)
                if tonumber(t) then
                    slot = tonumber(t);
                    local sucessed, name = pcall(peripheral.call, from, "getItemDetail", slot)
                    if sucessed and name then
                        GUI.Text(v2(10, 7), "slot has " .. name.name .. "                                           ",
                            colors.white, colors.lightGray)
                    end
                end
            end);
        local ID = GUI.Input(v2(2, 8):to(30, 8), "...or item id", colors.white, colors.black, false, {},
            function(t) id = t; end)
        local Count = GUI.Input(v2(2, 10):to(10, 10), "Count(any)", colors.green, colors.black, false, {}, function(t)
            if tonumber(t) then
                count = t;
            end
        end)
        local Done = GUI.Button(v2(2, 15):to(7, 15), " Done", colors.gray, colors.black,
            function() return "done"; end)
        local Cancel = GUI.Button(v2(10, 15):to(17, 15), " Cancel", colors.red, colors.black,
            function() return "cancel"; end)
        local answer = wait(From, To, Slot, ID, Count, Done, Cancel)
        if answer == "cancel" then return answer end
        if from and to then
            term.setBackgroundColor(colors.black)
            Term:clear();
            term.setCursorPos(1, 1);
            setting[#setting + 1] = { from = from, to = to, max_amount = count, filter = { id = id, slot = slot } };
            return "done";
        end
        GUI.Text(v2(2, 14), "There are missing items.", colors.black)
    end)
    local Save = GUI.Button(v2(11, 3):to(19, 3), " \25 Save", colors.lightBlue, colors.black, function()
        fs.delete("setting.json")
        local pipe = fs.open("setting.json", "w");
        pipe.write(textutils.serialiseJSON(setting))
        pipe.close();
        GUI.Text(v2(2, 2), "Saved!", colors.yellow)
    end);
    local Exit = GUI.Button(v2(21, 3):to(28, 3), " \21 Exit", colors.orange, colors.black, function()
        return "exit";
    end)
    GUI.Text(v2(1, 1), "Mover Config", colors.orange)
    GUI.Text(v2(16, 1), #setting .. " component loaded.", colors.white)
    GUI.Text(v2(1, 5), "- Components:", colors.white)
    v2(2, 6):to(50, 18):clear(colors.gray)
    local deletes = {};
    for index, conponent in ipairs(setting) do
        local filter = "";
        if conponent.filter.id then
            filter = "ID," .. conponent.filter.id;
        elseif conponent.filter.slot then
            filter = "Slot," .. conponent.filter.slot;
        else
            filter = "No Filter"
        end
        GUI.Text(v2(3, 5 + index), conponent.from .. ">" .. conponent.to .. " " .. filter, colors.white, colors.gray)
        deletes[#deletes + 1] = GUI.Button(v2(2, 5 + index):to(2, 5 + index), "x", colors.red, colors.black, function()
            local newSetting = {};
            for i, value in ipairs(setting) do
                if i ~= index then
                    newSetting[#newSetting + 1] = value;
                end
            end
            setting = newSetting;
            return "reload"
        end)
    end
    local code = wait(Add, Save, Exit, table.unpack(deletes));
    if code == "exit" then
        break;
    end
until false
