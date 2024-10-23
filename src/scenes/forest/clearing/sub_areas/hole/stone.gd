extends "res://src/events/game_event/base_event.gd"

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_STONE)):
		call_deferred("queue_free")
	else:
		super._ready()

func investigate():
	SignalBus.show_message.emit(GameScript.Forest_Clearing_Hole_Stone_Look, false)

func take():
	Inventory.add_item(Enums.ItemSlugs.FISH_STONE)
	SignalBus.show_message.emit(GameScript.Forest_Clearing_Hole_Stone_Take, false)
	await SignalBus.message_closed
	GameVars.set_var(Enums.Vars.TOOK_STONE, true)
	call_deferred("queue_free")

func interact():
	var message = "If you wanted to use it, you'd have to take it first."
	SignalBus.show_message.emit(message, false)
