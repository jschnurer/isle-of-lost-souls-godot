extends "res://src/events/game_event/base_event.gd"

func interact():
	Inventory.add_item(Enums.ItemSlugs.FLASHLIGHT, 1)
	print ("got flashlight")
