extends Node2D

@export var scene_bg: SceneBG
@export var dark_scene_bg: Texture2D
@export var light_scene_bg: Texture2D

func _ready():
	handle_darkness()
	
func handle_darkness():
	if (!Inventory.has_item(Enums.ItemSlugs.FLASHLIGHT)):
		var img_arr: Array[Texture2D] = [dark_scene_bg]
		scene_bg.bg_images = img_arr
		
		SignalBus.show_message.emit("This place is so dark that you can't even see your hand in front of your face. Strange and terrible things make their homes in the dark. If you value your life, you should IMMEDIATELY head back the way you came and return with a light source.", true)
		await SignalBus.message_closed
		SignalBus.show_message.emit("It is pitch black. You are likely to be eaten by a grue.", false)
	else:
		var img_arr: Array[Texture2D] = [light_scene_bg]
		scene_bg.bg_images = img_arr
		
		queue_free()
