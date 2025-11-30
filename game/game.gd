class_name Game extends Node2D

@export var startLevel:PackedScene
@onready var startLevelPath = startLevel.resource_path
@export var playerScene:PackedScene

@export var globalMusicPlayer:FmodEventEmitter2D
@export var globalListener:FmodListener2D

var screenTransition:ScreenTransisiton
var player:Player
var checkPoint
var level
func _ready() -> void:
	screenTransition = preload("res://game/screenTransition/screen_transition.tscn").instantiate()
	add_child(screenTransition)



func _on_start_pressed() -> void:
	on_level_transition(startLevelPath)
	$Menu/CanvasLayer/Container/Start.disabled = true


func on_level_transition(_packedLevelPath:String,_id = null, _previousLevel:Level = null) -> void:
	var packedLevel = load(_packedLevelPath)
	
	screenTransition.startTransition(3)
	await screenTransition.transition_point_reached
	if _previousLevel:
		_previousLevel.queue_free()
	if !player:
		player =  playerScene.instantiate()
		add_child(player)
		$Menu.queue_free()
		globalMusicPlayer.play()
		globalMusicPlayer.enable_track(globalMusicPlayer.tracks.pad)
	
	
	level = packedLevel.instantiate()
	add_child(level)

	level.set_spawn(_id)
	screenTransition.endTransition(3)

func set_positional(state:bool) -> void:
	if state:
		globalMusicPlayer.attached = true
	else:
		globalMusicPlayer.attached = false
		
