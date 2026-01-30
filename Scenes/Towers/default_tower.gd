extends Node2D

func _physics_process(_delta):
	turn()
	
func turn():
	var enemyPos = get_global_mouse_position()
	get_node("Default Tower").look_at(enemyPos)
