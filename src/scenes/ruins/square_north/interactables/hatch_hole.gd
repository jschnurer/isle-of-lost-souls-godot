extends BaseEvent

@onready var static_collision = $StaticBody2D/CollisionPolygon2D3
@onready var game_event_collision = $GameEvent/CollisionPolygon2D2

func _ready() -> void:
	update_state()
	SignalBus.on_game_var_set.connect(_on_game_var_set)
	super._ready()

func update_state():
	var is_open = GameVars.get_var(Enums.Vars.HATCH_OPEN) == true
	visible = is_open
	static_collision.disabled = not is_open
	game_event_collision.disabled = not is_open

func investigate():
	Utility.show_message(GameScript.get_entry("Ruins.Square_North.Hatch_Hole_Look"))

func interact():
	await Utility.show_message(GameScript.get_entry("Ruins.Square_North.Hatch_Hole_Go"))
	
	var tele_args = TeleportArgs.new()
	tele_args.to_location = Vector2(164, 393)
	tele_args.to_scene = Enums.Scenes.RUINS_BUNKER
	SignalBus.transfer_player_to_scene.emit(tele_args)

func _on_game_var_set(var_name: Enums.Vars, _value):
	if (var_name != Enums.Vars.HATCH_OPEN):
		return
	
	update_state()
