class_name GameOverScene
extends Node2D

func _ready():
	await Utility.fade_in(false, .33)
	await Utility.wait(2)
	play_gameover()

func play_gameover():
	pass

func gameover_done():
	await Utility.fade_out(false, .5)
	SignalBus.return_to_title_screen.emit()
