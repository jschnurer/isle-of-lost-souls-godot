extends Control

func _ready():
	SignalBus.fade_in_screen.connect(_on_fade_in_screen)
	SignalBus.fade_out_screen.connect(_on_fade_out_screen)

func _on_fade_out_screen(args: ScreenFadeArgs):
	$ColorRect.color = args.color
	$AnimationPlayer.play("fade_out", -1, args.speed_scale)

func _on_fade_out_complete():
	SignalBus.fade_out_screen_finished.emit()

func _on_fade_in_screen(args: ScreenFadeArgs):
	$ColorRect.color = args.color
	$AnimationPlayer.play("fade_in", -1, args.speed_scale)

func _on_fade_in_complete():
	print ("fade in complete")
	SignalBus.fade_in_screen_finished.emit()
