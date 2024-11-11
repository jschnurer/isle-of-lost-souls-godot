extends BaseEvent

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
	await Utility.fade_out(false, 2)

	# Hide the player invisible.
	toggle_args.is_visible = false
	SignalBus.toggle_player.emit(toggle_args)
	
	# Wait 3 seconds
	await Utility.wait(3)
	
	# Teleport the player to the game over screen.
	var teleport_args = TeleportArgs.new()
	teleport_args.to_scene = Enums.Scenes.GAME_OVER_GRUE
	SignalBus.transfer_player_to_scene.emit(teleport_args)
