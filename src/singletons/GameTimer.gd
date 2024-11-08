extends Node

var time_start = 0

func _ready():
	start_timer()

func start_timer():
	time_start = Time.get_unix_time_from_system()

func set_time_start(new_time_start: float):
	time_start = new_time_start

func get_time_elapsed():
	var time_now = Time.get_unix_time_from_system()
	var time_elapsed = time_now - time_start
	return time_elapsed
