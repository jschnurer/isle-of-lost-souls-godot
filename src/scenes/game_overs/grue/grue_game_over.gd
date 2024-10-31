extends Node2D

func _ready():
	var fade_args = ScreenFadeArgs.new()
	fade_args.color = Color.BLACK
	fade_args.speed_scale = .33
	SignalBus.fade_in_screen.emit(fade_args)
	await SignalBus.fade_in_screen_finished
	
	await Utility.wait(2)

	SignalBus.show_message.emit(GameScript.Game_Over_Grue_1, true)
	await SignalBus.message_closed
	
	SignalBus.show_message.emit(GameScript.Game_Over_Grue_2, false)
	await SignalBus.message_closed
	
	await Utility.wait(1)
	
	SignalBus.show_message.emit(GameScript.Game_Over_Grue_3, false)
	await SignalBus.message_closed
	
	SignalBus.show_message.emit("This is where it would send you to the title screen", false)
	await SignalBus.message_closed
	
	SignalBus.return_to_title_screen.emit()
