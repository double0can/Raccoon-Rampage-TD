extends Area2D

@export var speed: float = 400.0
@export var damage: int = 1

func _physics_process(delta: float) -> void:
	# transform.x points where bullet is facing making it fly straight
	global_position += transform.x * speed * delta

func _on_area_entered(area: Node2D) -> void:
	dealDamage(area)

func dealDamage(target: Node2D) -> void:
	if target.is_in_group("enemy"):
		print("bullet hit")
		
		var enemyRoot = target.get_parent()
		if enemyRoot.has_method("takeDamage"):
			print("health script attached on parent")
			enemyRoot.takeDamage(damage)
			
		else:
			print("bullet hit but couldnt find takeDamage")
			
		queue_free()
