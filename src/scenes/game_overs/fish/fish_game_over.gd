extends "res://src/events/game_event/base_event.gd"

func _ready():
	var fade_args = ScreenFadeArgs.new()
	fade_args.color = Color.BLACK
	fade_args.speed_scale = .33
	SignalBus.fade_in_screen.emit(fade_args)
	await SignalBus.fade_in_screen_finished
	
	await Utility.wait(2)
		
	SignalBus.show_message.emit(GameScript.Game_Over_Fish_1, true)
	await SignalBus.message_closed
	
	SignalBus.show_message.emit(GameScript.Game_Over_Fish_2, true)
	await SignalBus.message_closed
	
	SignalBus.show_message.emit(GameScript.Game_Over_Fish_3, true)
	await SignalBus.message_closed
	
	SignalBus.show_message.emit(GameScript.Game_Over_Fish_4, true)
	await SignalBus.message_closed
	
	SignalBus.show_message.emit(GameScript.Game_Over_Fish_5, false)
	await SignalBus.message_closed
	
	await Utility.wait(1)
	
	SignalBus.show_message.emit(GameScript.Game_Over_Fish_6, false)
	await SignalBus.message_closed
	
	SignalBus.show_message.emit("This is where it would send you to the title screen", false)
	await SignalBus.message_closed
	SignalBus.return_to_title_screen.emit()
