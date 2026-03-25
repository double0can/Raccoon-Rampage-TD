extends TextureRect

@export var towerScene: PackedScene
@export var towerPrice: int = 75

var is_dragging = false
var ghost_tower: Node2D = null

@onready var invalidTint: ColorRect = $"../../../invalidTint"


func _gui_input(event: InputEvent) -> void:
	#Checks if left mouse pressed
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			#try pick up a tower
			if GameManager.money >= towerPrice:
				start_drag()
			else:
				print("Not enough money!")
		else:
			# try to place tower
			if is_dragging:
				drop_tower()

func start_drag() -> void:
	is_dragging = true
	
	#Spawns "Ghost" tower
	ghost_tower = towerScene.instantiate()
	get_tree().current_scene.add_child(ghost_tower)
	
	#Disable shooting & timer so it doesnt shoot while holding it
	ghost_tower.set_process(false)
	ghost_tower.get_node("FireRate").stop()
	
	#makes transparent
	ghost_tower.modulate = Color(1, 1, 1, 0.5)

func _process(delta: float) -> void:
	if is_dragging and ghost_tower != null:
		#ghost tower followw mouse
		ghost_tower.global_position = ghost_tower.get_global_mouse_position()
		
		#check if on the path
		if is_invalid_location():
			invalidTint.visible = true
			ghost_tower.modulate = Color(1, 0, 0, 0.5) # Turn ghost red too
		else:
			invalidTint.visible = false
			ghost_tower.modulate = Color(1, 1, 1, 0.5)

func is_invalid_location() -> bool:
	#Look for hitbox
	var hitbox = ghost_tower.get_node("placementHitbox")
	
	#check what hitbox is touching
	for area in hitbox.get_overlapping_areas():
		if area.is_in_group("path"):
			return true # if touching path
		
		if area.is_in_group("tower"):
			return true #if touching another tower
			
	return false #if safe to place

func drop_tower() -> void:
	is_dragging = false
	invalidTint.visible = false
	
	if is_invalid_location():
		#Destroy the ghost Money isn't spent
		ghost_tower.queue_free()
		print("Cannot build on the path!")
	else:
		#Spend the money
		if GameManager.spendMoney(towerPrice):
			#turn fully transparaent and turn script & timer back on
			ghost_tower.modulate = Color(1, 1, 1, 1)
			ghost_tower.set_process(true)
			ghost_tower.get_node("FireRate").start()
			
			#let go of the reference so it stays on the map permanently
			ghost_tower = null 
		else:
			ghost_tower.queue_free()
