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
	var bodies:Array[SoftBody2D.SoftBodyChild] = body.get_rigid_bodies()
	var center = body.get_center_body().rigidbody.global_position
	for i in bodies.size():
		bodies[i].rigidbody.global_position= bodies[i].rigidbody.global_position - center + _targetPos

func stop_velocity() -> void:
	var bodies = body.get_rigid_bodies()
	for i in bodies.size():
		var elementBody:RigidBody2D = bodies[i].rigidbody
		elementBody.linear_velocity = Vector2(0,0)
