extends BaseEvent

@export var closed_sprite: Texture2D
@export var open_sprite: Texture2D
@onready var sprite = $Sprite2D

func _ready():
	super._ready()
	update_sprite()

func update_sprite():
	if (GameVars.get_var(Enums.Vars.HOUSE_CHEST_OPEN)):
		sprite.texture = open_sprite
	else:
		sprite.texture = closed_sprite

func investigate():
	if (GameVars.get_var(Enums.Vars.HOUSE_CHEST_OPEN)):
		await Utility.msg("Ruins.House.Chest_Open_Look")
		Utility.go_to_sub_area(Enums.Scenes.RUINS_HOUSE_CHEST)
	else:
		Utility.msg("Ruins.House.Chest_Closed_Look")

func interact():
	if (GameVars.get_var(Enums.Vars.HOUSE_CHEST_OPEN)):
		GameVars.set_var(Enums.Vars.HOUSE_CHEST_OPEN, false)
		update_sprite()
		Utility.msg("Ruins.House.Chest_Close")
	else:
		GameVars.set_var(Enums.Vars.HOUSE_CHEST_OPEN, true)
		update_sprite()
		Utility.msg("Ruins.House.Chest_Open")
