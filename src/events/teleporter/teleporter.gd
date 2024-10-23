@tool
extends Node2D

@export_category("Teleporter")
var _to_scene_name: String
@warning_ignore("enum_variable_without_default")
var _to_scene_enum: Enums.Scenes
@export var to_scene: String :
	set(value):
		_to_scene_name = value
		var enum_val = Enums.Scenes.get(value)
		if (enum_val):
			_to_scene_enum = enum_val
		else:
			enum_val = 0
	get:
		return _to_scene_name
@export var scene_name_valid: bool :
	get:
		if (_to_scene_enum):
			return true
		else:
			return false
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
## The player is moved to their previous position as defined in the game vars.
@export var to_previous_position: bool = false
## The player is moved to the exact center of the screen. This overrides [member to_location]'s value.
@export var to_screen_center: bool = false

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

func on_activate(_action: Enums.InputAction):
	var args = TeleportArgs.new()
	args.to_scene = _to_scene_enum
	args.to_location = to_location
	args.to_screen_center = to_screen_center
	args.to_previous_position = to_previous_position
	args.to_north = to_north
	args.to_south = to_south
	args.to_east = to_east
	args.to_west = to_west
	args.preserve_x = preserve_x
	args.preserve_y = preserve_y
	
	SignalBus.transfer_player_to_scene.emit(args)
	
	if (args.to_previous_position):
		SignalBus.restore_player_info.emit()
