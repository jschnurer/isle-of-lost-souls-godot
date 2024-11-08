extends CanvasLayer

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@export var title_music: AudioStream

func _ready():
	var args = TogglePlayerArgs.new()
	args.is_controllable = false
	SignalBus.toggle_player.emit(args)
	
	# Fade screen in.
	Utility.fade_in()
	
	SignalBus.play_bgm.emit(title_music, 1)

func _on_fade_in_title_complete():
	var args = TogglePlayerArgs.new()
	args.is_controllable = true
	args.is_visible = true
	SignalBus.toggle_player.emit(args)
	show_menu()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_accept") and anim_player.is_playing()):
		anim_player.seek(anim_player.get_animation("title_fade_in").length)

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
		FileAccess.file_exists("user://savegame" + str(most_recent_save_slot) + ".save")
		choices.insert(0, GameScript.get_entry("Global.Continue"))
	
	var choice = await Utility.show_choice(choices, 3)
	
	handle_choice(choice, most_recent_save_slot)
	
func handle_choice(choice: Choice, most_recent_save_slot: int):
	var continue_text = GameScript.get_entry("Global.Continue")
	var new_text = GameScript.get_entry("Global.New_Game")
	var load_text = GameScript.get_entry("Global.Load")
		
	if (choice.text == continue_text):
		# Continue
		await Utility.fade_out()
		SignalBus.load_game.emit(most_recent_save_slot)
	elif (choice.text == new_text):
		# New Game
		#SignalBus.fade_out_screen.emit(ScreenFadeArgs.new())
		#await SignalBus.fade_out_screen_finished
		
		var args = TogglePlayerArgs.new()
		args.is_controllable = true
		args.is_visible = true
		SignalBus.toggle_player.emit(args)
		
		var tele_args = TeleportArgs.new()
		tele_args.to_location = Vector2(142, 420)
		tele_args.to_scene = Enums.Scenes.FOREST_CLEARING
		SignalBus.transfer_player_to_scene.emit(tele_args)
	elif (choice.text == load_text):
		# Load Game
		# TODO: Show load slot choice.
		pass
	else:
		get_tree().quit()
	
	
