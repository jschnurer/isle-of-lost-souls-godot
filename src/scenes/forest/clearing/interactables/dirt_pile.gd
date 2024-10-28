extends "res://src/events/game_event/base_event.gd"

func investigate():
	SignalBus.show_message.emit(GameScript.Forest_Clearing_Dirt_Look, false)
	await SignalBus.message_closed

func take():
	SignalBus.show_message.emit(GameScript.Forest_Clearing_Dirt_Take, false)

func interact():
	SignalBus.show_message.emit(GameScript.Global_No_Mechanism_To_Interact, false)
