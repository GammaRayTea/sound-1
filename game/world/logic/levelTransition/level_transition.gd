class_name LevelTransition extends Node2D

@export var levelPath:String
var game:Game
signal transition
func _ready() -> void:

	game = get_tree().get_nodes_in_group("Game")[0]
	print(game)
	transition.connect(game.on_level_transition)

func _on_area_2d_area_entered(area: Area2D) -> void:
	
	
	transition.emit(levelPath,get_parent())
	print("transitioning...")
