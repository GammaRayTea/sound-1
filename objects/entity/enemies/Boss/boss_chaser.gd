extends Enemy
@export var SPEED = 100
@export var path:Path2D
@export var breakable:BreakableBlock
func _ready() -> void:
	super()
	priority = null
	musicPlayer.boss_entered()
	await breakable.broken
	visNotif.queue_free()

	start()

func start() -> void:
	priority = strategies["FollowPlayerPath"]
	print(priority)

func reset_position() -> void:
	super()
	strategies["FollowPlayerPath"].reset()
	breakable.reset()
	priority = null
	await breakable.broken
	start()
