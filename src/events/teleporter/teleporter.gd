@tool
extends Node2D

@export_category("Teleporter")
@export var to_scene: Enums.Scenes
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

@export_group("Player Location")
## The exact location to send the player in the new scene.
@export var to_location: Vector2

@export_subgroup("Screen Transitions")
## The scene the player is moved to is north. This overrides [member to_location]'s y value.
@export var to_north: bool = false
## The scene the player is moved to is south. This overrides [member to_location]'s y value.
@export var to_south: bool = false
## The scene the player is moved to is east. This overrides [member to_location]'s x value.
@export var to_east: bool = false
## The scene the player is moved to is west. This overrides [member to_location]'s x value.
@export var to_west: bool = false

@export_subgroup("Location Preservation")
## Preserve's the player's x coordinate when teleporting. This overrides [member to_location]'s x value.
@export var preserve_x: bool = false
## Preserve's the player's y coordinate when teleporting. This overrides [member to_location]'s y value.
@export var preserve_y: bool = false

func _ready():
	$GameEvent.connect("on_activate", on_activate)

func on_activate():
	SignalBus.emit_signal("transfer_player_to_scene", {
		"to_scene": to_scene,
		"to_location": to_location,
		"to_north": to_north,
		"to_south": to_south,
		"to_east": to_east,
		"to_west": to_west,
		"preserve_x": preserve_x,
		"preserve_y": preserve_y,
	})
