class_name Level extends Node2D

@onready var playerSpawn = $PlayerSpawn

func _ready() -> void:
	playerSpawn.get_child(0).hide()
	
	var localCam = $Camera2D
	var player:Player = get_parent().player
	print(player.global_position, playerSpawn.global_position)
	player.body.clear_softbody2d()
	player.global_position = playerSpawn.global_position
	player.body.global_position = playerSpawn.global_position
	player.body.create_softbody2d(true)
	#print(segments[2].rigidbody.global_position)
	#for i in segments.size():
		#var boneOffset:Vector2 = player.body.get_bones_center_position() - segments[i].rigidbody.global_position
		#segments[i].rigidbody.global_position = playerSpawn.global_position + boneOffset
	

	
	
	
	player.camera.limit_bottom = localCam.limit_bottom
	player.camera.limit_left = localCam.limit_left
	player.camera.limit_right = localCam.limit_right
	player.camera.limit_right= localCam.limit_right
	localCam.queue_free()
	
	
