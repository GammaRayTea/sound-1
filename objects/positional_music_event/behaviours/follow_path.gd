extends PositionalMusicEvent

var initialListenerPos:Vector2
var initialListenerDistance:Vector2
var follower:PathFollow2D

func on_player_ready() -> void:
	super()
	
	if !game.doIntroEvent:
		queue_free()
	else:
		musicPlayer["fmod_parameters/reverb_crossfade"] = 0
		follower = $Path2D/PathFollow2D
		initialListenerPos = $ListenerStart.global_position
		initialListenerDistance = initialListenerPos-$EmitterStart.global_position
		process_mode = Node.PROCESS_MODE_INHERIT
		
func _physics_process(_delta):
	if game.doIntroEvent:
		musicPlayer["fmod_parameters/reverb_crossfade"] = clampf(1- calc_scaled_distance_factor(),0.1,1)
		follower.progress_ratio = calc_scaled_distance_factor()
	
		musicPlayer.get_parent().global_position = follower.global_position
		listener.get_parent().global_position =  playerBody.get_bones_center_position()
	
	
		if musicPlayer["fmod_parameters/reverb_crossfade"] > 0.98:
			musicPlayer["fmod_parameters/reverb_crossfade"] = 1
			listener.get_parent().global_position = Vector2(-179493.0,-113816.0)
			musicPlayer.get_parent().global_position = Vector2(-179493.0,-113816.0)
			game.doIntroEvent = false
			print(game.doIntroEvent)
			position_reached()
		
