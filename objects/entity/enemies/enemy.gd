
@abstract class_name Enemy extends Entity

enum enemyType {SOFTBODY, STATICBODY}

var priority:Strategy
@export var packedStrategies:Array[PackedScene]
@onready var musicPlayer:MusicPlayer = get_tree().get_first_node_in_group("MusicPlayer")
var strategies:Dictionary
@export var layers:Array[String]
var visNotif = VisibleOnScreenNotifier2D.new()
func _ready() -> void:
	super()
	for i in packedStrategies.size():
		var strategy = packedStrategies[i].instantiate()
		strategies[strategy.name] = strategy
		add_child(strategies[strategy.name])
		print(strategy)
		
	
	add_child(visNotif)
	visNotif.rect = Rect2(0,0,get_viewport_rect().size.x+100,get_viewport_rect().size.y+100)
	visNotif.position = Vector2(-68,-68)
	visNotif.screen_entered.connect(musicPlayer.enemy_entered)
	visNotif.screen_exited.connect(musicPlayer.enemy_exited)
	

func _physics_process(delta: float) -> void:
	super(delta)
	if priority:
		priority.execute()
