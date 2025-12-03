class_name BreakableBlock extends Node2D

@export var animPlayer:AnimationPlayer
@export var delay:float
signal broken
func reset():
	delay-= delay*0.9
	animPlayer.stop()
	$Trigger.set_deferred("monitoring", true)
	$Rumble["fmod_parameters/rumble_advance"] = "loop"
	$Block.process_mode = Node.PROCESS_MODE_INHERIT
	show()
	
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
	$Block.process_mode = Node.PROCESS_MODE_DISABLED

	broken.emit()
	


func _on_trigger_area_entered(_area: Area2D) -> void:
	destroy()
	$Trigger.set_deferred("monitoring", false)
	print("destroyed")
