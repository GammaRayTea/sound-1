extends Camera2D

var playerVel:Vector2
var targetOffset:Vector2
func _physics_process(_delta: float) -> void:
	
	if playerVel.y >200:
		targetOffset.y =  playerVel.y*0.2
		targetOffset.y = clampf(targetOffset.y,0,400)
	else:
		targetOffset.y =  0
	if abs(playerVel.x)>80:
		targetOffset.x =  sign(playerVel.x)*80
	else:
		targetOffset.x = 0
	
	offset = offset.lerp(targetOffset,0.05)
