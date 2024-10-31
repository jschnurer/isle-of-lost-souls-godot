extends "res://src/events/game_event/base_event.gd"

func investigate():
	Utility.show_message("Try interacting instead to see the test dialog system.")
	await SignalBus.message_closed

func interact():
	SignalBus.open_dialog_manager.emit($Dialog)
