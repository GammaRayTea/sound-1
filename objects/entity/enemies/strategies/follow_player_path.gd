extends Strategy
var path:Path2D
var follower:PathFollow2D
var boss:Enemy
var speed
func _ready() -> void:
	path = get_parent().path
	follower = path.get_child(0)
	boss = get_parent()
	speed = boss.SPEED

func execute() -> void:
	follower.progress += speed*0.01
	var force:Vector2
	
	force = follower.global_position - boss.body.get_bones_center_position()
	print(boss.body.get_bones_center_position())
	
	boss.body.apply_force(force)

func reset() -> void:
	follower.progress = 0
