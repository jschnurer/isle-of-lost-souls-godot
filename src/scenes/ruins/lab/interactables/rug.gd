extends BaseEvent

@onready var unrolled_sprite = $UnrolledSprite
@onready var unrolled_event_collision = $UnrolledEvent/CollisionShape2D

@onready var rolled_sprite = $RolledSprite
@onready var rolled_event_collision = $RolledEvent/CollisionShape2D
@onready var rolled_collision1 = $RolledStaticBody/Shape1
@onready var rolled_collision2 = $RolledStaticBody/Shape2
@onready var rolled_collision3 = $RolledStaticBody/Shape3

@onready var basement_teleporter_collision = $ToBasement/GameEvent/CollisionShape2D

func _ready():
	update_state()
	$UnrolledEvent.on_activate.connect(_on_activate)
	$RolledEvent.on_activate.connect(_on_activate)

func investigate():
	if (GameVars.get_var(Enums.Vars.MOVED_RUG)):
		Utility.show_message(GameScript.get_entry("Ruins.Lab.Rug_Moved_Look"))
	else:
		Utility.show_message(GameScript.get_entry("Ruins.Lab.Rug_Look"))

func interact():
	if (GameVars.get_var(Enums.Vars.MOVED_RUG)):
		Utility.show_message(GameScript.get_entry("Ruins.Lab.Rug_Moved_Interact"))
	else:
		SignalBus.teleport_player.emit(Vector2(417, 338), Enums.Direction.RIGHT)
		GameVars.set_var(Enums.Vars.MOVED_RUG, true)
		update_state()
		Utility.show_message(GameScript.get_entry("Ruins.Lab.Rug_Interact"))

func take():
	Utility.show_message(GameScript.get_entry("Ruins.Lab.Rug_Take"))

func update_state():
	var is_moved = GameVars.get_var(Enums.Vars.MOVED_RUG) == true
	
	basement_teleporter_collision.disabled = not is_moved
	
	rolled_sprite.visible = is_moved
	unrolled_sprite.visible = not is_moved
	
	rolled_event_collision.disabled = not is_moved
	rolled_collision1.disabled = not is_moved
	rolled_collision2.disabled = not is_moved
	rolled_collision3.disabled = not is_moved
