extends Node

var vars: Dictionary = {}

func set_var(var_name: Enums.Vars, value):
	vars[var_name] = value
	SignalBus.on_game_var_set.emit(var_name, value)

func get_var(var_name: Enums.Vars):
	if (vars.has(var_name)):
		return vars[var_name]
	else:
		return null
