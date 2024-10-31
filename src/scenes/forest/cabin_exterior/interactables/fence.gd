extends "res://src/events/game_event/base_event.gd"

func investigate():
	SignalBus.show_message.emit(GameScript.Forest_Cabin_Exterior_Fence_Look, false)
