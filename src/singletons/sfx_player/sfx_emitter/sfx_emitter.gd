extends AudioStreamPlayer2D

func _ready():
	play()

func _on_finished() -> void:
	queue_free()
