extends Node

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func show_message(msg: String, has_more: bool = false):
	SignalBus.show_message.emit(msg, has_more)
	await SignalBus.message_closed

func show_choice(choices: Array[String], cancel_index: int) -> Choice:
	SignalBus.show_choice.emit(choices, cancel_index)
	return await SignalBus.choice_chosen

func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false
