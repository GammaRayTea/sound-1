extends Node2D

@export var startLevel:PackedScene
@export var player:PackedScene
var transition:ScreenTransisiton
func _ready() -> void:
	transition = preload("res://game/screenTransition/screen_transition.tscn").instantiate()
	add_child(transition)


func _on_start_pressed() -> void:
	print("a")
	transition.start(3)
	await transition.transition_point_reached
	$Menu.queue_free()
	add_child(startLevel.instantiate())
	print()
