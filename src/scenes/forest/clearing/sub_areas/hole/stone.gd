extends "res://src/events/game_event/base_event.gd"

func investigate():
	var message = "It's a small, smooth stone."
	SignalBus.show_message.emit(message, false)

func take():
	var message = "You take the stone."
	SignalBus.show_message.emit(message, false)

func interact():
	var message = "If you wanted to use it, you'd have to take it first."
	SignalBus.show_message.emit(message, false)
