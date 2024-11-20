extends BaseEvent

func investigate():
	Utility.msg("Swamp.Hut_Exterior.Hut_Look")
	
func take():
	Utility.msg("Swamp.Hut_Exterior.Hut_Take")

func interact():
	await Utility.msg("Swamp.Hut_Exterior.Hut_Interact")
	
	var args = TeleportArgs.new()
	args.to_scene = Enums.Scenes.SWAMP_HUT_INTERIOR
	args.to_location = Vector2(396, 443)
	SignalBus.transfer_player_to_scene.emit(args)
