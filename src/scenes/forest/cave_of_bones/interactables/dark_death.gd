extends "res://src/events/game_event/base_event.gd"

@export var grue_sound: AudioStream

func collide():
	# Disable the player.
	var toggle_args = TogglePlayerArgs.new()
	toggle_args.is_visible = true
	toggle_args.is_controllable = false
	SignalBus.toggle_player.emit(toggle_args)
	
	# Play the death sound effect.
	var sfx_args = PlaySfxArgs.new()
	sfx_args.stream = grue_sound
	SignalBus.play_sfx.emit(sfx_args)
	
	# Fade out the screen quickly.
	var fade_out_args = ScreenFadeArgs.new()
	fade_out_args.color = Color.BLACK
	fade_out_args.speed_scale = 2
	SignalBus.fade_out_screen.emit(fade_out_args)
	await SignalBus.fade_out_screen_finished
	
	# Hide the player invisible.
	toggle_args.is_visible = false
	SignalBus.toggle_player.emit(toggle_args)
	
	# Wait 3 seconds
	await Utility.wait(3)
	
	# Teleport the player to the game over screen.
	var teleport_args = TeleportArgs.new()
	teleport_args.to_scene = Enums.Scenes.GAME_OVER_GRUE
	SignalBus.transfer_player_to_scene.emit(teleport_args)
