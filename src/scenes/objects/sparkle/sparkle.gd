@tool
extends Node2D

@onready var anim_sprite1: AnimatedSprite2D = $Sprite1
@onready var anim_sprite2: AnimatedSprite2D = $Sprite2
@export var rotate_speed: float = 0
@export var throb_speed: float = 0
@export var min_opacity: float = .15
@export var max_opacity: float = .8
var throb_direction = -1

func _process(delta: float):
	if (rotate_speed != 0):
		var change = delta * rotate_speed
		update_rot(anim_sprite1, change)
		update_rot(anim_sprite2, -change)
	if (throb_speed != 0):
		update_throb(delta)

func update_rot(node, change_amt):
	node.rotation_degrees += change_amt
	if (node.rotation_degrees < -360):
		node.rotation_degrees += 360
	elif (node.rotation_degrees > 360):
		node.rotation_degrees -= 360
	
func update_throb(delta: float):
	var new_mod = clampf(modulate.a + (throb_direction * delta * throb_speed), min_opacity, max_opacity)
	modulate = Color(modulate.r, modulate.g, modulate.b, new_mod)
	
	if (new_mod <= min_opacity):
		throb_direction *= -1
	elif (new_mod >= max_opacity):
		throb_direction *= -1
