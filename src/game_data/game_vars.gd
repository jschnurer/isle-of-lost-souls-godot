extends Node

var vars: Dictionary = {}

func set_var(var_name: Enums.Vars, value):
	vars[var_name] = value
	SignalBus.on_game_var_set.emit(var_name, value)

func get_var(var_name: Enums.Vars, default_value = null):
	if (vars.has(var_name)):
		var val = vars[var_name]
		
		if val == null:
			return default_value
		else:
			return val
	else:
		return null

func get_all():
	return vars

func set_all(var_dict: Dictionary):
	vars = var_dict
