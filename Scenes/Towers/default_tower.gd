extends Node2D

@export var bulletScene: PackedScene

var inRange: Array = []
var currentTarget: Node2D = null

@onready var weaponSprite: Sprite2D = $weaponSprite
@onready var firePoint: Marker2D = $weaponSprite/firePoint


func _process(delta: float) -> void:
	update_target()
	
	if currentTarget:
		weaponSprite.look_at(currentTarget.global_position)

func update_target():
	#check if it target is still valid (not dead/despawned)
	if currentTarget != null:
		if not is_instance_valid(currentTarget):
			currentTarget = null
			#cleanarray if the enemy died while in range
			inRange = inRange.filter(func(e): return is_instance_valid(e))
	
	#pick the first enemy in range if none is already targeted
	if currentTarget == null and inRange.size() > 0:
		currentTarget = inRange[0]

#When something enters the range circle
func _on_range_area_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		inRange.append(body)

#When something exits the range circle
func _on_range_area_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		inRange.erase(body)
		
		#if enemy exiting was  target clear target
		if body == currentTarget:
			currentTarget = null


func _on_fire_rate_timeout() -> void:
	if currentTarget != null and is_instance_valid(currentTarget):
		shoot()		

func shoot() -> void:
	if bulletScene:
		var newBullet = bulletScene.instantiate()
		
		get_tree().current_scene.add_child(newBullet)
		newBullet.global_position = firePoint.global_position
		newBullet.global_rotation = weaponSprite.global_rotation
