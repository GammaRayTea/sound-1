class_name Game extends Node2D

@export var startLevel:PackedScene
@onready var startLevelPath = startLevel.resource_path
@export var playerScene:PackedScene
var screenTransition:ScreenTransisiton
var player:Player

func _ready() -> void:
	screenTransition = preload("res://game/screenTransition/screen_transition.tscn").instantiate()
	add_child(screenTransition)



func _on_start_pressed() -> void:
	on_level_transition(startLevelPath)
	



func on_level_transition(packedLevelPath:String, previousLevel:Level = null) -> void:
	var level = load(packedLevelPath)
	
	screenTransition.start(3)
	await screenTransition.transition_point_reached
	if previousLevel:
		previousLevel.queue_free()
	if !player:
		player =  playerScene.instantiate()
		add_child(player)
		$Menu.queue_free()
	add_child(level.instantiate())
	
	
