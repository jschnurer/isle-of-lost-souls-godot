@tool
class_name SceneBG
extends TextureRect

var _current_bg_index = 0
var _bg_images: Array[Texture2D] = []
var _bg_anim_frame_duration = .333
var _bg_anim_elapsed = 0
var _collision_image: Texture2D
var _hide_collider: bool = false
var _use_collision_frame: bool

@export var scene: Enums.Scenes = Enums.Scenes.CAVES_BAT_DEN
@export var area: Enums.Areas
@export var room: String = ""
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
@export var hide_collider: bool :
	set(value):
		_hide_collider = value
		$CollisionFromFrame.visible = not value
		$CollisionFromImage.visible = not value
	get:
		return _hide_collider
@export var bgm_stream: AudioStream
@export var bgm_volume_db: float = 1

func _ready():
	if (bgm_stream):
		SignalBus.play_bgm.emit(bgm_stream, bgm_volume_db)
	else:
		SignalBus.stop_bgm.emit()
	
	parse_obstacles()

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
			collider.name = "ImgColliderPolygon"
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

func parse_obstacles():
	var nav_region: NavigationRegion2D = get_tree().get_first_node_in_group("World")
	nav_region.bake_navigation_polygon()
	
	pass
	# Wait for the next frame so that all game objects can update their positions/existence.
	#var nav_region: NavigationRegion2D = $NavigationRegion2D
	#
	#if (nav_region and _collision_image):
		## Clear existing obstacles.
		#var children = nav_region.get_children()
		#for c in children:
			#c.free()
		#
		#var col_polys: Array[CollisionPolygon2D]
		#var col_shapes: Array
		#
		#var static_bodies = find_children("*", "StaticBody2D")
		#
		##for sb in static_bodies:
			##var sb_children = sb.get_children()
			##
			##for chl in sb_children:
				##if (chl is CollisionPolygon2D and not chl.disabled):
					##col_polys.append(chl)
				##elif (chl is CollisionShape2D and not chl.disabled):
					##col_shapes.append(chl)
		##
		#for shape in col_polys:
			#var obstacle: NavigationObstacle2D = NavigationObstacle2D.new()
			#obstacle.vertices = shape.polygon
			#obstacle.avoidance_enabled = true
			#obstacle.radius = 40
			#obstacle.affect_navigation_mesh = true
			#obstacle.carve_navigation_mesh = true
			#nav_region.add_child(obstacle)
			#
		#for shape in col_shapes:
			#if shape.shape is RectangleShape2D:
				#var glob_pos = (shape as CollisionShape2D).global_position
				#var obstacle = NavigationObstacle2D.new()
				#var rect = (shape.shape as RectangleShape2D).get_rect()
				#var center = rect.get_center()
				#
				#obstacle.vertices = PackedVector2Array([
					#Vector2(center.x - rect.size.x / 2 + glob_pos.x, center.y - rect.size.y / 2 + glob_pos.y),
					#Vector2(center.x + rect.size.x / 2 + glob_pos.x, center.y - rect.size.y / 2 + glob_pos.y),
					#Vector2(center.x + rect.size.x / 2 + glob_pos.x, center.y + rect.size.y / 2 + glob_pos.y),
					#Vector2(center.x - rect.size.x / 2 + glob_pos.x, center.y + rect.size.y / 2 + glob_pos.y),
				#])
				#obstacle.avoidance_enabled = true
				#obstacle.radius = 40
				#obstacle.affect_navigation_mesh = true
				#obstacle.carve_navigation_mesh = true
				#nav_region.add_child(obstacle)
		#
		#nav_region.bake_navigation_polygon()
