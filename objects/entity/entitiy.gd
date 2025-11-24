class_name Entitiy extends Node2D

@onready var body:SoftBody2D= $Body

func _physics_process(delta: float) -> void:
	$Followers.global_position = body.get_child(3).global_position
