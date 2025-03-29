---@enum ValueType
local valueType = {
  Item = "item",
  Block = "block",
  Entity = "entity",
  List = "list",
  NBT = "nbt",
  Ingredients = "ingredients",
  Recipe = "recipe",
  Fluid = "fluid",
  Operator = "operator",
  Unknown = "unknown"
}

---@param nbt {id:string,Count:number,tag:table}
local function valueItem(nbt)
  ---@class ValueItem
  local obj = {
    ValueType = valueType.Item,
    id = nbt.id,
    count = nbt.Count,
    nbt = nbt.tag,
    rawNBT = nbt
  }
  return obj;
end

---@param nbt {FluidName:string,Amount:number}
local function valueFluid(nbt)
  ---@class ValueFluid
  local obj = {
    ValueType = valueType.Fluid,
    id = nbt.FluidName,
    amount = nbt.Amount,
    rawNBT = nbt
  }
  return obj;
end

---@param nbt {Name:string,Properties:table}
local function valueBlock(nbt)
  ---@class ValueBlock
  local obj = {
    ValueType = valueType.Block,
    id = nbt.Name,
    blockState = nbt.Properties,
    rawNBT = nbt
  }
  return obj;
end

---@param nbt table
local function valueList(nbt)
  ---@class ValueList
  local obj = {
    ValueType = valueType.List,
    list = nbt.serialized.values,
    type = nbt.serialized.valueType,
    rawNBT = nbt
  }
  return obj;
end

---@param nbt string
local function valueEntity(nbt)
  ---@class ValueEntity
  local obj = {
    ValueType = valueType.Entity,
    uuid = nbt,
    rawNBT = nbt
  }
  return obj;
end

local function valueNBT(nbt)
  ---@class ValueNBT
  local obj = {
    ValueType = valueType.NBT,
    nbt = nbt.v,
    rawNBT = nbt
  }
  return obj;
end

---@param nbt {["minecraft:energy"]:number[]|nil,["minecraft:fluidstack"]:table[]|nil,["minecraft:itemstack"]:table[]|nil}
local function valueIngredients(nbt)
  ---@type ValueFluid[]
  local fluids = {};
  for index, value in ipairs(nbt["minecraft:fluidstack"] or {}) do
    fluids[#fluids + 1] = valueFluid(value)
  end
  ---@type ValueItem[]
  local items = {};
  for index, value in ipairs(nbt["minecraft:itemstack"] or {}) do
    items[#items + 1] = valueItem(value)
  end
  ---@class ValueIngredients
  local obj = {
    ValueType = valueType.Ingredients,
    energys = nbt["minecraft:energy"] or {},
    fluids = fluids,
    items = items,
    rawNBT = nbt,
  }
  return obj;
end
---@param nbt table
local function valueRecipe(nbt)
  ---@class ValueRecipe
  local obj = {
    ValueType = valueType.Recipe,
    nbt = nbt,
    rawNbt = nbt,
  }
  return obj;
end

---@param nbt table|string
local function valueOperator(nbt)
  local isBase = type(nbt) == "string";
  if (isBase) then
    ---@class ValueBaseOperator
    local obj = {
      ValueType = valueType.Operator,
      isBase = true,
      operatorName = "" .. nbt,
      rawNBT = nbt,
    }
    return obj;
  else
    local serializer = nbt.serializer;
    ---@class ValueOperator
    local obj = {
      ValueType = valueType.Operator,
      isBase = false,
      isApplied = serializer == "integrateddynamics:curry",
      isPiped = serializer == "integrateddynamics:combined.pipe",
      serializer = serializer,
      ---@type (table|ValueOperator)[]
      value = {},
      baseOperator = valueOperator(nbt.value.baseOperator),
      rawNBT = nbt,
    }
    if obj.isApplied then
      obj.value = nbt.value.values;
    elseif obj.isPiped then
      local values = {};
      for _, value in ipairs(nbt.value.operators) do
        values[#values + 1] = valueOperator(value.v);
      end
    end
    return obj;
  end
end

---@param nbt table
local function valueUnknown(nbt)
  ---@class ValueUnknown
  local obj = {
    ValueType = valueType.Unknown,
    nbt = nbt,
    rawNBT = nbt,
  }
  return obj;
end

---@param type string
---@param nbt any
---@return string|number|boolean|table|nil|ValueItem|ValueBlock|ValueEntity|ValueUnknown
local function serialiseObject(type, nbt)
  local function returnSelf(v) return v end;
  local processing = {
    string = returnSelf,
    double = returnSelf,
    long = returnSelf,
    integer = returnSelf,
    boolean = function(v)
      return v == 1;
    end,
    itemstack = valueItem,
    block = valueBlock,
    entity = valueEntity,
    list = valueList,
    nbt = valueNBT,
    fluidstack = valueFluid,
    ingredients = valueIngredients,
    recipe = valueRecipe,
    operator = valueOperator

  }
  if processing[type] then
    return processing[type](nbt);
  else
    return valueUnknown(nbt);
  end
end


---@param cableNBT table
---@return string|number|boolean|table|nil|ValueItem|ValueBlock|ValueEntity|ValueUnknown
local function get(cableNBT)
  local parts = cableNBT.partContainer.parts;
  local display = { -1 };
  for _, part in ipairs(parts) do
    if (part.__partType == "integrateddynamics:display_panel") then
      display = part;
    end
  end
  if display[1] == -1 then return nil; end;
  if not display.displayValueType then return nil; end;
  local displayValueType = display.displayValueType;
  local obj = serialiseObject(displayValueType:match("integrateddynamics:([a-zA-Z0-9_]+)"), display.displayValue);
  return obj;
end

return {
  get = get,
  ValueType = valueType,
  serialiseObject = serialiseObject
}
