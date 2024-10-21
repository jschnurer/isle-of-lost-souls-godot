extends CharacterBody2D

@export var normal_sprite: Texture2D
@export var up_sprite: Texture2D
@export var down_sprite: Texture2D
const SPEED = 250.0
var facing_dir: Enums.Direction = Enums.Direction.RIGHT
var game_event_in_range: GameEvent

func _ready():
	$Sprite.texture = normal_sprite
	set_motion_mode(MotionMode.MOTION_MODE_FLOATING)
	$DownArea/CollisionShape2D.disabled = true
	$UpArea/CollisionShape2D.disabled = true
	$LeftArea/CollisionShape2D.disabled = true
	SignalBus.game_event_entered_range.connect(_on_game_event_entered_range)
	SignalBus.game_event_exited_range.connect(_on_game_event_exited_range)

func  _input(event):
	if game_event_in_range and event.is_action_pressed("ui_accept"):
		game_event_in_range.activate()

func _physics_process(_delta: float) -> void:
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
	update_sprite()
	
func update_sprite():
	if (velocity.x < 0):
		$Sprite.flip_h = true
		facing_dir = Enums.Direction.LEFT
	elif (velocity.x > 0):
		$Sprite.flip_h = false
		facing_dir = Enums.Direction.RIGHT
		
	if (velocity.x != 0 and velocity.y == 0):
		$Sprite.texture = normal_sprite
		
	if (velocity.y < 0):
		$Sprite.texture = up_sprite
		facing_dir = Enums.Direction.UP
	elif (velocity.y > 0):
		$Sprite.texture = down_sprite
		facing_dir = Enums.Direction.DOWN
	
	update_areas(facing_dir)

func update_areas(direction):
	$UpArea/CollisionShape2D.disabled = direction != Enums.Direction.UP
	$RightArea/CollisionShape2D.disabled = direction != Enums.Direction.RIGHT
	$DownArea/CollisionShape2D.disabled = direction != Enums.Direction.DOWN
	$LeftArea/CollisionShape2D.disabled = direction != Enums.Direction.LEFT

func _on_game_event_entered_range(game_event: GameEvent):
	game_event_in_range = game_event
	
func _on_game_event_exited_range(game_event: GameEvent):
	if game_event_in_range == game_event:
		game_event_in_range = null
