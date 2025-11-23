@tool 
class_name ColorBlock extends StaticBody2D

var shape:PackedVector2Array = $CollisionPolygon2D.polygon
@onready var sprite = $Sprite2D


func _ready() -> void:
	var texture:GradientTexture2D = sprite.texture
	
