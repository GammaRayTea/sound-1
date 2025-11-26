
@abstract class_name Enemy extends Entity

enum enemyType {SOFTBODY, STATICBODY}

var priority:Strategy
@export var packedStrategies:Array[PackedScene]

var strategies:Dictionary

func _ready() -> void:
	for i in packedStrategies.size():
		var strategy = packedStrategies[i].instantiate()
		strategies[strategy.name] = strategy
		add_child(strategies[strategy.name])
		
	

func _physics_process(delta: float) -> void:
	super(delta)
	priority.execute()
