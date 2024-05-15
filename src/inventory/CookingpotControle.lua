-- ## REQUIRE utils/console.lua and utils/inventoryM.lua
--cation : In lua, table cant include 0.
local pots = {};
local BasePotID = "farmersdelight:cooking_pot_";
local BPFrom = 0;

---temp storage
local storage = "minecraft:chest_4"
---Push only storage
local fromStorage = "minecraft:chest_4"

local Console = require("console")
local inventoryM = require("inventoryM")

local function makePotLikeGUI()
    term.setBackgroundColor(colors.gray)
    Console.WriteLine("Slot Preview:")
    Console.WriteLine("[1] [2] [3]        ")
    Console.WriteLine("[4] [5] [6] --> [P]")
    Console.WriteLine("    wWw     [B] [E]")
    term.setBackgroundColor(colors.black)
end

local function askPotRecipe()
    makePotLikeGUI()
    Console.WriteLine("Recipe Input ( _ -> - ):")
    local recipe = {}
    for i = 1, 6, 1 do
        recipe[i] = Console.ReadLine("Slot " .. i, nil, colors.cyan, { ["replaces"] = { ["-"] = "_" } })
        if recipe[i] == "" then
            recipe[i] = nil
        end
    end
    return recipe
end

Console.ResetConsole()
Console.WriteLine("Connected pots:", colors.cyan)
for index, value in ipairs(peripheral.getNames()) do
    if value:gmatch(BasePotID .. "[0-9]+")() ~= nil then
        pots[tonumber(value:sub(#BasePotID + 1)) + 1] = peripheral.wrap(value)
        Console.WriteLine(value, colors.orange)
    end
end

for i = 1, #pots, 1 do
    if pots[i] ~= nil then
        local Pot = pots[i]
        local PotItems = Pot.list()
        for n = 1, #PotItems, 1 do
            if PotItems[n] ~= nil then
                Console.WriteLine("Pot" .. i .. " : " .. n .. "->" .. PotItems[n].name)
                inventoryM.Move(pots[i], storage, PotItems[n].name)
            end
        end
        if PotItems[8] == nil then
            Console.Warn("Warn: Pot" .. i .. " doesnt have any bowl!")
        end
    end
end

if #pots == 0 then
    Console.Error("I don't have any pots!")
    return;
end

local mode = Console.ReadLine("(C raft/R epeat)", { "c", "r", "craft", "repeat" }, colors.lightBlue)
Console.WriteLine(textutils.serialiseJSON(askPotRecipe()))




--[[
    Pot Inventory:
    [1-6]:Craft Slot
    [7]:nil
    [8]:Bowl Slot
    [9]:Created Item
]]
