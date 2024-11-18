extends BaseEvent

func _ready():
	super._ready()
	
	if (not GameVars.get_var(Enums.Vars.TOOK_FLAG)):
		$GameEvent/CollisionPolygon2D.disabled = true
		visible = false
		SignalBus.on_game_var_set.connect(_on_game_var_set)

func investigate():
	Utility.msg("Swamp.Abandoned_Campsite.Flagpole_No_Flag_Look")

func _on_game_var_set(var_name: Enums.Vars, value):
	if (not var_name == Enums.Vars.TOOK_FLAG):
		return
	
	if (value):
		visible = true
		$GameEvent/CollisionPolygon2D.disabled = false
