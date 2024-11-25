@tool
extends Node2D

@export var anim_start_time: float = 0

func _ready():
	$AnimationPlayer.play("crashing_waves")
	$AnimationPlayer.seek(anim_start_time)
