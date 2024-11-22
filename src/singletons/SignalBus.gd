extends Node

@warning_ignore("unused_signal")
signal show_message(message: String, has_more: bool)

@warning_ignore("unused_signal")
signal message_closed()

@warning_ignore("unused_signal")
signal toggle_player(toggle_args: TogglePlayerArgs)

@warning_ignore("unused_signal")
signal transfer_player_to_scene(transfer_args: TeleportArgs)

@warning_ignore("unused_signal")
signal teleport_player(location: Vector2, facing: Enums.Direction)

@warning_ignore("unused_signal")
signal play_bgm(stream: AudioStream, volume: float)

@warning_ignore("unused_signal")
signal stop_bgm()

@warning_ignore("unused_signal")
signal play_sfx(play_sfx_args: PlaySfxArgs)

@warning_ignore("unused_signal")
signal game_event_entered_range(game_event: GameEvent)

@warning_ignore("unused_signal")
signal game_event_exited_range(game_event: GameEvent)

@warning_ignore("unused_signal")
signal memorize_player_info()

@warning_ignore("unused_signal")
signal restore_player_info()

@warning_ignore("unused_signal")
signal set_player_mode(mode: Enums.PlayerMode)

@warning_ignore("unused_signal")
signal show_item_chooser()

@warning_ignore("unused_signal")
signal item_chooser_closed()

@warning_ignore("unused_signal")
signal show_action_chooser()

@warning_ignore("unused_signal")
signal action_chooser_closed(chosen_action)

@warning_ignore("unused_signal")
signal fade_out_screen(fade_args: ScreenFadeArgs)

@warning_ignore("unused_signal")
signal fade_out_screen_finished()

@warning_ignore("unused_signal")
signal fade_in_screen(fade_args: ScreenFadeArgs)

@warning_ignore("unused_signal")
signal fade_in_screen_finished()

@warning_ignore("unused_signal")
signal return_to_title_screen()

@warning_ignore("unused_signal")
signal on_game_var_set(var_name: Enums.Vars, value)

@warning_ignore("unused_signal")
signal open_dialog_manager(dialog: BaseDialog)

@warning_ignore("unused_signal")
signal close_dialog_manager(dialog: BaseDialog)

@warning_ignore("unused_signal")
signal show_dialog_message(message: String, has_more: bool)

@warning_ignore("unused_signal")
signal dialog_message_closed()

@warning_ignore("unused_signal")
signal learn_topic(topic_group: Enums.TopicGroups, topic: Enums.Topics)

@warning_ignore("unused_signal")
signal on_topic_learned(topic_group: Enums.TopicGroups, topic: Enums.Topics)

@warning_ignore("unused_signal")
signal show_choice(choices: Array[String], cancel_index: int, choice_location: Enums.ChoiceLocation)

@warning_ignore("unused_signal")
signal choice_chosen(choice: Choice)

@warning_ignore("unused_signal")
signal open_inventory(mode: Enums.InventoryMode)

@warning_ignore("unused_signal")
signal inventory_closed(item: Item)

@warning_ignore("unused_signal")
signal global_use_item(item: Item)

@warning_ignore("unused_signal")
signal save_game(slot: int)

@warning_ignore("unused_signal")
signal load_game(slot_number: int)

@warning_ignore("unused_signal")
signal open_pause_menu()
