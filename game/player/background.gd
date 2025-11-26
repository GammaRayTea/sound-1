extends Camera2D


func _process(delta: float) -> void:
	$BackgroundGradient.set_global_position(get_screen_center_position()- $BackgroundGradient.pivot_offset)  
