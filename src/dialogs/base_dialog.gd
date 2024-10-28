class_name BaseDialog
extends Node

var topic_group: Enums.TopicGroups = Enums.TopicGroups.GLOBAL

func ask_about(_topic: Enums.Topics):
	if (_topic == Enums.Topics.GOODBYE):
		SignalBus.close_dialog_manager.emit()

func on_greet():
	pass
