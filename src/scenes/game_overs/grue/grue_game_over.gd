extends GameOverScene

func play_gameover():
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_1"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_2"))
	await Utility.wait(1)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_3"))
	gameover_done()
