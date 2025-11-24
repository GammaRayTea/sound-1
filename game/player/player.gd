extends Entitiy
@export var SPEED = 80
@export var MAX_SPEED = 600
@export var JUMPFORCE = 4000
#@onready var body:SoftBody2D= $Body
@export var raycasts:Array[RayCast2D]

func _physics_process(delta: float) -> void:
	super(delta)
	input()
	clamp_speed()
func input()->void:
	if Input.is_action_pressed("left"):
		body.apply_force(Vector2(-SPEED,0))

	if Input.is_action_pressed("right"):
		body.apply_force(Vector2(SPEED,0))
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		print("jumped")
		body.apply_force(Vector2(0,-JUMPFORCE))
	


func clamp_speed() -> void:
	var center:RigidBody2D = body.get_child(3)
	#print(center.linear_velocity)
	if abs(center.linear_velocity.x) > MAX_SPEED:
		body.apply_force(Vector2(-center.linear_velocity.x,0))

func is_on_floor() -> bool:
	if raycasts[0].is_colliding() and raycasts[1].is_colliding():
		return true
	else:
		return false
