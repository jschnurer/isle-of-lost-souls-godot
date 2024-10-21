extends Node2D

func _ready():
	$GameEvent.connect("on_activate", _on_activate)

func _on_activate():
	var message = "It's just a small hole in the dirt."
	
	if (not GameDb.get_var(Enums.Vars.TOOK_STONE)):
		message += " At the bottom is a small, smooth stone. You take it."
		SignalBus.set_game_var.emit(Enums.Vars.TOOK_STONE, true)
	
	SignalBus.show_message.emit(message, false)
	await SignalBus.show_message_finished
