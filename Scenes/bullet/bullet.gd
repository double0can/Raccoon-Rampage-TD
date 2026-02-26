extends Area2D

@export var speed: float = 400.0
@export var damage: int = 1

func _physics_process(delta: float) -> void:
	# transform.x points where bullet is facing making it fly straight
	global_position += transform.x * speed * delta

func _on_area_entered(area: Node2D) -> void:
	# Check if the thing we hit is an enemy
	if area.is_in_group("enemy"):
		if area.has_method("takeDamage"):
			area.takeDamage(damage)
		
		# Destroy the bullet
		queue_free()
