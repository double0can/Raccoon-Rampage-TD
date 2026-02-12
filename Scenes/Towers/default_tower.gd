extends Node2D

var inRange: Array = []
var currentTarget: Node2D = null

func _process(delta: float) -> void:
	update_target()
	
	if currentTarget:
		look_at(currentTarget.global_position)

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
func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		inRange.append(body)

#When something exits the range circle
func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		inRange.erase(body)
		
		#if enemy exiting was  target clear target
		if body == currentTarget:
			currentTarget = null
