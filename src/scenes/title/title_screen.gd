extends CanvasLayer

@onready var anim_player = $AnimationPlayer

func _ready():
	var args = TogglePlayerArgs.new()
	args.is_controllable = false
	SignalBus.toggle_player.emit(args)

func _on_fade_in_complete():
	var args = TogglePlayerArgs.new()
	args.is_controllable = true
	args.is_visible = true
	SignalBus.toggle_player.emit(args)
	show_menu()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept") and anim_player.is_playing()):
		# Skip to the end
		anim_player.seek(3)

func show_menu():
	var most_recent_save_slot = 0
	
	if (FileAccess.file_exists("user://meta.save")):
		var json_as_text = FileAccess.get_file_as_string("user://meta.save")
		var meta_info = JSON.parse_string(json_as_text)
		most_recent_save_slot = int(meta_info.most_recent_save_slot)
		
	var choices: Array[String] = [
		GameScript.get_entry("Global.New_Game"),
		GameScript.get_entry("Global.Load"),
		GameScript.get_entry("Global.Quit")
	]
	
	if (most_recent_save_slot > 0):
		choices.insert(0, GameScript.get_entry("Global.Continue"))
	
	var choice = await Utility.show_choice(choices, 3)
	
	handle_choice(choice, most_recent_save_slot)
	
func handle_choice(choice: Choice, most_recent_save_slot: int):
	var continue_text = GameScript.get_entry("Global.Continue")
	var new_text = GameScript.get_entry("Global.New_Game")
	var load_text = GameScript.get_entry("Global.Load")
		
	if (choice.text == continue_text):
		# Continue
		SignalBus.fade_out_screen.emit(ScreenFadeArgs.new())
		await SignalBus.fade_out_screen_finished
		
		SignalBus.load_game.emit(most_recent_save_slot)
	elif (choice.text == new_text):
		# New Game
		# TODO: Show new game slot choice.
		pass
	elif (choice.text == load_text):
		# Load Game
		# TODO: Show load slot choice.
		pass
	else:
		get_tree().quit()
	
	
