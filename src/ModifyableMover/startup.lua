local settingRead = fs.open("setting.json", "r")
---@type {from: string,to: string,max_amount: number|nil,filter: ({slot: number}|{id: string}|{tag: string})|nil}[]
local setting = textutils.unserialiseJSON(settingRead.readAll());
settingRead.close();
repeat
    for _, Component in ipairs(setting) do
        local Slot = -2;
        local _, reason = pcall(function()
            local from = peripheral.wrap(Component.from);
            local list = from.list()
            if Component.filter.id then
                for slot, value in ipairs(list) do
                    if value.name == Component.filter.id then
                        Slot = slot;
                    end
                end
            elseif Component.filter.slot then
                Slot = Component.filter.slot;
            else
                Slot = -1;
            end
            if Slot == -1 then
                for slot, _ in ipairs(list) do
                    from.pushItems(Component.to, slot, Component.max_amount)
                end
            else
                from.pushItems(Component.to, Slot, Component.max_amount)
            end
        end);
        if reason == "Terminated" then
            term.setTextColor(colors.red)
            print("Terminated")
            term.setTextColor(colors.white)
            return;
        end
    end
until false
