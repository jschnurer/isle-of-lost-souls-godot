extends "res://src/events/game_event/base_event.gd"

func investigate():
	SignalBus.show_message.emit("Try interacting instead to see the test dialog system.", false)
	await SignalBus.message_closed

func interact():
	SignalBus.open_dialog_manager.emit($Dialog)
