extends Node2D

func _ready():
	$GameEvent.connect("on_activate", _on_activate)

func _on_activate():
	var message = "It's a small hole in the dirt."
	
	SignalBus.show_message.emit(message, false)
	await SignalBus.show_message_finished
	
	SignalBus.remember_player_location.emit()
	SignalBus.remember_player_facing.emit()
	SignalBus.toggle_pointer_mode.emit(true)
	
	var tele_args = TeleportArgs.new()
	tele_args.to_scene = Enums.Scenes.FOREST_CLEARING_HOLE
	tele_args.to_screen_center = true
	SignalBus.transfer_player_to_scene.emit(tele_args)
