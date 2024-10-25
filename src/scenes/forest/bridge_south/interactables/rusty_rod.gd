extends "res://src/events/game_event/base_event.gd"

func investigate():
	SignalBus.show_message.emit(GameScript.Forest_Bridge_South_Rod_Look, false)

func take():
	if (!GameVars.get_var(Enums.Vars.DISTRACTED_FISH)):
		var toggle_args = TogglePlayerArgs.new()
		toggle_args.is_visible = true
		toggle_args.is_controllable = false
		SignalBus.toggle_player.emit(toggle_args)
		
		var fade_out_args = ScreenFadeArgs.new()
		fade_out_args.color = Color.BLACK
		fade_out_args.speed_scale = 3
		SignalBus.fade_out_screen.emit(fade_out_args)
		await SignalBus.fade_out_screen_finished
		
		toggle_args.is_visible = false
		SignalBus.toggle_player.emit(toggle_args)
		
		var teleport_args = TeleportArgs.new()
		teleport_args.to_scene = Enums.Scenes.GAME_OVER_FISH
		SignalBus.transfer_player_to_scene.emit(teleport_args)
	else:
		SignalBus.show_message.emit(GameScript.Forest_Bridge_South_Rod_Take_Successful, false)

func interact():
	SignalBus.show_message.emit(GameScript.Global_No_Mechanism_To_Interact, false)
