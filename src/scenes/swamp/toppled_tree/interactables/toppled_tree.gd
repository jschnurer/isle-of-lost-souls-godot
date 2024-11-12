extends BaseEvent

func investigate():
	await Utility.msg("Swamp.Toppled_Tree.Log_Look")
	
	SignalBus.memorize_player_info.emit()
	SignalBus.set_player_mode.emit(Enums.PlayerMode.POINTER)
	
	var tele_args = TeleportArgs.new()
	tele_args.to_scene = Enums.Scenes.SWAMP_TOPPLED_TREE_MUSHROOMS
	tele_args.to_screen_center = true
	SignalBus.transfer_player_to_scene.emit(tele_args)
