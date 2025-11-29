@tool
class_name ColorBlock extends StaticBody2D

@onready var collisionShapePoints:PackedVector2Array = $CollisionPolygon2D.polygon.duplicate()
@onready var spriteShapePoints = $Polygon2D.polygon.duplicate()

func _ready() -> void:
	pass
	
func _process(_delta):
	
	if Engine.is_editor_hint():
		
		if collisionShapePoints != $CollisionPolygon2D.polygon:
			collisionShapePoints = $CollisionPolygon2D.polygon
			$Polygon2D.polygon = collisionShapePoints
			spriteShapePoints = $Polygon2D.polygon

			queue_redraw()

		
		elif spriteShapePoints != $Polygon2D.polygon:
			spriteShapePoints = $Polygon2D.polygon
			$CollisionPolygon2D.polygon = spriteShapePoints
			collisionShapePoints = $CollisionPolygon2D.polygon

			queue_redraw()





func get_pvector_extents(p:PackedVector2Array)->Vector4: 
	var minX:float = p[0].x
	var maxX:float = p[0].x 
	var minY:float = p[0].y 
	var maxY:float = p[0].y
	for v in p: 
		if v.x < minX: 
			minX = v.x
		if v.x > maxX: 
			maxX = v.x
		if v.y < minY: 
			minY = v.y
		if v.y > maxY: 
			maxY = v.y
	return Vector4(minX, minY, maxX, maxY)

func get_polygon_size(p:PackedVector2Array)->Vector2: 
	var v:Vector4 = get_pvector_extents(p)
	var r:Rect2 = Rect2(v.x, v.y, abs(v.z - v.x), abs(v.w - v.y))
	return r.size

func _draw():
	
	
	pass
