local Public = {}

---Move by itemID
---@param from table|string InventoryPeripheral or PeripheralID
---@param to table|string InventoryPeripheral or PeripheralID
---@param itemID string ItemID
---@param Maxcount integer? 1~64 nil:64
---@param toslot integer? If nil,Move to near slot
---@return boolean,string? [2]:If failed, In a reason
function Public.Move(from, to, itemID, Maxcount, toslot)
    if Maxcount == nil then
        Maxcount = 64
    end
    local From = Public.ParsePeripheral(from);
    local To = Public.ParsePeripheral(to);
    if From == nil or To == nil or itemID == nil then
        return false, "from,to,or itemID is nil"
    end
    local FromList = From.list()
    local ToList = To.list()
    if toslot == nil then
        local Success = false;
        for i = 1, To.size(), 1 do
            if ToList[i] == nil then
                Success = true
                toslot = i
            end
        end
        if not Success then
            return false, "To doesnt have enough slot"
        end
    elseif ToList[toslot] ~= nil or toslot > To.size() then
        return false, "Slot is not open"
    end
    local FromSlot = 0;
    for index = 1, From.size(), 1 do
        local value = FromList[index]
        if value ~= nil then
            if value.name == itemID then
                FromSlot = index
            end
        end
    end
    if FromSlot == 0 then
        return false, "From doesnt have item"
    end
    local Transed = From.pushItems(peripheral.getName(To), FromSlot, Maxcount, toslot)
    if Transed < 1 then
        return false, "Move failed"
    elseif Transed < Maxcount then
        return true, "less than Maxcount"
    elseif Transed >= Maxcount then
        return true, "Success!"
    end
    return false, "Move failed(uncaugt)"
end

---If it has item of id.
---@param inventory table|string InventoryPeripheral or PeripheralID
---@param id string ItemID
---@return boolean,integer
function Public.IsHasItem(inventory, id)
    for index = 1, inventory.size(), 1 do
        local value = inventory[index]
        if value ~= nil then
            if value.name == inventory then
                return true, index
            end
        end
    end
    return false, -1
end

---@param IDorPeripheral table|string InventoryPeripheral or PeripheralID
---@return table|nil,boolean
function Public.ParsePeripheral(IDorPeripheral)
    if type(IDorPeripheral) == "string" then
        return peripheral.wrap(IDorPeripheral), true
    elseif type(IDorPeripheral) == "table" then
        return IDorPeripheral, true
    end
    return nil, false
end

return Public;
