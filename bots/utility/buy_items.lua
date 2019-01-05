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

function M.pre_buy_tpscroll()
  return not algorithms.DoesBotOrCourierHaveItem("item_tpscroll")
         and GetItemCost("item_tpscroll") <= env.BOT_DATA.gold
end

function M.buy_tpscroll()
  algorithms.BuyItem("item_tpscroll")
end

---------------------------------

local function HasTwoWraithBands(unit_data)
  local counter = 0

  functions.DoWithKeysAndElements(
    unit_data.items,
    function(_, item)
      if not item:IsNull() and item:GetName() == "item_wraith_band" then
        counter = counter + 1
      end
    end)

  return counter == 2
end

function M.pre_buy_slippers()
  return pre_buy_item("item_slippers")
         and not HasTwoWraithBands(env.BOT_DATA)
         and not algorithms.IsItemPresent(
                   env.COURIER_DATA,
                   "item_wraith_band")
         and not algorithms.IsItemPresent(
                   env.COURIER_DATA,
                   "item_recipe_wraith_band")
end

function M.buy_slippers()
  algorithms.BuyItem("item_slippers")
end

---------------------------------

function M.pre_buy_circlet()
  return pre_buy_item("item_circlet")
         and algorithms.DoesBotOrCourierHaveItem("item_slippers")
         and not HasTwoWraithBands(env.BOT_DATA)
end

function M.buy_circlet()
  algorithms.BuyItem("item_circlet")
end

---------------------------------

function M.pre_buy_recipe_wraith_band()
  return pre_buy_item("item_recipe_wraith_band")
         and algorithms.DoesBotOrCourierHaveItem("item_circlet")
         and not HasTwoWraithBands(env.BOT_DATA)
end

function M.buy_recipe_wraith_band()
  algorithms.BuyItem("item_recipe_wraith_band")
end

---------------------------------

function M.pre_buy_boots()
  return pre_buy_item("item_boots")
         and HasTwoWraithBands(env.BOT_DATA)
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

function M.pre_buy_two_boots_of_elves()
  return (2 * GetItemCost("item_boots_of_elves")) <= env.BOT_DATA.gold
         and algorithms.DoesBotOrCourierHaveItem("item_power_treads")
         and not algorithms.DoesBotOrCourierHaveItem(
                   "item_boots_of_elves")
         and not algorithms.DoesBotOrCourierHaveItem(
                   "item_dragon_lance")
         and not algorithms.DoesBotOrCourierHaveItem("item_hurricane_pike")
end

function M.buy_two_boots_of_elves()
  algorithms.BuyItem("item_boots_of_elves")
  algorithms.BuyItem("item_boots_of_elves")
end

---------------------------------

function M.pre_buy_ogre_axe()
  return pre_buy_item("item_ogre_axe")
         and algorithms.DoesBotOrCourierHaveItem("item_boots_of_elves")
         and algorithms.DoesBotOrCourierHaveItem("item_power_treads")
         and not algorithms.DoesBotOrCourierHaveItem("item_dragon_lance")
         and not algorithms.DoesBotOrCourierHaveItem("item_hurricane_pike")
end

function M.buy_ogre_axe()
  algorithms.BuyItem("item_ogre_axe")
end

---------------------------------

function M.pre_buy_blink()
  return pre_buy_item("item_blink")
         and algorithms.DoesBotOrCourierHaveItem("item_dragon_lance")
end

function M.buy_blink()
  algorithms.BuyItem("item_blink")
end

---------------------------------

function M.pre_buy_ring_of_regen()
  return pre_buy_item("item_ring_of_regen")
         and algorithms.DoesBotOrCourierHaveItem("item_blink")
         and not algorithms.DoesBotOrCourierHaveItem("item_force_staff")
         and not algorithms.DoesBotOrCourierHaveItem("item_hurricane_pike")
end

function M.buy_ring_of_regen()
  algorithms.BuyItem("item_ring_of_regen")
end

---------------------------------

function M.pre_buy_staff_of_wizardry()
  return pre_buy_item("item_staff_of_wizardry")
         and algorithms.DoesBotOrCourierHaveItem("item_ring_of_regen")
         and not algorithms.DoesBotOrCourierHaveItem("item_force_staff")
         and not algorithms.DoesBotOrCourierHaveItem("item_hurricane_pike")
end

function M.buy_staff_of_wizardry()
  algorithms.BuyItem("item_staff_of_wizardry")
end

---------------------------------

function M.pre_buy_recipe_force_staff()
  return pre_buy_item("item_recipe_force_staff")
         and algorithms.DoesBotOrCourierHaveItem("item_staff_of_wizardry")
         and not algorithms.DoesBotOrCourierHaveItem("item_force_staff")
         and not algorithms.DoesBotOrCourierHaveItem("item_hurricane_pike")
end

function M.buy_recipe_force_staff()
  algorithms.BuyItem("item_recipe_force_staff")
end

---------------------------------

function M.pre_buy_recipe_hurricane_pike()
  return pre_buy_item("item_recipe_hurricane_pike")
         and algorithms.DoesBotOrCourierHaveItem("item_force_staff")
         and not algorithms.DoesBotOrCourierHaveItem("item_hurricane_pike")
end

function M.buy_recipe_hurricane_pike()
  algorithms.BuyItem("item_recipe_hurricane_pike")
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
