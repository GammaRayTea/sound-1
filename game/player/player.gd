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


@onready var sound_falling = $Followers/Falling
@onready var sound_impact = $Followers/Impact
 
var impactCountDown:int = 0
var previousStrength:float = 0

var lastFrameVelocity: Vector2 = Vector2(0,0)
#var rigidBodies:Array[RigidBody2D]

func _physics_process(delta: float) -> void:
	super(delta)
	input()
	clamp_speed()
	move_camera_target()
	handle_falling_sound()
	determine_strong_impact()
	
	if invincibilityTime > 0:
		invincibilityTime-=1
	elif invincibilityTime == 0:
		hurtbox.set_deferred("disabled", false)
		invincibilityTime-=1
	

func handle_falling_sound() -> void:
	var fallingSpeed = body.get_center_body().rigidbody.linear_velocity.y
	if fallingSpeed > 1000:
		#if !sound_falling.started:
			#sound_falling.play()
		sound_falling["fmod_parameters/falling_frequency"] = (1.0/MAX_SPEED_Y)*fallingSpeed

	else:
		sound_falling["fmod_parameters/falling_frequency"] = 0

func determine_strong_impact() -> void:
	var currentVelocity:Vector2 = body.get_center_body().rigidbody.linear_velocity
	var impactStrength = abs(lastFrameVelocity.length() - currentVelocity.length())

	if impactStrength > 400 and impactStrength > previousStrength:
		play_impact(impactStrength)
		previousStrength = impactStrength
		impactCountDown = 5
	
	if impactCountDown >0:
		impactCountDown-=1
	elif impactCountDown == 0:
		previousStrength = 0
	
	lastFrameVelocity = currentVelocity

func play_impact(strength:float) -> void:
	if strength < 500:
		sound_impact["fmod_parameters/impact_value"] = 0
	elif strength < 600:
		sound_impact["fmod_parameters/impact_value"] = 1
	elif strength < 700:
		sound_impact["fmod_parameters/impact_value"] = 2
	elif strength < 800:
		sound_impact["fmod_parameters/impact_value"] = 3
	elif strength < 900:
		sound_impact["fmod_parameters/impact_value"] = 4
	elif strength < 1100:
		sound_impact["fmod_parameters/impact_value"] = 5
	else:
		sound_impact["fmod_parameters/impact_value"] = 6
	print(strength)
	sound_impact.play(false)
	
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
