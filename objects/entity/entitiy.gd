class_name Entity extends Node2D

@onready var body:SoftBody2D = $Body
@export var MAX_SPEED = 600
func _physics_process(delta: float) -> void:
	$Followers.global_position = body.get_bones_center_position()

func clamp_speed() -> void:
	var center:PhysicsBody2D = body.get_center_body().rigidbody
	if abs(center.linear_velocity.x) > MAX_SPEED:
		body.apply_force(Vector2(-center.linear_velocity.x,0))
