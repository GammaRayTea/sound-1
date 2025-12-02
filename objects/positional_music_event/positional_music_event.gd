class_name PositionalMusicEvent extends Node2D
const MAX_DISTANCE = 570

var initialPosDifference:Vector2
var musicPlayer:MusicPlayer
var listener:FmodListener2D
@export var oneShot:bool
@export var changingProperty:String
var playerBody
var game:Game
func on_player_ready() -> void:
	
	
	game = get_tree(). get_first_node_in_group("Game")
	game.set_positional(true);
	
	musicPlayer = game.globalMusicPlayer
	listener = game.globalListener
	musicPlayer.get_parent().global_position = $EmitterStart.global_position
	listener.get_parent().global_position = $ListenerStart.global_position
	
	
	playerBody = game.player.body
	initialPosDifference = playerBody.get_bones_center_position() - global_position

func _physics_process(_delta):
	pass



func calc_scaled_distance_factor() -> float:
	var currentPosDifference:Vector2 =  playerBody.get_bones_center_position() - global_position
	var factor = (currentPosDifference.length()/initialPosDifference.length())
	return factor
	
func position_reached() -> void:
	if oneShot:
		if game:
			game.set_positional(false);
		queue_free()
		
