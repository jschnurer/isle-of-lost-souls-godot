extends Node2D

@export var nail_missing_texture: Texture2D

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_NAIL)):
		$"SceneBG".set_bg_texture(nail_missing_texture)
