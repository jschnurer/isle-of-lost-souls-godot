extends GameOverScene

func play_gameover():
	await Utility.msg("Game_Overs.Grue.Grue_1", true)
	await Utility.msg("Game_Overs.Grue.Grue_2")
	await Utility.wait(1)
	await Utility.msg("Game_Overs.Grue.Grue_3")
	gameover_done()
