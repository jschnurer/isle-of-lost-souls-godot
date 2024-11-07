class_name Player
extends CharacterBody2D

@export var normal_sprite: Texture2D
@export var up_sprite: Texture2D
@export var down_sprite: Texture2D
@export var pointer_sprite: Texture2D

const PERSON_SPEED = 250.0
const POINTER_SPEED = 400.0

var SPEED = PERSON_SPEED
var facing_dir: Enums.Direction = Enums.Direction.RIGHT
var game_event_in_range: GameEvent
@export var mode: Enums.PlayerMode = Enums.PlayerMode.PERSON
var is_controllable: bool = true

func _ready():
	$Sprite.texture = normal_sprite
	set_motion_mode(MotionMode.MOTION_MODE_FLOATING)
	$DownArea/CollisionShape2D.disabled = true
	$UpArea/CollisionShape2D.disabled = true
	$LeftArea/CollisionShape2D.disabled = true
	$PointerArea/CollisionShape2D.disabled = true
	$PointerCollision.disabled = true
	SignalBus.game_event_entered_range.connect(_on_game_event_entered_range)
	SignalBus.game_event_exited_range.connect(_on_game_event_exited_range)
	SignalBus.memorize_player_info.connect(_on_memorize_player_info)
	SignalBus.restore_player_info.connect(_on_restore_player_info)
	SignalBus.set_player_mode.connect(_on_set_player_mode)
	SignalBus.toggle_player.connect(_on_toggle_player)
	SignalBus.teleport_player.connect(_on_teleport_player)

func  _input(event):
	if (!is_controllable):
		return
	
	if (game_event_in_range and event.is_action_pressed("ui_accept")):
		if (game_event_in_range.use_action_chooser):
			show_action_chooser()
		else:
			game_event_in_range.activate(Enums.InputAction.INTERACT)
	elif (event.is_action_pressed("ui_cancel")):
		SignalBus.open_inventory.emit()

func _physics_process(_delta: float) -> void:
	if (!is_controllable):
		return
		
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	
	if (velocity.x < 0):
		facing_dir = Enums.Direction.LEFT
		if (mode == Enums.PlayerMode.PERSON):
			$Sprite.flip_h = true
	elif (velocity.x > 0):
		facing_dir = Enums.Direction.RIGHT
		if (mode == Enums.PlayerMode.PERSON):
			$Sprite.flip_h = false
	
	if (velocity.y < 0):
		facing_dir = Enums.Direction.UP
	elif (velocity.y > 0):
		facing_dir = Enums.Direction.DOWN
	
	update_areas()
	update_sprite()
	
func update_sprite():
	if (mode != Enums.PlayerMode.PERSON):
		return
		
	if (facing_dir == Enums.Direction.LEFT):
		$Sprite.texture = normal_sprite
		$Sprite.flip_h = true
	elif (facing_dir == Enums.Direction.RIGHT):
		$Sprite.texture = normal_sprite
		$Sprite.flip_h = false

	if (facing_dir == Enums.Direction.UP):
		$Sprite.texture = up_sprite
	elif (facing_dir == Enums.Direction.DOWN):
		$Sprite.texture = down_sprite

func update_areas():
	if (mode == Enums.PlayerMode.PERSON):
		$UpArea/CollisionShape2D.disabled = facing_dir != Enums.Direction.UP
		$RightArea/CollisionShape2D.disabled = facing_dir != Enums.Direction.RIGHT
		$DownArea/CollisionShape2D.disabled = facing_dir != Enums.Direction.DOWN
		$LeftArea/CollisionShape2D.disabled = facing_dir != Enums.Direction.LEFT

func _on_game_event_entered_range(game_event: GameEvent):
	if (game_event_in_range == null):
		game_event_in_range = game_event
	elif (game_event.parent_node_index > game_event_in_range.parent_node_index):
		game_event_in_range = game_event
	
func _on_game_event_exited_range(game_event: GameEvent):
	if game_event_in_range == game_event:
		game_event_in_range = null

func _on_memorize_player_info():
	var info = PlayerInfo.new()
	info.position = position
	info.facing_dir = facing_dir
	info.is_sprite_flip_h = $Sprite.flip_h
	info.mode = mode
	info.scene = SceneManager.current_scene
	GameVars.set_var(Enums.Vars.PLAYER_INFO, info)

func _on_restore_player_info():
	var saved_info: PlayerInfo = GameVars.get_var(Enums.Vars.PLAYER_INFO)
	facing_dir = saved_info.facing_dir
	_on_set_player_mode(saved_info.mode)
	
	update_areas()
	update_sprite()
	
	$Sprite.flip_h = saved_info.is_sprite_flip_h

func _on_set_player_mode(new_mode: Enums.PlayerMode):
	mode = new_mode
	
	if (mode == Enums.PlayerMode.POINTER):
		$Sprite.texture = pointer_sprite
		$Sprite.flip_h = false
		SPEED = POINTER_SPEED
	else:
		SPEED = PERSON_SPEED
		update_sprite()
	
	var is_pointer = mode == Enums.PlayerMode.POINTER
	
	$DownArea/CollisionShape2D.disabled = is_pointer
	$UpArea/CollisionShape2D.disabled = is_pointer
	$LeftArea/CollisionShape2D.disabled = is_pointer
	$RightArea/CollisionShape2D.disabled = is_pointer
	$FeetArea/CollisionShape2D.disabled = is_pointer
	$FeetCollision.disabled = is_pointer
	$PointerArea/CollisionShape2D.disabled = !is_pointer
	$PointerCollision.disabled = !is_pointer

func show_action_chooser():
	SignalBus.show_action_chooser.emit()
	var action = await SignalBus.action_chooser_closed
	
	if !game_event_in_range or action == null:
		return
	
	game_event_in_range.activate(action)

func _on_toggle_player(args: TogglePlayerArgs):
	visible = args.is_visible
	is_controllable = args.is_controllable

func _on_teleport_player(location: Vector2, facing: Enums.Direction):
	position = location
	if (facing != Enums.Direction.UNSET):
		facing_dir = facing
		update_sprite()
