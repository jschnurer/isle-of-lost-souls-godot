extends "res://src/events/game_event/base_event.gd"

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_NAIL)):
		$Sprite2D.region_rect = Rect2(43, 0, 43, 32)
	super._ready()

func investigate():
	if (GameVars.get_var(Enums.Vars.TOOK_NAIL)):
		SignalBus.show_message.emit(GameScript.Forest_Quiet_Fork_Signpost_Look_Without_Nail, false)
	else:
		SignalBus.show_message.emit(GameScript.Forest_Quiet_Fork_Signpost_Look_With_Nail, false)
	
	await SignalBus.message_closed
	
	SignalBus.memorize_player_info.emit()
	SignalBus.set_player_mode.emit(Enums.PlayerMode.POINTER)
	
	var teleport_args = TeleportArgs.new()
	teleport_args.to_scene = Enums.Scenes.FOREST_QUIET_FORK_SIGNPOST
	teleport_args.to_screen_center = true
	SignalBus.transfer_player_to_scene.emit(teleport_args)
	
func take():
	SignalBus.show_message.emit(GameScript.Forest_Quiet_Fork_Signpost_Take, false)

func use_item(_item: Item):
	pass
