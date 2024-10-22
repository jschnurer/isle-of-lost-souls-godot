extends Sprite2D

func _ready():
	$GameEvent.connect("on_activate", _on_activate)

func _on_activate():
	var message = "It's a small, smooth stone."
	SignalBus.show_message.emit(message, false)
