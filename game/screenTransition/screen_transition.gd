class_name ScreenTransisiton extends CanvasLayer
@onready var rectangle:ColorRect = $ScreenTransition/ColorRect	
@onready var animPlayer:AnimationPlayer = $ScreenTransition/AnimationPlayer
signal transition_point_reached
#func _init(_parent:Node,_function:Callable) -> void:
	#_parent.connect(transition_point_reached.get_name(),_function)
	#
func _ready() -> void:
	print(get_children())
	
func start(_transitionTime:float = 1) -> void:

	animPlayer.play("fade_out",-1,1/(_transitionTime/2))
	await animPlayer.animation_finished
	transition_point_reached.emit()
	animPlayer.play("fade_in",-1,1/(_transitionTime/2))
	await animPlayer.animation_finished
	queue_free()
