extends Node2D

func _ready():
	SignalBus.connect("play_bgm", play_bgm)
	SignalBus.connect("stop_bgm", stop_bgm)
	
func play_bgm(stream: AudioStream, volume: float):
	# If this track is already playing, no need to restart it.
	if ($BGM.playing and $BGM.stream.resource_path == stream.resource_path):
		return
	
	$BGM.stop()
	$BGM.stream = stream
	$BGM.volume_db = volume
	$BGM.play()

func stop_bgm():
	$BGM.stop()
