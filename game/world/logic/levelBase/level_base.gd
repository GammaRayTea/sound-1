class_name Level extends Node2D

@onready var player:Player = get_tree().get_first_node_in_group("Game").player
@export var playerSpawn:Node2D
@export var gradient:GradientTexture2D
@export var transitions:Array[LevelTransition]
func set_spawn(_transitionId = null):
	
	if _transitionId:
		
		for i in transitions.size():
			
			if transitions[i].id == _transitionId:
				playerSpawn = transitions[i].spawnPoint
				transitions[i].just_spawned = true
				
	
	player.teleport(playerSpawn.global_position)
	var game:Game = get_tree().get_first_node_in_group("Game")
	if game.doIntroEvent:
		
		get_tree().call_group("PlayerDependent","on_player_ready")

func _ready() -> void:
	if gradient:
		var background:BackgroundGradient =  get_tree().get_first_node_in_group("Background")
		background.set_background(gradient)
		
	apply_cam_limits()
	
	var checkpoints:Array = $Checkpoints.get_children()
	for i in checkpoints.size():
		var checkpoint:Checkpoint = checkpoints[i]
		checkpoint.level = self
		
	




func apply_cam_limits():
	var localCam = $Camera2D
	
	player.camera.limit_bottom = localCam.limit_bottom
	player.camera.limit_left = localCam.limit_left
	player.camera.limit_right = localCam.limit_right
	player.camera.limit_right= localCam.limit_right
	localCam.queue_free()
		

#func respawn_player()-> void:
	#if playerSpawn.get_parent() is LevelTransition:
		#playerSpawn.get_parent().just_spawned = true
	#
	#player.reset_values()
