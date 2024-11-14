extends Sprite2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func _ready():
	if (randi_range(0, 2) >= 1):
		visible = true
		anim.play("bubble")
		anim.advance(randf_range(0, anim.get_animation("bubble").length))
	else:
		visible = false
		restart_timer()
	
func restart_timer():
	timer.wait_time = randf_range(1, 3)
	timer.start()

func _on_anim_done():
	restart_timer()

func _on_timer_timeout() -> void:
	anim.play("bubble", -1, randf_range(1, 1.33))
