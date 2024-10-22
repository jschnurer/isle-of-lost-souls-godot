@tool
extends TextureRect

var _current_bg_index = 0
var _bg_images: Array[Texture2D] = []
var _bg_anim_frame_duration = .333
var _bg_anim_elapsed = 0
var _collision_image: Texture2D
var _use_collision_frame: bool

@export var bg_images: Array[Texture2D] :
	set(value):
		_bg_images = value
		if (value == null or value.size() == 0):
			set_bg_texture(null)
		else:
			set_bg_texture(value[0])
	get:
		return _bg_images

@export var collision_image: Texture2D :
	set(value):
		_collision_image = value
		generate_collision_shapes()
	get:
		return _collision_image

@export var use_collision_frame: bool :
	set(value):
		_use_collision_frame = value
		generate_collision_shapes()
	get:
		return _use_collision_frame

@export var bgm_stream: AudioStream :
	set(value):
		$BgmPlayer.stream = value
	get:
		return $BgmPlayer.stream
		
@export var bgm_volume: float = 1:
	set(value):
		$BgmPlayer.volume_db = value
	get:
		return $BgmPlayer.volume_db

func _process(delta):
	_bg_anim_elapsed += delta
	if (_bg_anim_elapsed >= _bg_anim_frame_duration):
		_bg_anim_elapsed -= _bg_anim_frame_duration
		on_bg_anim_timer_timeout()

func generate_collision_shapes():	
	if _use_collision_frame:
		toggle_collision_shape_children($CollisionFromImage, true)
		toggle_collision_shape_children($CollisionFromFrame, false)
	elif (_collision_image):
		toggle_collision_shape_children($CollisionFromImage, false)
		toggle_collision_shape_children($CollisionFromFrame, true)
		
		for n in $CollisionFromImage.get_children():
			$CollisionFromImage.remove_child(n)
			n.queue_free()
			
		var bitmap = BitMap.new()
		bitmap.create_from_image_alpha(_collision_image.get_image())

		var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()))

		for polygon in polygons:
			var collider = CollisionPolygon2D.new()
			collider.polygon = polygon
			$CollisionFromImage.add_child(collider)

func toggle_collision_shape_children(node: StaticBody2D, disabled: bool):
	for n in node.get_children():
		n.disabled = disabled
	node.visible = !disabled

func set_bg_texture(bg_texture: Texture2D):
	if (bg_texture == null):
		texture = null
	else:
		texture = bg_texture

func on_bg_anim_timer_timeout() -> void:
	if (not _bg_images.size() > 1):
		return
	
	_current_bg_index += 1
	if (_current_bg_index >= _bg_images.size()):
		_current_bg_index = 0
	set_bg_texture(_bg_images[_current_bg_index])
