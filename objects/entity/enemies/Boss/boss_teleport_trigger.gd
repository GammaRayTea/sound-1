extends Area2D

@export var boss:Enemy
@export var path:Path2D
@export var follower:PathFollow2D
func _on_area_entered(_area):
	follower.progress = path.curve.get_baked_length()-300
	boss.priority.speed = 200
	boss.teleport(follower.global_position)
	await boss.priority.target_reached
	boss.priority = null
	boss.body.apply_force(Vector2(400,0))
	



func _on_area_2d_area_entered(area):
	var timer = Timer.new()
	add_child(timer)
	timer.start(2)
	await timer.timeout
	boss.stop()
