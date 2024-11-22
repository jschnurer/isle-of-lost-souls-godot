extends GameOverScene

func play_gameover():
	await Utility.msg("Game_Overs.Fish.Fish_1", true)
	await Utility.msg("Game_Overs.Fish.Fish_2", true)
	await Utility.msg("Game_Overs.Fish.Fish_3", true)
	await Utility.msg("Game_Overs.Fish.Fish_4", true)
	await Utility.msg("Game_Overs.Fish.Fish_5")
	await Utility.wait(1)
	await Utility.msg("Game_Overs.Fish.Fish_6")
	gameover_done()
