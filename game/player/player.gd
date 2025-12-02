class_name Player extends Entity

@export_category("Gameplay Porperties")
@export var ACCELERATION:int = 100
@export var JUMPFORCE:int = 4000
@export var MAX_HEALTH:int = 100
@export var INVINCIBILITY_ON_HIT:int = 3*60
var currentHealth:float = MAX_HEALTH
var invincibilityTime = -1
@export_category("Interaction")
@export var raycasts:Array[RayCast2D]
@export var camera:Camera2D
@onready var hurtbox:CollisionShape2D = $Followers/HurtBox/CollisionShape2D
@onready var healthbar:TextureProgressBar = $HUD/Control/HealthBar 


func _physics_process(delta: float) -> void:
	super(delta)
	input()
	clamp_speed()
	move_camera_target()
	
	
	
	if invincibilityTime > 0:
		invincibilityTime-=1
	elif invincibilityTime == 0:
		hurtbox.set_deferred("disabled", false)
		invincibilityTime-=1
	


func move_camera_target():
	var velocityVec:Vector2 =body.get_center_body().rigidbody.linear_velocity
	camera.playerVel = velocityVec
var jumpHeldFrameCounter= -1
func input()->void:
	if Input.is_action_just_pressed("left")or Input.is_action_just_pressed("right"):
		body.apply_impulse(Vector2(0,10))
		
		
	if Input.is_action_pressed("left"):
		body.apply_force(Vector2(-ACCELERATION,0))
		camera.targetOffset.x = -100
	
	if Input.is_action_pressed("right"):
		body.apply_force(Vector2(ACCELERATION,0))
		camera.targetOffset.x = 100
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		body.apply_force(Vector2(0,-JUMPFORCE))
		jumpHeldFrameCounter = 7
	
	elif jumpHeldFrameCounter >= 0 :
		if Input.is_action_pressed("jump"):
			body.apply_force(Vector2(0,-(JUMPFORCE)))
		jumpHeldFrameCounter -= 1


func is_on_floor() -> bool:
	if raycasts[0].is_colliding() and raycasts[1].is_colliding():
		return true
	else:
		return false


func _on_hurt_box_entered(_hitbox: HitBox) -> void:
	take_damage(_hitbox.damage)
	print(_hitbox.damage)
	



func reset_values() ->void:
	currentHealth = MAX_HEALTH
	healthbar.value = currentHealth
	hurtbox.set_deferred("disabled", false)
	invincibilityTime-=1
	stop_velocity()
	

	
func take_damage(_amount:float) -> void:
	currentHealth -= _amount
	hurtbox.set_deferred("disabled", true)
	healthbar.value = currentHealth
	invincibilityTime = INVINCIBILITY_ON_HIT
	if currentHealth <= 0:
		var game:Game = get_tree().get_first_node_in_group("Game")
		game.respawn()
