extends CanvasLayer

@export var splash_images: Array[Texture2D] = []
@onready var texture_rect = $CenterContainer/TextureRect
@onready var anim_player = $AnimationPlayer
var current_index = -1

func _ready():
	if (splash_images.size() == 0):
		go_to_title()
	else:
		next_splash()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept")):
		go_to_title()

func next_splash():
	current_index += 1
	if (splash_images.size() <= current_index):
		go_to_title()
	else:
		texture_rect.texture = splash_images[current_index]
		anim_player.play("fade_in")

func go_to_title():
	var args = TeleportArgs.new()
	args.to_scene = Enums.Scenes.TITLE_SCREEN
	args.to_location = Vector2(0, 0)
	SignalBus.transfer_player_to_scene.emit(args)
	queue_free()
