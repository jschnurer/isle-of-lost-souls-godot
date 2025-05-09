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
var all_game_events_in_range: Array[GameEvent] = []
var game_event_in_range: GameEvent
@export var mode: Enums.PlayerMode = Enums.PlayerMode.PERSON
var is_controllable: bool = true
@onready var active_event_indicator: Label = $ActiveEvent
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
var is_navigating: bool = false
@onready var inspection_node: Node2D = $InspectionNode
@onready var inspection_collision: CollisionShape2D = $InspectionNode/Area/CollisionShape2D
var clicked_nav_position: Vector2
var auto_interact_ge = false

func _ready():
	$Sprite.texture = normal_sprite
	set_motion_mode(MotionMode.MOTION_MODE_FLOATING)
	$PointerArea/CollisionShape2D.disabled = true
	$PointerCollision.disabled = true
	SignalBus.game_event_entered_range.connect(_on_game_event_entered_range)
	SignalBus.game_event_exited_range.connect(_on_game_event_exited_range)
	SignalBus.memorize_player_info.connect(_on_memorize_player_info)
	SignalBus.restore_player_info.connect(_on_restore_player_info)
	SignalBus.set_player_mode.connect(_on_set_player_mode)
	SignalBus.toggle_player.connect(_on_toggle_player)
	SignalBus.teleport_player.connect(_on_teleport_player)
	SignalBus.transfer_player_to_scene.connect(_on_transfer_player_to_scene)

func  _input(event):
	if (!is_controllable):
		return
	
	if (game_event_in_range and event.is_action_pressed("ui_accept")):
		if (game_event_in_range.use_action_chooser):
			show_action_chooser()
		else:
			game_event_in_range.activate(Enums.InputAction.INTERACT)
	elif (event.is_action_pressed("ui_cancel")):
		SignalBus.open_pause_menu.emit()
	elif (event is InputEventMouseButton):
		if ((event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
			and (event as InputEventMouseButton).pressed):
			on_mouse_click(event)

func _process(_delta):
	if (game_event_in_range and auto_interact_ge and not is_navigating):
		auto_interact_ge = false
		if (game_event_in_range.use_action_chooser):
			show_action_chooser()
		else:
			game_event_in_range.activate(Enums.InputAction.INTERACT)

func _physics_process(delta: float) -> void:
	if (!is_controllable):
		return
		
	var did_player_move = false
		
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
		did_player_move = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
		did_player_move = true
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if (did_player_move):
		is_navigating = false
		move_and_slide()
	else:
		do_auto_nav(delta)
		
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
	
	if (velocity.x != 0 or velocity.y != 0):
		update_inspection_rotation()
	
	update_sprite()

func update_inspection_rotation():
	inspection_node.look_at(transform.origin + velocity)

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

func _on_game_event_entered_range(game_event: GameEvent):
	all_game_events_in_range.append(game_event)
	all_game_events_in_range.sort_custom(func sort_ascending(a, b): return a.parent_node_index > b.parent_node_index)
	
	if (game_event_in_range == null):
		game_event_in_range = game_event
	elif (game_event.parent_node_index > game_event_in_range.parent_node_index):
		game_event_in_range = game_event
	
	if mode == Enums.PlayerMode.PERSON:
		active_event_indicator.visible = true
	
func _on_game_event_exited_range(game_event: GameEvent):
	var item_ix = -1
	for ge in all_game_events_in_range:
		item_ix += 1
		if (ge == game_event):
			all_game_events_in_range.remove_at(item_ix)
			break
	
	if game_event_in_range == game_event:
		game_event_in_range = null
		if (all_game_events_in_range.size() > 0):
			game_event_in_range = all_game_events_in_range[0]
	
	if mode == Enums.PlayerMode.PERSON:
		active_event_indicator.visible = game_event_in_range != null
	else:
		active_event_indicator.visible = false

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
	
	update_sprite()
	
	$Sprite.flip_h = saved_info.is_sprite_flip_h

func _on_set_player_mode(new_mode: Enums.PlayerMode):
	mode = new_mode
	
	if (mode == Enums.PlayerMode.POINTER):
		$Sprite.texture = pointer_sprite
		$Sprite.flip_h = false
		$Sprite.offset = Vector2(24, 24)
		SPEED = POINTER_SPEED
		active_event_indicator.visible = false
	else:
		active_event_indicator.visible = game_event_in_range != null
		SPEED = PERSON_SPEED
		$Sprite.offset = Vector2(0, -49)
		update_sprite()
	
	var is_pointer = mode == Enums.PlayerMode.POINTER
	
	inspection_collision.disabled = is_pointer
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

func begin_nav(destination: Vector2):
	is_navigating = true
	nav_agent.target_position = destination

func do_auto_nav(_delta: float):
	if (not is_navigating):
		return
		
	if (nav_agent.is_navigation_finished()):
		is_navigating = false
		auto_interact_ge = true
		inspection_node.look_at(clicked_nav_position)
		return
	
	var curr_agent_position = global_position
	var next_path_position = nav_agent.get_next_path_position()
	velocity = SPEED * (next_path_position - curr_agent_position).normalized()
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func _on_transfer_player_to_scene(_args: TeleportArgs):
	velocity = Vector2.ZERO
	is_navigating = false

func on_mouse_click(event):
	clicked_nav_position = event.global_position
	begin_nav(clicked_nav_position)
