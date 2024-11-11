extends Node2D

func _ready():
	SignalBus.on_game_var_set.connect(_on_game_var_set)
	update_state()

func _on_game_var_set(var_name: Enums.Vars, _value):
	if (var_name == Enums.Vars.MOVED_TEMPLE_ALTAR):
		update_state()

func update_state():
	var is_altar_moved = GameVars.get_var(Enums.Vars.MOVED_TEMPLE_ALTAR)
	
	$ToTempleExit/GameEvent/CollisionShape2D.disabled = not is_altar_moved
	$StaticBody2D/CollisionPolygon2D.disabled = not is_altar_moved
