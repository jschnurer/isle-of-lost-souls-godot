extends GameOverScene

func play_gameover():
	await Utility.msg("Game_Overs.Rhode.Rhode_1", true)
	await Utility.msg("Game_Overs.Rhode.Rhode_2", true)
	await Utility.msg("Game_Overs.Rhode.Rhode_3", false)
	gameover_done()
