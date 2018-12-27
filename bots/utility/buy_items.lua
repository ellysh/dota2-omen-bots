local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local hist = require(
  GetScriptDirectory() .."/utility/history")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_buy_items()
  local weights = {
    [gs.BOT_IS_INACTIVE] = -1,
    [gs.BOT_IS_ALIVE] = 0.5,
    [gs.COURIER_IS_AVAILABLE] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

local function IsEnoughGoldToBuy(item_name)
  local reserved_gold = functions.ternary(
                          env.BOT_DATA.level < 5,
                          0,
                          constants.RESERVED_GOLD)

  return (GetItemCost(item_name) + reserved_gold)
          <= env.BOT_DATA.gold
end

local function pre_buy_item(item_name)
  return not algorithms.DoesBotOrCourierHaveItem(item_name)
         and IsEnoughGoldToBuy(item_name)
end

function M.pre_buy_flask()
  return not algorithms.DoesBotOrCourierHaveItem("item_flask")
         and GetItemCost("item_flask") <= env.BOT_DATA.gold
end

function M.buy_flask()
  algorithms.BuyItem("item_flask")
end

---------------------------------

function M.pre_buy_enchanted_mango()
  return pre_buy_item("item_enchanted_mango")
         and algorithms.DoesBotOrCourierHaveItem("item_flask")
end

function M.buy_enchanted_mango()
  algorithms.BuyItem("item_enchanted_mango")
end

---------------------------------

function M.pre_buy_infused_raindrop()
  return pre_buy_item("item_infused_raindrop")
         and 0 < GetItemStockCount("item_infused_raindrop")
         and algorithms.DoesBotOrCourierHaveItem("item_flask")
end

function M.buy_infused_raindrop()
  algorithms.BuyItem("item_infused_raindrop")
end

---------------------------------
function M.pre_buy_tpscroll()
  return not algorithms.DoesBotOrCourierHaveItem("item_tpscroll")
         and GetItemCost("item_tpscroll") <= env.BOT_DATA.gold
end

function M.buy_tpscroll()
  algorithms.BuyItem("item_tpscroll")
end

---------------------------------

function M.pre_buy_slippers()
  return pre_buy_item("item_slippers")

         and not hist.BOT_HAS_2ND_WRAITH_BAND
end

function M.buy_slippers()
  algorithms.BuyItem("item_slippers")
end

---------------------------------

function M.pre_buy_circlet()
  return pre_buy_item("item_circlet")
         and algorithms.DoesBotOrCourierHaveItem("item_slippers")
         and not hist.BOT_HAS_2ND_WRAITH_BAND
end

function M.buy_circlet()
  algorithms.BuyItem("item_circlet")
end

---------------------------------

function M.pre_buy_recipe_wraith_band()
  return pre_buy_item("item_recipe_wraith_band")
         and algorithms.DoesBotOrCourierHaveItem("item_circlet")
         and not hist.BOT_HAS_2ND_WRAITH_BAND
end

function M.buy_recipe_wraith_band()
  algorithms.BuyItem("item_recipe_wraith_band")

  hist.BOT_HAS_2ND_WRAITH_BAND = true
end

---------------------------------

function M.pre_buy_boots()
  return pre_buy_item("item_boots")
         and hist.BOT_HAS_2ND_WRAITH_BAND
         and not algorithms.DoesBotOrCourierHaveItem(
                   "item_power_treads")
end

function M.buy_boots()
  algorithms.BuyItem("item_boots")
end

---------------------------------

function M.pre_buy_blades_of_attack()
  return pre_buy_item("item_blades_of_attack")
         and algorithms.DoesBotOrCourierHaveItem("item_boots_of_elves")
         and not algorithms.DoesBotOrCourierHaveItem(
                   "item_power_treads")
end

function M.buy_blades_of_attack()
  algorithms.BuyItem("item_blades_of_attack")
end

---------------------------------

function M.pre_buy_boots_of_elves()
  return pre_buy_item("item_boots_of_elves")
         and algorithms.DoesBotOrCourierHaveItem("item_boots")
         and not algorithms.DoesBotOrCourierHaveItem("item_power_treads")
end

function M.buy_boots_of_elves()
  algorithms.BuyItem("item_boots_of_elves")
end

---------------------------------

function M.pre_buy_wind_lace()
  return pre_buy_item("item_wind_lace")
         and algorithms.DoesBotOrCourierHaveItem("item_power_treads")
         and not algorithms.DoesBotOrCourierHaveItem("item_cyclone")
end

function M.buy_wind_lace()
  algorithms.BuyItem("item_wind_lace")
end

---------------------------------

function M.pre_buy_void_stone()
  return pre_buy_item("item_void_stone")
         and algorithms.DoesBotOrCourierHaveItem("item_wind_lace")
         and not algorithms.DoesBotOrCourierHaveItem("item_cyclone")
end

function M.buy_void_stone()
  algorithms.BuyItem("item_void_stone")
end

---------------------------------

function M.pre_buy_staff_of_wizardry()
  return pre_buy_item("item_staff_of_wizardry")
         and algorithms.DoesBotOrCourierHaveItem("item_void_stone")
         and not algorithms.DoesBotOrCourierHaveItem("item_cyclone")
end

function M.buy_staff_of_wizardry()
  algorithms.BuyItem("item_staff_of_wizardry")
end

---------------------------------

function M.pre_buy_recipe_cyclone()
  return pre_buy_item("item_recipe_cyclone")
         and algorithms.DoesBotOrCourierHaveItem("item_staff_of_wizardry")
         and not algorithms.DoesBotOrCourierHaveItem("item_cyclone")
end

function M.buy_recipe_cyclone()
  algorithms.BuyItem("item_recipe_cyclone")
end

---------------------------------

function M.pre_buy_observer_ward()
  local weights = {
    [gs.AW_PRESENT] = -1,
    [gs.IS_NIGHT] = 0.5,
    [gs.BOT_BUY_WARD_PERIOD_ACHIEVED] = 0.5,
  }

  return pre_buy_item("item_ward_observer")
         and gs.Evaluate(gs.GAME_STATE, weights)
end

function M.buy_observer_ward()
  algorithms.BuyItem("item_ward_observer")

  hist.WARD_BUYING_TIMESTAMP = env.CURRENT_GAME_TIME
end

---------------------------------

function M.pre_deliver_items()
  return moves.pre_deliver_items()
end

function M.deliver_items()
  moves.deliver_items()
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
