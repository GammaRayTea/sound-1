class_name Entity extends Node2D

@onready var body:SoftBody2D = $Body
@export var MAX_SPEED = 600
func _physics_process(_delta: float) -> void:
	$Followers.global_position = body.get_bones_center_position()

func clamp_speed() -> void:
	var center:PhysicsBody2D = body.get_center_body().rigidbody
	if abs(center.linear_velocity.x) > MAX_SPEED:
		body.apply_force(Vector2(-center.linear_velocity.x,0))
		
		
func teleport(_targetPos:Vector2)->void:
	var bodies = body.get_rigid_bodies()
	var center = body.get_center_body().rigidbody.global_position
	
	#global_position = _targetPos
	#body.global_position = _targetPos
	print(_targetPos)
	for i in bodies.size():
		bodies[i].rigidbody.global_position= bodies[i].rigidbody.global_position - center + _targetPos
