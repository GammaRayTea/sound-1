class_name Checkpoint extends Area2D
var level:Level
func _ready() -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	level.playerSpawn = $PlayerSpawn
	$CollisionShape2D.set_deferred("disabled", true)
