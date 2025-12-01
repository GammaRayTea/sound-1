
extends Area2D



func _on_area_entered(_area: Area2D) -> void:
	var game:Game = get_tree().get_first_node_in_group("Game")
	game.screenTransition.startTransition(1)
	await game.screenTransition.transition_point_reached
	game.player.die()
	game.screenTransition.endTransition(3)
