extends Node2D

@export var stream: AudioStream
@export var volume_db: float = 1

func _ready():
	if (stream):
		SignalBus.play_bgm.emit(stream, volume_db)
	else:
		SignalBus.stop_bgm.emit()
