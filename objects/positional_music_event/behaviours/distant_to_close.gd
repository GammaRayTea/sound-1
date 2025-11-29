extends PositionalMusicEvent


func _physics_process(_delta):
	musicPlayer["fmod_parameters/reverb_crossfade"] = clampf(1- calc_scaled_distance_factor(),0.1,1)
	print(musicPlayer["fmod_parameters/reverb_crossfade"])
