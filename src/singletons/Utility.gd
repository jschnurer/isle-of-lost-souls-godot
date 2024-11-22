extends Node

var to_title_case_regex = RegEx.new()

func _ready():
	to_title_case_regex.compile("_[a-z]")
	
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func show_message(message: String, has_more: bool = false):
	SignalBus.show_message.emit(message, has_more)
	await SignalBus.message_closed

func yes_no_choice_msg(msg_key: String, has_more: bool = false) -> Choice:
	SignalBus.show_message.emit(GameScript.get_entry(msg_key), has_more)
	SignalBus.show_choice.emit([GameScript.get_entry("Global.Yes"), GameScript.get_entry("Global.No")] as Array[String], 1, Enums.ChoiceLocation.CENTER, true)
	var choice = await SignalBus.choice_chosen
	await SignalBus.message_closed
	return choice
	
func choice_msg(msg_key: String, has_more: bool, choices: Array[String], cancel_index: int):
	SignalBus.show_message.emit(GameScript.get_entry(msg_key), has_more)
	SignalBus.show_choice.emit(choices, cancel_index, Enums.ChoiceLocation.CENTER, true)
	var choice = await SignalBus.choice_chosen
	await SignalBus.message_closed
	return choice
	
func msg(msg_key: String, has_more: bool = false):
	SignalBus.show_message.emit(GameScript.get_entry(msg_key), has_more)
	await SignalBus.message_closed

func open_dialog(dialog: BaseDialog):
	SignalBus.open_dialog_manager.emit(dialog)

func dialog_msg(msg_key: String, has_more: bool = false):
	SignalBus.show_dialog_message.emit(GameScript.get_entry(msg_key), has_more)
	await SignalBus.dialog_message_closed

func close_dialog():
	SignalBus.close_dialog_manager.emit()

func learn_topic(group: Enums.TopicGroups, topic: Enums.Topics):
	SignalBus.learn_topic.emit(group, topic)

func show_choice(choices: Array[String], cancel_index: int, choice_location: Enums.ChoiceLocation = Enums.ChoiceLocation.CENTER) -> Choice:
	SignalBus.show_choice.emit(choices, cancel_index, choice_location, false)
	return await SignalBus.choice_chosen

func show_yes_no_choice(choice_location: Enums.ChoiceLocation = Enums.ChoiceLocation.CENTER, has_simultaneous_message: bool = false) -> Choice:
	SignalBus.show_choice.emit([GameScript.get_entry("Global.Yes"), GameScript.get_entry("Global.No")] as Array[String], 1, choice_location, has_simultaneous_message)
	return await SignalBus.choice_chosen

func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false

func enum_str_to_title_case(enum_str: String):
	var title_str = enum_str.to_lower()
	return to_title_case_regex.sub(title_str, "$1".to_upper(), true)
	
func fade_out(instantly: bool = false, speed_scale: float = 1):
	var args = ScreenFadeArgs.new()
	args.instantly = args.instantly
	args.speed_scale = speed_scale
	SignalBus.fade_out_screen.emit(args)
	await SignalBus.fade_out_screen_finished
	
func fade_in(instantly: bool = false, speed_scale: float = 1):
	var args = ScreenFadeArgs.new()
	args.instantly = args.instantly
	args.speed_scale = speed_scale
	SignalBus.fade_in_screen.emit(args)
	await SignalBus.fade_in_screen_finished

func initiate_game_over(game_over_scene: Enums.Scenes, fade_speed_scale: float = 1, death_sfx: AudioStream = null, teleport_delay: float = 0):
	# Disable the player.
	var toggle_args = TogglePlayerArgs.new()
	toggle_args.is_visible = true
	toggle_args.is_controllable = false
	SignalBus.toggle_player.emit(toggle_args)
	
	if (death_sfx != null):
		# Play the death sound effect.
		var sfx_args = PlaySfxArgs.new()
		sfx_args.stream = death_sfx
		SignalBus.play_sfx.emit(sfx_args)
	
	# Fade out the screen.
	await Utility.fade_out(false, fade_speed_scale)
	
	if (teleport_delay > 0):
		# Wait for the teleport delay.
		await Utility.wait(teleport_delay)
	
	# Hide the player invisible.
	toggle_args.is_visible = false
	SignalBus.toggle_player.emit(toggle_args)
	
	# Teleport the player to the game over screen.
	var teleport_args = TeleportArgs.new()
	teleport_args.to_scene = game_over_scene
	SignalBus.transfer_player_to_scene.emit(teleport_args)

func go_to_sub_area(sub_area: Enums.Scenes):
	SignalBus.memorize_player_info.emit()
	SignalBus.set_player_mode.emit(Enums.PlayerMode.POINTER)
	
	var tele_args = TeleportArgs.new()
	tele_args.to_scene = sub_area
	tele_args.to_screen_center = true
	SignalBus.transfer_player_to_scene.emit(tele_args)

func parse_colors(message: String) -> String:
	var new_msg = ""
	
	var color_queue: Array[String] = []
	var curr_color = null
	var dialog_color = "white"
	var important_color = "yellow"
	var curly_color = "red"
	
	for c in message:
		var did_color_end = false
		
		if c == '"':
			if curr_color != dialog_color:
				color_queue.append(dialog_color)
				new_msg += "[color=%s]\"" % dialog_color
				curr_color = color_queue[color_queue.size() - 1]
			elif curr_color == dialog_color:
				color_queue.pop_back()
				if color_queue.size() > 0:
					curr_color = color_queue[color_queue.size() - 1]
				else:
					curr_color = null
				new_msg += '"[/color]'
				did_color_end = true
		elif c == "[":
			if curr_color != important_color:
				color_queue.append(important_color)
				new_msg += "[color=%s]" % important_color
				curr_color = color_queue[color_queue.size() - 1]
		elif c == "]" and curr_color == important_color:
				color_queue.pop_back()
				if color_queue.size() > 0:
					curr_color = color_queue[color_queue.size() - 1]
				else:
					curr_color = null
				new_msg += '[/color]'
				did_color_end = true
		elif c == "{":
			if curr_color != curly_color:
				color_queue.append(curly_color)
				new_msg += "[color=%s]" % curly_color
				curr_color = color_queue[color_queue.size() - 1]
		elif c == "}" and curr_color == curly_color:
				color_queue.pop_back()
				if color_queue.size() > 0:
					curr_color = color_queue[color_queue.size() - 1]
				else:
					curr_color = null
				new_msg += '[/color]'
				did_color_end = true
		else:
			new_msg += c
		
		if did_color_end and curr_color != null:
			new_msg += "[color=%s]" % curr_color
			
			
	return new_msg

func get_curr_area():
	return SceneManager.current_scene
