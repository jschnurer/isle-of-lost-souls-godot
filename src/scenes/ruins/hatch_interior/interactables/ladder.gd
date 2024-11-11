extends BaseEvent

func interact():
	await Utility.show_message(GameScript.get_entry("Ruins.Hatch_Interior.Ladder_Go"))
	
	var tele_args = TeleportArgs.new()
	tele_args.to_location = Vector2(456, 330)
	tele_args.to_scene = Enums.Scenes.RUINS_SQUARE_NORTH
	SignalBus.transfer_player_to_scene.emit(tele_args)
