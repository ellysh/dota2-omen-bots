local constants = require(
  GetScriptDirectory() .."/utility/constants")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

---------------------------------

function M.pre_swap_items()
  return algorithms.IsBotAlive()
end

---------------------------------

local function IsBotOnBase()
  return env.FOUNTAIN_DISTANCE <= constants.BASE_RADIUS
end

function M.pre_swap_flask_tp()
  local flask_slot = env.BOT:FindItemSlot("item_flask")
  local tp_slot = env.BOT:FindItemSlot("item_tpscroll")

  return env.BOT:GetItemSlotType(flask_slot) == ITEM_SLOT_TYPE_BACKPACK
         and env.BOT:GetItemSlotType(tp_slot) == ITEM_SLOT_TYPE_MAIN
         and not IsBotOnBase()
end

function M.swap_flask_tp()
  local flask_slot = env.BOT:FindItemSlot("item_flask")
  local tp_slot = env.BOT:FindItemSlot("item_tpscroll")

  env.BOT:ActionImmediate_SwapItems(flask_slot, tp_slot)

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

function M.pre_swap_enchanted_mango_tp()
  local mango_slot = env.BOT:FindItemSlot("item_enchanted_mango")
  local tp_slot = env.BOT:FindItemSlot("item_tpscroll")

  return env.BOT:GetItemSlotType(mango_slot) == ITEM_SLOT_TYPE_BACKPACK
         and env.BOT:GetItemSlotType(tp_slot) == ITEM_SLOT_TYPE_MAIN
         and not IsBotOnBase()
end

function M.swap_enchanted_mango_tp()
  local mango_slot = env.BOT:FindItemSlot("item_enchanted_mango")
  local tp_slot = env.BOT:FindItemSlot("item_tpscroll")

  env.BOT:ActionImmediate_SwapItems(mango_slot, tp_slot)

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

function M.pre_swap_tp_flask()
  local flask_slot = env.BOT:FindItemSlot("item_flask")
  local tp_slot = env.BOT:FindItemSlot("item_tpscroll")

  return env.BOT:GetItemSlotType(flask_slot) == ITEM_SLOT_TYPE_MAIN
         and env.BOT:GetItemSlotType(tp_slot) == ITEM_SLOT_TYPE_BACKPACK
         and IsBotOnBase()
end

function M.swap_tp_flask()
  local flask_slot = env.BOT:FindItemSlot("item_flask")
  local tp_slot = env.BOT:FindItemSlot("item_tpscroll")

  env.BOT:ActionImmediate_SwapItems(flask_slot, tp_slot)

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

function M.pre_swap_tp_enchanted_mango()
  local mango_slot = env.BOT:FindItemSlot("item_enchanted_mango")
  local tp_slot = env.BOT:FindItemSlot("item_tpscroll")

  return env.BOT:GetItemSlotType(mango_slot) == ITEM_SLOT_TYPE_MAIN
         and env.BOT:GetItemSlotType(tp_slot) == ITEM_SLOT_TYPE_BACKPACK
         and IsBotOnBase()
end

function M.swap_tp_enchanted_mango()
  local mango_slot = env.BOT:FindItemSlot("item_enchanted_mango")
  local tp_slot = env.BOT:FindItemSlot("item_tpscroll")

  env.BOT:ActionImmediate_SwapItems(mango_slot, tp_slot)

  action_timing.SetNextActionDelay(0.05)
end
---------------------------------

local function GetFullSlotInBackpack(unit_data)
  for i = 6, 8 do
    if nil ~= env.BOT:GetItemInSlot(i) then
      return i
    end
  end

  return nil
end

local function GetEmptySlotInInventory(unit_data)
  for i = 0, 5 do
    if nil == env.BOT:GetItemInSlot(i) then
      return i
    end
  end

  return nil
end

function M.pre_put_item_in_inventory()
  return ((nil ~= GetFullSlotInBackpack(env.BOT_DATA))
          and (nil ~= GetEmptySlotInInventory(env.BOT_DATA)))
end

function M.put_item_in_inventory()
  env.BOT:ActionImmediate_SwapItems(
    GetFullSlotInBackpack(env.BOT_DATA),
    GetEmptySlotInInventory(env.BOT_DATA))

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

-- Provide an access to local functions for unit tests only

return M
