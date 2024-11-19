extends BaseEvent

enum Mode { WAITING, SQUIRMING }

@onready var timer: Timer = $Timer
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var mode = Mode.WAITING

func _ready():
	super._ready()
	start_wait_timer()

func investigate():
	Utility.msg("Swamp.Mosquito_Spawn.Egg_Look")

func take():
	if (GameVars.get_var(Enums.Vars.TOOK_MOSQUITO_EGG)):
		Utility.msg("Swamp.Mosquito_Spawn.Egg_Already_Took")
		GameVars.set_var(Enums.Vars.TOOK_MOSQUITO_EGG, true)
	elif (GameVars.get_var(Enums.Vars.WANT_MOSQUITO_EGG)):
		Utility.msg("Swamp.Mosquito_Spawn.Egg_Take")
	else:
		Utility.msg("Swamp.Mosquito_Spawn.Egg_Take_No_Reason")

func start_wait_timer():
	timer.wait_time = randf_range(0, 15)
	timer.start()

func _on_timer_timeout() -> void:
	if (mode == Mode.WAITING):
		mode = Mode.SQUIRMING
		anim.play("default")
		timer.wait_time = randf_range(.25, .75)
		timer.start()
	else:
		anim.pause()
		mode = Mode.WAITING
		start_wait_timer()
