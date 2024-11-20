extends GameOverScene

func play_gameover():
	await Utility.show_message(GameScript.get_entry("Game_Overs.Rhode.Rhode_1"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Rhode.Rhode_2"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Rhode.Rhode_3"), false)
	gameover_done()
