@tool
extends Node2D

@export var to_scene: Enums.Scenes
@export var to_location: Vector2
@export var event_area: Shape2D :
	get:
		return $GameEvent/CollisionShape2D.shape
	set(value):
		$GameEvent/CollisionShape2D.shape = value

@export var activation_mode: Enums.ActivationMode = Enums.ActivationMode.COLLIDE :
	get:
		return $GameEvent.activation_mode
	set(value):
		$GameEvent.activation_mode = value

func _ready():
	$GameEvent.connect("on_activate", on_activate)

func on_activate():
	SignalBus.emit_signal("transfer_player_to_scene", to_scene, to_location)
