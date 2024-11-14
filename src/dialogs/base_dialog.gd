class_name BaseDialog
extends Node

@export var portrait_texture: Texture2D
@export var flip_portrait_h = false
@export var topic_group: Enums.TopicGroups = Enums.TopicGroups.GLOBAL

func ask_about(_topic: Enums.Topics):
	if (_topic == Enums.Topics.GOODBYE):
		SignalBus.close_dialog_manager.emit()

func on_greet():
	pass
