extends Node2D


@export var rotation_speed = PI


func _physics_process(delta: float) -> void:
	position+=Vector2(1,0)
