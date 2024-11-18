@tool
extends Node2D

enum SparkleVariations { BLUE1, BLUE2 }

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var _variation: SparkleVariations = SparkleVariations.BLUE1
@export var variation: SparkleVariations:
	get:
		return _variation
	set(value):
		_variation = value
		update_anim_sprite()

func _ready():
	update_anim_sprite()

func update_anim_sprite():
	if (_variation == SparkleVariations.BLUE1):
		anim_sprite.play("blue1")
	elif (_variation == SparkleVariations.BLUE2):
		anim_sprite.play("blue2")
