extends "res://src/events/game_event/base_event.gd"

@export var death_sound: AudioStream

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_RIVER_ROD)):
		queue_free()
	else:
		super._ready()

func investigate():
	Utility.show_message(GameScript.get_entry("Forest.Bridge_South.Rod_Look"))

func take():
	if (!GameVars.get_var(Enums.Vars.DISTRACTED_FISH)):
		# Disable the player.
		var toggle_args = TogglePlayerArgs.new()
		toggle_args.is_visible = true
		toggle_args.is_controllable = false
		SignalBus.toggle_player.emit(toggle_args)
		
		# Play the death sound effect.
		var sfx_args = PlaySfxArgs.new()
		sfx_args.stream = death_sound
		SignalBus.play_sfx.emit(sfx_args)
		
		# Fade out the screen quickly.
		await Utility.fade_out(false, 3)
		
		# Hide the player invisible.
		toggle_args.is_visible = false
		SignalBus.toggle_player.emit(toggle_args)
		
		# Teleport the player to the game over screen.
		var teleport_args = TeleportArgs.new()
		teleport_args.to_scene = Enums.Scenes.GAME_OVER_FISH
		SignalBus.transfer_player_to_scene.emit(teleport_args)
	else:
		$AnimatedSprite2D.queue_free()
		await Utility.show_message(GameScript.get_entry("Forest.Bridge_South.Rod_Take_Successful"))
		Inventory.add_item(Enums.ItemSlugs.RUINS_ROD)
		GameVars.set_var(Enums.Vars.TOOK_RIVER_ROD, true)
		queue_free()
