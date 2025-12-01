extends PositionalMusicEvent

var initialListenerPos:Vector2
var initialListenerDistance:Vector2
func on_player_ready() -> void:
	super()
	initialListenerPos = $ListenerStart.global_position
	initialListenerDistance = initialListenerPos-$EmitterStart.global_position
	
func _physics_process(_delta):
	musicPlayer["fmod_parameters/reverb_crossfade"] = clampf(1- calc_scaled_distance_factor(),0.1,1)
	
	
	listener.global_position = initialListenerPos + initialListenerDistance*-clampf(0.1+ 1-calc_scaled_distance_factor(),0.1,1)

	print(initialListenerDistance*-(1-calc_scaled_distance_factor()))
	
	if musicPlayer["fmod_parameters/reverb_crossfade"] > 0.98:
		musicPlayer["fmod_parameters/reverb_crossfade"] = 1
		listener.position = Vector2(0,0)
		print("reached")
		position_reached()
