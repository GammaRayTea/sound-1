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
	
	if invincibilityTime > 0:
		invincibilityTime-=1
	elif invincibilityTime == 0:
		hurtbox.set_deferred("disabled", false)
		invincibilityTime-=1
	


var jumpHeldFrameCounter= -1
func input()->void:
	if Input.is_action_just_pressed("left")or Input.is_action_just_pressed("right"):
		body.apply_impulse(Vector2(0,10))
	if Input.is_action_pressed("left"):
		body.apply_force(Vector2(-ACCELERATION,0))

	if Input.is_action_pressed("right"):
		body.apply_force(Vector2(ACCELERATION,0))
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		body.apply_force(Vector2(0,-JUMPFORCE))
		jumpHeldFrameCounter = 5
	if jumpHeldFrameCounter > 0:
		jumpHeldFrameCounter -= 1
	elif jumpHeldFrameCounter == 0 :
		if Input.is_action_pressed("jump"):
			body.apply_force(Vector2(0,-(JUMPFORCE-2000)))
		jumpHeldFrameCounter -= 1


func is_on_floor() -> bool:
	if raycasts[0].is_colliding() and raycasts[1].is_colliding():
		return true
	else:
		return false


func _on_hurt_box_entered(_hitbox: HitBox) -> void:
	take_damage(_hitbox.damage)
	
	

func die() -> void:
	pass

func take_damage(amount:float) -> void:
	currentHealth -= amount
	hurtbox.set_deferred("disabled", true)
	healthbar.value = currentHealth
	invincibilityTime = INVINCIBILITY_ON_HIT
	if currentHealth <= 0:
		die()
