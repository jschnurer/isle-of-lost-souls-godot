extends Node

@warning_ignore("unused_signal")
signal display_dialog(text_key)

@warning_ignore("unused_signal")
signal transfer_player_to_scene(scene: PackedScene, location: Vector2)

@warning_ignore("unused_signal")
signal play_bgm(stream: AudioStream, volume: float)

@warning_ignore("unused_signal")
signal stop_bgm()
