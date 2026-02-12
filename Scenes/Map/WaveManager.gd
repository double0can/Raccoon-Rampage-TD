extends Node

@export var enemyScene: PackedScene
@export var path: Path2D
@onready var spawn_timer: Timer = $Timer

func _ready() -> void:
	spawn_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	if enemyScene and path:
		var newEnemy = enemyScene.instantiate()
		
	  #adds the enemy as a child of path
		path.add_child(newEnemy)
		
	   #this ensures it starts at the beginning of the path
		newEnemy.progress_ratio = 0.0
