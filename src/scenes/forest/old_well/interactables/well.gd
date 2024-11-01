extends "res://src/events/game_event/base_event.gd"

func interact():
	Inventory.add_item(Enums.ItemSlugs.FLASHLIGHT, 1)
	Inventory.add_item(Enums.ItemSlugs.FISH_STONE, 1)
	Inventory.add_item(Enums.ItemSlugs.NAIL, 1)
	print ("got items")
