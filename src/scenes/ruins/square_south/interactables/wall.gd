extends BaseEvent

@onready var sprite = $Sprite2D
@onready var game_event = $GameEvent
@onready var static_body = $StaticBody2D
@export var break_sound: AudioStream

func _ready():
	if (GameVars.get_var(Enums.Vars.RUINED_HOUSE_OPEN)):
		remove_wall()
	else:
		super._ready()

func investigate():
	Utility.show_message(GameScript.get_entry("Ruins.Square_South.Wall_Look"))

func use_item(item: Item):
	if (item.slug == Enums.ItemSlugs.SLEDGE):
		var sfx_args = PlaySfxArgs.new()
		sfx_args.stream = break_sound
		SignalBus.play_sfx.emit(sfx_args)
		
		sprite.visible = false
		
		GameVars.set_var(Enums.Vars.RUINED_HOUSE_OPEN, true)
		
		await Utility.show_message(GameScript.get_entry("Ruins.Square_South.Wall_Destroy"))
		
		remove_wall()
	else:
		super.use_item(item)

func remove_wall():
	sprite.queue_free()
	game_event.queue_free()
	static_body.queue_free()
