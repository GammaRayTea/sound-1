extends Node2D

@export var startLevel:PackedScene

func _ready() -> void:
	pass
	


func _on_start_pressed() -> void:
	$Menu.queue_free()
	add_child(startLevel.instantiate())
	
