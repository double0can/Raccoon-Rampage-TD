extends PathFollow2D

@export var speed = 50

#built in function to call and object to move 60 times a second
func _physics_process(delta: float) -> void:
	move(delta)

#set the offset for the path
func move(delta: float) -> void:
	progress += speed * delta
	
	#checks if enemy has reached end of path
	if progress_ratio >= 1.0:
		queue_free()
