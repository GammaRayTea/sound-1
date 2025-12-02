extends Enemy
@export var SPEED = 100
func _ready() -> void:
	super()
	priority = strategies["WalkRandom"]
	
