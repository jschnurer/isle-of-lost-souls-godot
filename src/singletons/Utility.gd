extends Node

var to_title_case_regex = RegEx.new()

func _ready():
	to_title_case_regex.compile("_[a-z]")
	
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func show_message(msg: String, has_more: bool = false):
	SignalBus.show_message.emit(msg, has_more)
	await SignalBus.message_closed

func show_choice(choices: Array[String], cancel_index: int) -> Choice:
	SignalBus.show_choice.emit(choices, cancel_index)
	return await SignalBus.choice_chosen

func show_yes_no_choice() -> Choice:
	SignalBus.show_choice.emit([GameScript.get_entry("Global.Yes"), GameScript.get_entry("Global.No")] as Array[String], 1)
	return await SignalBus.choice_chosen

func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false

func enum_str_to_title_case(enum_str: String):
	var title_str = enum_str.to_lower()
	return to_title_case_regex.sub(title_str, "$1".to_upper(), true)
	
