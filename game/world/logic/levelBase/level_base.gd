class_name Level extends Node2D

@onready var player:Player = get_tree().get_first_node_in_group("Game").player
@export var playerSpawn:Node2D
@export var transitions:Array[LevelTransition]
func set_spawn(_transitionId = null):
	
	if _transitionId:
		
		for i in transitions.size():
			
			if transitions[i].id == _transitionId:
				playerSpawn = transitions[i].spawnPoint
				transitions[i].just_spawned = true
				player.respawn(playerSpawn.global_position)
	
	player.respawn(playerSpawn.global_position)

func _ready() -> void:
	apply_cam_limits()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_page_up"):
		player.respawn(playerSpawn.global_position)




func apply_cam_limits():
	var localCam = $Camera2D
	
	player.camera.limit_bottom = localCam.limit_bottom
	player.camera.limit_left = localCam.limit_left
	player.camera.limit_right = localCam.limit_right
	player.camera.limit_right= localCam.limit_right
	localCam.queue_free()
		

func respawn()-> void:
	pass
	#print(player.body.global_position, playerSpawn.global_position)
	#player.global_position = playerSpawn.global_position
	#player.body.global_position = playerSpawn.global_position
	#
	#var bodies = player.body.get_rigid_bodies()
	#var center = player.body.get_center_body().rigidbody.global_position
	#for i in bodies.size():
		#var body:SoftBody2D.SoftBodyChild = bodies[i]
		#body.rigidbody.global_position= body.rigidbody.global_position - center + playerSpawn.global_position
	#print(player.body.global_position, playerSpawn.global_position)
