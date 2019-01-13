local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local hist = require(
  GetScriptDirectory() .."/utility/history")

local M = {}

---------------------------------

function M.pre_swap_items()
  local weights = {
    [gs.BOT_IS_INACTIVE] = -1,
    [gs.BOT_IS_ALIVE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_swap_flask_for_recovery()
  local flask_slot = env.BOT:FindItemSlot("item_flask")

  return env.BOT:GetItemSlotType(flask_slot) == ITEM_SLOT_TYPE_BACKPACK
         and env.IS_BOT_LOW_HP
end

function M.swap_flask_for_recovery()
  local flask_slot = env.BOT:FindItemSlot("item_flask")

  env.BOT:ActionImmediate_SwapItems(flask_slot, 0)

  hist.SWAP_BACKPACK_TIMESTAMP = env.CURRENT_GAME_TIME

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

function M.pre_swap_mango_for_recovery()
  local mango_slot = env.BOT:FindItemSlot("item_enchanted_mango")

  return env.BOT:GetItemSlotType(mango_slot) == ITEM_SLOT_TYPE_BACKPACK
         and gs.GAME_STATE[gs.BOT_IS_LOW_MP] == 1
end

function M.swap_mango_for_recovery()
  local mango_slot = env.BOT:FindItemSlot("item_enchanted_mango")

  env.BOT:ActionImmediate_SwapItems(mango_slot, 0)

  hist.SWAP_BACKPACK_TIMESTAMP = env.CURRENT_GAME_TIME

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

local function DoesCourierHaveFlask()
  return env.COURIER_DATA ~= nil
         and algorithms.IsItemPresent(env.COURIER_DATA, "item_flask")
         and functions.GetUnitDistance(env.COURIER_DATA, env.BOT_DATA)
             <= constants.COURIER_NEAR_BOT_DISTANCE
end

local function GetFullSlotInBackpack(unit_data, ignore_items)
  for i = constants.BACKPACK_START_INDEX, constants.BACKPACK_END_INDEX do
    local item = unit_data.handle:GetItemInSlot(i)
    if item ~= nil
       and not functions.IsElementInList(
                 ignore_items,
                 item:GetName(),
                 false) then
      return i
    end
  end

  return nil
end

local function GetEmptySlotInInventory(unit_data)
  for i = constants.INVENTORY_START_INDEX, constants.INVENTORY_END_INDEX do
    local item = unit_data.handle:GetItemInSlot(i)
    if item == nil then
      return i
    end
  end

  return nil
end

function M.pre_put_item_in_inventory()
  return ((nil ~= GetFullSlotInBackpack(env.BOT_DATA, {}))
          and (nil ~= GetEmptySlotInInventory(env.BOT_DATA)))
          and not DoesCourierHaveFlask()
end

function M.put_item_in_inventory()
  env.BOT:ActionImmediate_SwapItems(
    GetFullSlotInBackpack(env.BOT_DATA, {}),
    GetEmptySlotInInventory(env.BOT_DATA))

  hist.SWAP_BACKPACK_TIMESTAMP = env.CURRENT_GAME_TIME

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

local function GetEmptySlotInBackpack(unit_data)
  for i = constants.BACKPACK_START_INDEX, constants.BACKPACK_END_INDEX do
    local item = unit_data.handle:GetItemInSlot(i)
    if item == nil then
      return i
    end
  end

  return nil
end

function M.pre_put_wraith_band_in_backpack()
  local wb_slot = env.BOT:FindItemSlot("item_wraith_band")

  return DoesCourierHaveFlask()
         and env.BOT:GetItemSlotType(wb_slot) == ITEM_SLOT_TYPE_MAIN
         and nil ~= GetEmptySlotInBackpack(env.BOT_DATA)
         and nil == GetEmptySlotInInventory(env.BOT_DATA)
         and gs.GAME_STATE[gs.BOT_HP_RATE] < 0.5
end

function M.put_wraith_band_in_backpack()
  local wb_slot = env.BOT:FindItemSlot("item_wraith_band")

  env.BOT:ActionImmediate_SwapItems(
    wb_slot,
    GetEmptySlotInBackpack(env.BOT_DATA))

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

local FLASK_AND_MANGO_LIST = {"item_flask", "item_enchanted_mango"}

function M.pre_swap_flask_to_backpack()
  local flask_slot = env.BOT:FindItemSlot("item_flask")
  local backpack_slot = GetFullSlotInBackpack(
                          env.BOT_DATA,
                          FLASK_AND_MANGO_LIST)

  return backpack_slot ~= nil
         and env.BOT:GetItemSlotType(flask_slot) == ITEM_SLOT_TYPE_MAIN
end

function M.swap_flask_to_backpack()
  local flask_slot = env.BOT:FindItemSlot("item_flask")
  local backpack_slot = GetFullSlotInBackpack(
                          env.BOT_DATA,
                          FLASK_AND_MANGO_LIST)

  env.BOT:ActionImmediate_SwapItems(flask_slot, backpack_slot)

  hist.SWAP_BACKPACK_TIMESTAMP = env.CURRENT_GAME_TIME

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

function M.pre_swap_mango_to_backpack()
  local mango_slot = env.BOT:FindItemSlot("item_enchanted_mango")
  local backpack_slot = GetFullSlotInBackpack(
                          env.BOT_DATA,
                          FLASK_AND_MANGO_LIST)

  return backpack_slot ~= nil
         and env.BOT:GetItemSlotType(mango_slot) == ITEM_SLOT_TYPE_MAIN
         and gs.GAME_STATE[gs.BOT_IS_LOW_MP] == 0
end

function M.swap_mango_to_backpack()
  local mango_slot = env.BOT:FindItemSlot("item_enchanted_mango")
  local backpack_slot = GetFullSlotInBackpack(
                          env.BOT_DATA,
                          FLASK_AND_MANGO_LIST)

  env.BOT:ActionImmediate_SwapItems(mango_slot, backpack_slot)

  hist.SWAP_BACKPACK_TIMESTAMP = env.CURRENT_GAME_TIME

  action_timing.SetNextActionDelay(0.05)
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
