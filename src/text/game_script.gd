extends Node

var script_dict: Dictionary

func _ready():
	var file = "res://src/text/game_script.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	script_dict = JSON.parse_string(json_as_text)

func get_entry(path: StringName) -> String:
	var path_chunks = path.split(".", false)
	var item = script_dict
	
	for chunk in path_chunks:
		item = item[chunk]
		
		if (item == null):
			return "INVALID PATH: " + path
	
	return item
