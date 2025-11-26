extends Strategy
var maxWalkDelay:int = 5 * Engine.physics_ticks_per_second
var countdown:int = 0
var entity:Entity
var walkDirection:int = randi_range(-1 , 1)
var speed

func _ready() -> void:
	entity = get_parent()
	speed = entity.SPEED

func execute() -> void:
	if countdown > 0:
		entity.body.apply_force(Vector2( walkDirection * speed, 0 ))
		countdown-=1
	else:
		walkDirection = randi_range(-1 , 1)
		if walkDirection == 0:
			countdown = randi_range(30,2*Engine.physics_ticks_per_second)
		else:
			countdown = randi_range(60,maxWalkDelay)
