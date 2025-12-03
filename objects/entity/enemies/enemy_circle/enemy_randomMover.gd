extends Enemy
@export var SPEED = 100
@export var visNotif:VisibleOnScreenNotifier2D
func _ready() -> void:
	super()
	visNotif.screen_entered.connect(musicPlayer.enemy_entered)
	visNotif.screen_exited.connect(musicPlayer.enemy_exited)
	

	
	priority = strategies["WalkRandom"]
	$Followers/Plop.play()
