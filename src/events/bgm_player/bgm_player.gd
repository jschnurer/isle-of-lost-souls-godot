extends Node2D

@export var stream: AudioStream
@export var volume_db: float = 1

func _ready():
	SignalBus.emit_signal("play_bgm", stream, volume_db)
