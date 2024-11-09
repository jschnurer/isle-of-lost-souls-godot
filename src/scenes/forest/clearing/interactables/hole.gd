extends BaseEvent

func investigate():
	await Utility.show_message(GameScript.get_entry("Forest.Clearing.Hole_Look"))

	SignalBus.memorize_player_info.emit()
	SignalBus.set_player_mode.emit(Enums.PlayerMode.POINTER)
	
	var tele_args = TeleportArgs.new()
	tele_args.to_scene = Enums.Scenes.FOREST_CLEARING_HOLE
	tele_args.to_screen_center = true
	SignalBus.transfer_player_to_scene.emit(tele_args)

func take():
	Utility.show_message(GameScript.get_entry("Forest.Clearing.Hole_Take"))
