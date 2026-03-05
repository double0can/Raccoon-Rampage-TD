extends Node2D

# Load enemy scene
var enemy_scene = preload("res://Scenes/Enemies/enemy.tscn")
@onready var path_node = $Path2D 

func _ready():
	spawning()

func spawning():
	var newEnemy = enemy_scene.instantiate()
	
	#makes the enemy a child node of the path
	path_node.add_child(newEnemy)
