extends Node2D


@export var rotation_speed = PI


func _process(delta):
	position+=Vector2(10,0)
