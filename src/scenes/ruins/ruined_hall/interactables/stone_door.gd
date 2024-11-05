extends "res://src/events/game_event/base_event.gd"

@onready var open_sprite = $WallOpen
@onready var closed_sprite = $WallClosed
@onready var collision_shape = $StaticBody2D/CollisionShape2D

func _ready():
	update_state()
	SignalBus.on_game_var_set.connect(_on_game_var_set)
	super._ready()

func update_state():
	var is_open = GameVars.get_var(Enums.Vars.RUIN_HALL_DOOR_OPEN) == true
	collision_shape.disabled = is_open
	open_sprite.visible = is_open
	closed_sprite.visible = !is_open

func _on_game_var_set(var_name: Enums.Vars, _value):
	if (var_name != Enums.Vars.RUIN_HALL_DOOR_OPEN):
		return
	
	update_state()

func investigate():
	print("?")
	if (GameVars.get_var(Enums.Vars.RUIN_HALL_DOOR_OPEN) == true):
		Utility.show_message(GameScript.get_entry("Ruins.Hall.Door_Open_Look"))
	else:
		Utility.show_message(GameScript.get_entry("Ruins.Hall.Door_Closed_Look"))
