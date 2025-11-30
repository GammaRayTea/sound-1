class_name MusicPlayer extends FmodEventEmitter2D

var tracks:Dictionary = {
	kick = "fmod_parameters/fade_kick",
	drums = "fmod_parameters/fade_drums",
	rhodes = "fmod_parameters/fade_rhodes",
	pad = "fmod_parameters/fade_pad",
	melody = "fmod_parameters/fade_melody"
}
func enable_track(key:String)->void:
	self[key] = 1


func disable_track(key:String)->void:
	self[key] = 0

func enemy_entered()->void:
	
	enable_track(tracks.kick)
	enable_track(tracks.melody)
	
func enemy_exited()->void:
	disable_track(tracks.kick)
	disable_track(tracks.melody)
