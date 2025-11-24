class_name Level extends Node2D


@onready var playerSpawn = $PlayerSpawn

func _ready() -> void:
	var playerScene = preload("res://game/player/player.tscn")
	var player =  playerScene.instantiate()
	add_child(player)
	player.position = playerSpawn.position
	playerSpawn.get_child(0).queue_free()
