extends TextureRect

@export var towerScene: PackedScene
@export var towerPrice: int = 75

var is_dragging = false
var ghost_tower: Node2D = null

@onready var invalidTint: ColorRect = $"../../../invalidTint"


func _gui_input(event: InputEvent) -> void:
	# Check if we clicked the Left Mouse Button
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# If we clicked DOWN, try to pick up a tower
			if GameManager.money >= towerPrice:
				start_drag()
			else:
				print("Not enough money!")
		else:
			# If we let GO of the mouse, try to place it
			if is_dragging:
				drop_tower()

func start_drag() -> void:
	is_dragging = true
	
	# Spawn a "Ghost" tower
	ghost_tower = towerScene.instantiate()
	get_tree().current_scene.add_child(ghost_tower)
	
	# Disable its shooting and timer so it doesn't fire while we hold it
	ghost_tower.set_process(false)
	ghost_tower.get_node("FireRate").stop()
	
	# Make it transparent
	ghost_tower.modulate = Color(1, 1, 1, 0.5)

func _process(delta: float) -> void:
	if is_dragging and ghost_tower != null:
		# Make the ghost tower follow the mouse
		ghost_tower.global_position = ghost_tower.get_global_mouse_position()
		
		# Check if it is on the path
		if is_invalid_location():
			invalidTint.visible = true
			ghost_tower.modulate = Color(1, 0, 0, 0.5) # Turn ghost red too
		else:
			invalidTint.visible = false
			ghost_tower.modulate = Color(1, 1, 1, 0.5)

func is_invalid_location() -> bool:
	# Look at the hitbox we created earlier
	var hitbox = ghost_tower.get_node("placementHitbox")
	
	# Check everything the hitbox is currently touching
	for area in hitbox.get_overlapping_areas():
		if area.is_in_group("path"):
			return true # It IS touching the path
			
	return false # It is safe to build

func drop_tower() -> void:
	is_dragging = false
	invalidTint.visible = false
	
	if is_invalid_location():
		# Invalid! Destroy the ghost. (Money isn't spent yet)
		ghost_tower.queue_free()
		print("Cannot build on the path!")
	else:
		# Valid! Spend the money
		if GameManager.spendMoney(towerPrice):
			# Turn it fully opaque and turn its script/timer back on!
			ghost_tower.modulate = Color(1, 1, 1, 1)
			ghost_tower.set_process(true)
			ghost_tower.get_node("FireRate").start()
			
			# Let go of the reference so it stays on the map permanently
			ghost_tower = null 
		else:
			ghost_tower.queue_free()
