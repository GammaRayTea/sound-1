
extends CanvasLayer

@export var healthBar:TextureProgressBar 
@export var player:Player
func _ready():
	if player:
		healthBar.value =  player.currentHealth
	
