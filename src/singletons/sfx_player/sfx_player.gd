extends Node2D

@export var sfx_emitter_scene: PackedScene

func _ready():
	SignalBus.play_sfx.connect(_on_play_sfx)

func _on_play_sfx(args: PlaySfxArgs):
	var emitter_node: AudioStreamPlayer2D = sfx_emitter_scene.instantiate()
	emitter_node.stream = args.stream
	emitter_node.volume_db = args.volume_db
	emitter_node.pitch_scale = args.pitch_scale
	
	# If there are already 6 or more sfx playing, remove the first one's emitter.
	if (get_child_count() >= 6):
		get_child(0).queue_free()
	
	add_child(emitter_node)
