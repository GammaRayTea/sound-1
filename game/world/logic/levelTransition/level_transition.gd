class_name LevelTransition extends Node2D
@export var id:String
@export var levelPath:String
@export var spawnPoint:Node
@export var exitArea:Area2D
@export var repeatPreventer:Area2D
var game:Game
var just_spawned:bool

signal transition
func _ready() -> void:
	if !just_spawned:
		exitArea.get_child(0).set_deferred("disabled",false)
	game = get_tree().get_nodes_in_group("Game")[0]
	transition.connect(game.on_level_transition)

func _on_exit_area_entered(_area: Area2D) -> void:
	
	if !just_spawned:
		get_tree().call_group("PlayerDependent","position_reached")
		exitArea.get_child(0).set_deferred("disabled",true)
		transition.emit(levelPath, id, get_parent())
		
		print("transitioning...")



func _on_repeat_preventer_area_exited(_area: Area2D) -> void:
	print("aaaaaa")
	if just_spawned:
		just_spawned = false
		exitArea.get_child(0).set_deferred("disabled",false)
