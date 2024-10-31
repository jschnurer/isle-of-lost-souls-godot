extends "res://src/events/game_event/base_event.gd"

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_STONE)):
		call_deferred("queue_free")
	else:
		super._ready()

func investigate():
	Utility.show_message(GameScript.Forest_Clearing_Hole_Stone_Look)

func take():
	Inventory.add_item(Enums.ItemSlugs.FISH_STONE)
	await Utility.show_message(GameScript.Forest_Clearing_Hole_Stone_Take)
	GameVars.set_var(Enums.Vars.TOOK_STONE, true)
	call_deferred("queue_free")
