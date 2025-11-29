class_name PositionalMusicEvent extends Node2D
const MAX_DISTANCE = 570

var initalPosDifference:Vector2
@export var musicPlayer:MusicPlayer
@export var listener:FmodListener2D
@export var oneShot:bool
@export var changingProperty:String
var playerBody
var game:Game
func on_player_ready() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	print("ready")
	game = get_tree(). get_first_node_in_group("Game")
	game.set_positional(true);
	playerBody = game.player.body
	initalPosDifference = playerBody.get_bones_center_position() - global_position
	musicPlayer.play()

func _physics_process(_delta):
	print(calc_scaled_distance_factor())



func calc_scaled_distance_factor() -> float:
	var currentPosDifference:Vector2 =  playerBody.get_bones_center_position() - global_position
	var factor = (currentPosDifference.length()/initalPosDifference.length())
	return factor
	
func position_reached() -> void:
	if oneShot:
		musicPlayer.stop()
		game.set_positional(false);
		queue_free()
