extends "res://src/events/game_event/base_event.gd"

func investigate():
	if (GameVars.get_var(Enums.Vars.DISTRACTED_FISH)):
		Utility.show_message(GameScript.get_entry("Forest.Bridge_South.River_Look_No_Fish"))
	else:
		Utility.show_message(GameScript.get_entry("Forest.Bridge_South.River_Look"))

func take():
	Utility.show_message(GameScript.get_entry("Forest.Bridge_South.River_Take"))

func use_item(item: Item):
	if (item.slug == Enums.ItemSlugs.FISH_STONE):
		Utility.show_message(GameScript.get_entry("Forest.Bridge_South.River_Use_Stone"))
		Inventory.remove_item(Enums.ItemSlugs.FISH_STONE)
		GameVars.set_var(Enums.Vars.DISTRACTED_FISH, true)
