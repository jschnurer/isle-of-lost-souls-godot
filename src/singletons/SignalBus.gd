extends Node

@warning_ignore("unused_signal")
signal show_message(message: String, has_more: bool)

@warning_ignore("unused_signal")
signal show_message_finished()

@warning_ignore("unused_signal")
signal transfer_player_to_scene(transfer_args: TeleportArgs)

@warning_ignore("unused_signal")
signal play_bgm(stream: AudioStream, volume: float)

@warning_ignore("unused_signal")
signal stop_bgm()

@warning_ignore("unused_signal")
signal set_game_var(var_name: Enums.Vars, value)

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
