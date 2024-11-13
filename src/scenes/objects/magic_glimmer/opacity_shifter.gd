extends Node2D

@onready var sprite: AnimatedSprite2D = $".."
@onready var opacity_timer: Timer = $OpacityTimer
@onready var flip_h_timer: Timer = $FlipHTimer
@onready var flip_v_timer: Timer = $FlipVTimer
var tween: Tween

func _ready():
	tween = create_tween()
	opacity_timer.timeout.connect(_on_opacity_timer_elapsed)
	flip_h_timer.timeout.connect(_on_flip_h_timer_elapsed)
	flip_v_timer.timeout.connect(_on_flip_v_timer_elapsed)
	#shift_opacity()
	#pick_new_lerp_target_opacity()

func _on_opacity_timer_elapsed():
	opacity_timer.wait_time = randf_range(.15, .33)
	sprite.self_modulate = Color(sprite.self_modulate.r, sprite.self_modulate.g, sprite.self_modulate.b, randf_range(.1, .45))
	opacity_timer.start()

func _on_flip_h_timer_elapsed():
	flip_h_timer.wait_time = randf_range(.33, 1.1)
	sprite.flip_h = randi_range(0, 1) == 1
	flip_h_timer.start()

func _on_flip_v_timer_elapsed():
	flip_v_timer.wait_time = randf_range(.33, 1.1)
	sprite.flip_v = randi_range(0, 1) == 1
	flip_v_timer.start()

#func pick_new_lerp_target_opacity():
	## Tween the sprite's self_modulate over 0...1 seconds.
	#tween.stop()
	#tween = create_tween()
	#tween.tween_property(sprite,
		#"self_modulate",
		#Color(sprite.self_modulate.r, sprite.self_modulate.g, sprite.self_modulate.b, randf_range(.15, .66)),
		#randf_range(.05, .25))
	#tween.tween_callback(pick_new_lerp_target_opacity)
	#sprite.flip_h = randi_range(0, 1) == 1
	#sprite.flip_v = randi_range(0, 1) == 1
		
	
#func shift_opacity():
	#timer.wait_time = randf_range(.15, .33)
	#sprite.self_modulate = Color(sprite.self_modulate.r, sprite.self_modulate.g, sprite.self_modulate.b, randf_range(.15, .75))
	#sprite.flip_h = randi_range(0, 1) == 1
	#sprite.flip_v = randi_range(0, 1) == 1
	#timer.start()
