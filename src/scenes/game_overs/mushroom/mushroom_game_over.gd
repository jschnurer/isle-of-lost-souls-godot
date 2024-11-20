extends GameOverScene

func _ready():
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_1"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_2"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_3"))
	await Utility.wait(1)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_4"))
	await Utility.wait(2)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_5"))
	gameover_done()
