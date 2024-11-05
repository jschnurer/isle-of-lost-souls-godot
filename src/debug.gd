extends Node

# This script is globally loaded last. Use it to initialize variables, positions, send events,
# etc. for debug purposes. Before shipping the game, remove this file completely.

func _ready():
	Inventory.add_item(Enums.ItemSlugs.RUINS_ROD)
	Inventory.add_item(Enums.ItemSlugs.SLEDGE)
	
	await Utility.wait(.1)
	
	var tele_args = TeleportArgs.new()
	tele_args.to_scene = Enums.Scenes.RUINS_SQUARE_SOUTH
	tele_args.to_location = Vector2(462, 328)
	SignalBus.transfer_player_to_scene.emit(tele_args)
