extends BaseEvent

@onready var sprite = $Sprite2D
@export var break_sound: AudioStream

func _ready():
	if (GameVars.get_var(Enums.Vars.RUINED_HOUSE_OPEN)):
		queue_free()
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
		
		queue_free()
	else:
		super.use_item(item)
