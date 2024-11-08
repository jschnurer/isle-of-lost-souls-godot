extends CanvasLayer

enum FadeType { IN, OUT }

@onready var color_rect: ColorRect = $ColorRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	SignalBus.fade_in_screen.connect(_on_fade_in_screen)
	SignalBus.fade_out_screen.connect(_on_fade_out_screen)

func _on_fade_out_screen(args: ScreenFadeArgs):
	handle_fade(args, FadeType.OUT)

func _on_fade_in_screen(args: ScreenFadeArgs):
	handle_fade(args, FadeType.IN)
	
func _on_fade_out_complete():
	SignalBus.fade_out_screen_finished.emit()

func _on_fade_in_complete():
	SignalBus.fade_in_screen_finished.emit()

func handle_fade(args: ScreenFadeArgs, type: FadeType):
	color_rect.color = args.color
	if (args.instantly):
		if (type == FadeType.IN):
			color_rect.modulate.a = 0
			_on_fade_in_complete()
		elif (type == FadeType.OUT):
			color_rect.modulate.a = 1
			_on_fade_out_complete()
	else:
		if (type == FadeType.IN):
			anim_player.play("fade_in", -1, args.speed_scale)
		elif (type == FadeType.OUT):
			anim_player.play("fade_out", -1, args.speed_scale)
