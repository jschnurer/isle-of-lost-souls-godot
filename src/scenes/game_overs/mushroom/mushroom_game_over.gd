extends GameOverScene

func _ready():
	await Utility.msg("Game_Overs.Mushroom.Mushroom_1", true)
	await Utility.msg("Game_Overs.Mushroom.Mushroom_2", true)
	await Utility.msg("Game_Overs.Mushroom.Mushroom_3")
	await Utility.wait(1)
	await Utility.msg("Game_Overs.Mushroom.Mushroom_4")
	await Utility.wait(2)
	await Utility.msg("Game_Overs.Mushroom.Mushroom_5")
	gameover_done()
