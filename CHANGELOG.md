* version 1.3-dr
  - Fix the recipe for PT. Now it requires gloves instead of blades.

* version 1.2-dr
  - Fix bugs with fighting with the enemy hero on low HP.
  - Rework the inventory management.
  - Fix bugs with moving to the safe spot and start position for body blocking.

* version 1.1-dr
  - Implement the blink + gust combo.
  - Implement moves for using pike and force staff.
  - Change the hero to Drow Ranger.
  - Apply Drow Ranger specific constants.
  - Remove SF specific objectives and moves.
  - Implement the skill build.
  - Implement the item build.

* version 1.0
  - Implement the blink + eul's + requiem combo.
  - Implement the eul's + requiem combo.
  - Consider a potential location of enemy hero when evading him.
  - Rework management of the inventory and backpack slots.
  - Rework the item build. Now the bot buys the 2nd wraith band, infused raindrops, eul's and blink.

* version 0.9
  - Implement the move for casting the requiem ability.
  - Implement the move for using the hood of defiance.
  - Fix bugs with moving to the base through waypoints.
  - Fix the bug when the bot stays AFK while buying items.
  - Fix the bug with stuck when turning for casting shadowraze.
  - Fix the bug with upgrading skills when the bot gains two levels at the time.

* version 0.8
  - Implement moves for using wards.
  - Implement an algorithm for moving to the safe spot through waypoints.
  - Add a strategy for the close fight with the enemy hero on low hp.
  - Keep a minimal safe distance with the enemy hero when using the flask.
  - Fix bugs with moving to the base for recovery.

* version 0.7
  - Retreat to the safe spot via waypoints.
  - Add the wait-cancel mechanism for managing the current move.
  - Use spots near towers as safe spots.
  - Improve the evading of enemy shadowrazes.
  - Improve the kiting algorithm.
  - Fix the bug when the bot evades shadowrazes which should miss.
  - Fix the bug when bot evades enemy hero which is too far.
  - Fix the bug with choosing the safe spot when enemy creeps chase.
  - Fix the bug with losing ally front creeps.

* version 0.6
  - Fix a bug with cyclic turning to the enemy hero for casting a shadowraze.
  - Rework the algorithm for canceling the backswing attack animation.
  - Change order of buying the flask and mango. The flask always comes first.
  - Make the bot behavior less aggressive for avoiding enemy shadowrazes.
  - Add extra safe spots between ally tier 1 and tier 2 towers.

* version 0.5
  - Adapt the bot for the 7.20 patch.
  - Change an item build according to the 7.20 patch.
  - Fix the bug with casting near razes.
  - Fix the bug with aggring enemy creeps when turning to the enemy hero.
  - Fix bugs with positioning.
  - Add moves for evading enemy shadowraze skills.
  - Add moves for canceling shadowraze skills when the enemy hero leaves its target area.

* version 0.4
  - Add moves to use the shadowraze skill.
  - Add moves to recover MP with mango and sticks.
  - Add the move to destroy the enemy tower when it has low HP.
  - Fix issue with swapping items between backpack and inventory slots.
  - Fix a bug with following ally creeps beyond the enemy tower.

* version 0.3
  - Apply the evaluation function to most predicates of objectives and moves.

* version 0.2
  - Implement the skill build.
  - Implement the item build.
  - Fix attack point and turn time constants for SF.

* version 0.1
  - Implement basic laning features
