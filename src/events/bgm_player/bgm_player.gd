extends Node2D

@export var stream: AudioStream
@export var volume_db: float = 1

func _ready():
	if (stream):
		SignalBus.emit_signal("play_bgm", stream, volume_db)
	else:
		SignalBus.emit_signal("stop_bgm")
