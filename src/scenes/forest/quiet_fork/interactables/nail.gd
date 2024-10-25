extends "res://src/events/game_event/base_event.gd"

@export var nail_missing_texture: Texture2D

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_NAIL)):
		queue_free()
	else:
		super._ready()

func investigate():
	SignalBus.show_message.emit(GameScript.Forest_Quiet_Fork_Nail_Look, false)

func take():
	SignalBus.show_message.emit(GameScript.Forest_Quiet_Fork_Nail_Take, false)
	Inventory.add_item(Enums.ItemSlugs.NAIL)
	GameVars.set_var(Enums.Vars.TOOK_NAIL, true)
	await SignalBus.message_closed
	$"../SceneBG".set_bg_texture(nail_missing_texture)
	queue_free()

func interact():
	SignalBus.show_message.emit(GameScript.Global_No_Mechanism_To_Interact, false)

func use_item(_item: Item):
	SignalBus.show_message.emit(GameScript.Global_No_Effect, false)
