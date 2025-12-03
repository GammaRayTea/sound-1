extends Strategy
var path:Path2D
var follower:PathFollow2D
var boss:Enemy
var speed
var player:Player
signal target_reached
func _ready() -> void:
	path = get_parent().path
	follower = path.get_child(0)
	boss = get_parent()
	speed = boss.SPEED
	player = get_tree().get_first_node_in_group("Game").player
	
func execute() -> void:
	follower.progress += speed*0.01
	if player.body.get_bones_center_position().distance_to(follower.global_position) > 1000:
		var boost = clampf(0.001 * player.body.get_bones_center_position().distance_to(follower.global_position),0.0, 0.4)
		follower.progress+= boost
		
		print(player.body.get_bones_center_position().distance_to(follower.global_position))
	var force:Vector2
	force = follower.global_position - boss.body.get_bones_center_position()
	
	
	
	
	
	boss.body.apply_force(force)
	
	if follower.progress_ratio == 1:
		target_reached.emit()

func reset() -> void:
	follower.progress = 0
