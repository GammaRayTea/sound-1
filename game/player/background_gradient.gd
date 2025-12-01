class_name BackgroundGradient extends CanvasLayer

@export var background:TextureRect
@export var default:GradientTexture2D

func _ready() -> void:
	background.texture = default
func fade_between(target:GradientTexture2D):
	pass



func set_background(gradient:GradientTexture2D):
	background.texture = gradient
