extends Node2D

@onready var audio_player: AudioStreamPlayer2D = $BGM

func _ready():
	SignalBus.play_bgm.connect(play_bgm)
	SignalBus.stop_bgm.connect(stop_bgm)
	
func play_bgm(stream: AudioStream, volume: float):
	# If this track is already playing, no need to restart it.
	if (audio_player.playing and audio_player.stream.resource_path == stream.resource_path):
		return
	
	audio_player.stop()
	audio_player.stream = stream
	audio_player.volume_db = volume
	audio_player.play()

func stop_bgm():
	audio_player.stop()
