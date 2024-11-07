extends BaseEvent

@onready var initial_x = position.x
var shifted_x = 470

func _ready():
	super._ready()
	SignalBus.on_game_var_set.connect(_on_game_var_set)
	update_state()

func update_state():
	var is_moved = GameVars.get_var(Enums.Vars.MOVED_TEMPLE_ALTAR)
	if (is_moved):
		position = Vector2(shifted_x, position.y)
	else:
		position = Vector2(initial_x, position.y)

func investigate():
	Utility.show_message(GameScript.get_entry("Ruins.Temple_North.Altar_Look"))

func _on_game_var_set(var_name: Enums.Vars, value):
	if (var_name == Enums.Vars.MOVED_TEMPLE_ALTAR):
		update_state()
