extends BaseEvent

@export var grue_sound: AudioStream

func collide():
	Utility.initiate_game_over(Enums.Scenes.GAME_OVER_GRUE, 2, grue_sound, 3)
