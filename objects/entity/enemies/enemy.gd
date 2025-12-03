
@abstract class_name Enemy extends Entity

enum enemyType {SOFTBODY, STATICBODY}

var priority:Strategy
@export var packedStrategies:Array[PackedScene]
@onready var musicPlayer:MusicPlayer = get_tree().get_first_node_in_group("MusicPlayer")
var strategies:Dictionary

@export var layers:Array[String]

func _ready() -> void:

	super()
	for i in packedStrategies.size():
		var strategy = packedStrategies[i].instantiate()
		strategies[strategy.name] = strategy
		add_child(strategies[strategy.name])
		print(strategy)
		
	

	

func _physics_process(delta: float) -> void:
	super(delta)
	if priority:
		priority.execute()
