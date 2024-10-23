extends "res://src/events/game_event/base_event.gd"

func investigate():
	SignalBus.show_message.emit(GameScript.Forest_Clearing_Hole_Look, false)
	await SignalBus.message_closed
	
	SignalBus.memorize_player_info.emit()
	SignalBus.set_player_mode.emit(Enums.PlayerMode.POINTER)
	
	var tele_args = TeleportArgs.new()
	tele_args.to_scene = Enums.Scenes.FOREST_CLEARING_HOLE
	tele_args.to_screen_center = true
	SignalBus.transfer_player_to_scene.emit(tele_args)

func take():
	SignalBus.show_message.emit(GameScript.Forest_Clearing_Hole_Take, false)

func interact():
	SignalBus.show_message.emit(GameScript.Global_You_Cant, false)
