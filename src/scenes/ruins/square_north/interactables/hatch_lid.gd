extends BaseEvent

func _ready():
	update_state()
	$Pivot/GameEvent.on_activate.connect(_on_activate)

func investigate():
	Utility.show_message(GameScript.get_entry("Ruins.Square_North.Hatch_Lid_Look"))

func interact():
	if (GameVars.get_var(Enums.Vars.HATCH_OPEN)):
		GameVars.set_var(Enums.Vars.HATCH_OPEN, false)
		update_state()
		Utility.show_message(GameScript.get_entry("Ruins.Square_North.Hatch_Lid_Close"))
	else:
		GameVars.set_var(Enums.Vars.HATCH_OPEN, true)
		update_state()
		Utility.show_message(GameScript.get_entry("Ruins.Square_North.Hatch_Lid_Open"))

func update_state():
	var is_open = GameVars.get_var(Enums.Vars.HATCH_OPEN) == true
	if (is_open):
		rotation_degrees = 60
	else:
		rotation_degrees = 0
