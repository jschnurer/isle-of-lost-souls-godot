@tool
extends CanvasLayer

func _on_button_pressed() -> void:
	var str = $TextEdit.text as String
	Utility.show_message(str.replacen("\\n", "\n").replacen("\\", ""))
