extends PositionalMusicEvent


func _physics_process(_delta):
	musicPlayer["fmod_parameters/reverb_crossfade"] = clampf(1- calc_scaled_distance_factor(),0.1,1)
	if musicPlayer["fmod_parameters/reverb_crossfade"] > 0.98:
		print("reached")
		position_reached()
