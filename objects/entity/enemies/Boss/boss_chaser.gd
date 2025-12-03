extends Enemy
@export var SPEED = 100
@export var path:Path2D
@export var breakable:BreakableBlock

func _ready() -> void:
	super()
	priority = null
	musicPlayer.boss_entered()
	await breakable.broken
	musicPlayer.boss_started()

	start()

func start() -> void:
	priority = strategies["FollowPlayerPath"]
	$Followers/Bass.play()


func reset_position() -> void:
	super()
	strategies["FollowPlayerPath"].reset()
	breakable.reset()
	priority = null
	await breakable.broken
	start()

func stop() -> void:
	$Followers/Bass["fmod_parameters/stop"] = "true"
	musicPlayer.boss_exited()
	queue_free()
