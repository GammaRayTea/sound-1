extends Node2D

@export var animPlayer:AnimationPlayer
@export var delay:float
signal broken

func destroy():
	animPlayer.play("rumble")
	$Rumble.play()
	
	var timer = Timer.new()
	add_child(timer)
	timer.start(delay)
	await timer.timeout
	
	print("done")
	
	$Rumble["fmod_parameters/rumble_advance"] = "next"
	hide()

	broken.emit()
	


func _on_trigger_area_entered(_area: Area2D, source: Area2D) -> void:
	destroy()
	source.set_deferred("monitoring", false)
	print("destroyed")
