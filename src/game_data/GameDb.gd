extends Node

var Inventory: Array[Item] = []
var Vars: Dictionary = {}

func _ready():
	SignalBus.connect("set_game_var", _on_set_game_var)

func _on_set_game_var(var_name: Enums.Vars, value):
	Vars[var_name] = value

func get_var(var_name: Enums.Vars):
	if (Vars.has(var_name)):
		return Vars[var_name]
	else:
		return null
