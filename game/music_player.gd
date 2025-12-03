class_name MusicPlayer extends FmodEventEmitter2D

static var tracks:Dictionary = {
	kick = "fmod_parameters/fade_kick",
	drums = "fmod_parameters/fade_drums",
	rhodes = "fmod_parameters/fade_rhodes",
	pad = "fmod_parameters/fade_pad",
	melody = "fmod_parameters/fade_melody",
	boss = "fmod_parameters/fade_boss"
}

var boss_active:bool = false
func enable_track(key:String)->void:
	self[key] = 1


func disable_track(key:String)->void:
	self[key] = 0

func enemy_entered()->void:
	if !boss_active:

		enable_track(tracks.kick)
		enable_track(tracks.melody)
	
func enemy_exited()->void:
	print("exited")

	if !boss_active:
		disable_track(tracks.kick)
		disable_track(tracks.melody)
	
	

func boss_entered() -> void:
	self["fmod_parameters/State"] = "Fill"
	boss_active = true
	volume = 1.0
	
func boss_started() -> void: 

	self["fmod_parameters/State"] = "Normal"
func boss_exited()->void:
	boss_active = false
	disable_track(tracks.boss)
	disable_track(tracks.rhodes)
	self[tracks.drums] = 0
	disable_track(tracks.kick)
	disable_track(tracks.melody)
	disable_track(tracks.pad)
