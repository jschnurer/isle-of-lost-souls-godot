@tool
extends TextureRect

var _current_bg_index = 0
var _bg_images: Array[Texture2D] = []
var _bg_anim_frame_duration = .333
var _bg_anim_elapsed = 0
var _collision_image: Texture2D

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
		generate_collision_shapes(value)
	get:
		return _collision_image

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

func generate_collision_shapes(collisionTexture: Texture2D):
	for n in $CollisionArea.get_children():
		$CollisionArea.remove_child(n)
		n.queue_free()
	
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(collisionTexture.get_image())

	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()))

	for polygon in polygons:
		var collider = CollisionPolygon2D.new()
		collider.polygon = polygon
		$CollisionArea.add_child(collider)

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
