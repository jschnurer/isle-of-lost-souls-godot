extends "res://src/events/game_event/base_event.gd"

func investigate():
	SignalBus.show_message.emit(GameScript.Forest_Cabin_Exterior_Door_Look, false)

func interact():
	SignalBus.show_message.emit("TODO: TELEPORT PLAYER INSIDE IF ARDEN IS OK WITH IT", false)
	
