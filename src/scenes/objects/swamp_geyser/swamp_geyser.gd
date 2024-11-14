extends Sprite2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var flip_timer: Timer = $FlipTimer

func _ready():
	flip_h = randi_range(0, 1) == 1
	
	if (randi_range(0, 2) >= 1):
		visible = true
		anim.play("geyser")
		anim.advance(randf_range(0, anim.get_animation("geyser").length))
	else:
		visible = false
		restart_timer()
	
func restart_timer():
	timer.wait_time = randf_range(2, 6)
	timer.start()

func _on_anim_done():
	restart_timer()

func _on_timer_timeout() -> void:
	anim.play("geyser", -1, randf_range(1, 1.25))

func _on_flip_timer_timeout() -> void:
	flip_h = not flip_h
	flip_timer.wait_time = randf_range(0.05, 0.15)
