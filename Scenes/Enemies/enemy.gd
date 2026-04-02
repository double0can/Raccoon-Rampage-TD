extends PathFollow2D

@export var speed = 125
@export var playerDamage = 1
@export var health = 1
@export var value = 2

#built in function to call and object to move 60 times a second
func _physics_process(delta: float) -> void:
	move(delta)

#set the offset for the path
func move(delta: float) -> void:
	progress += speed * delta
	
	#checks if enemy has reached end of path. 0.0 at start, 1.0 at end
	if progress_ratio >= 1.0:
		reachedEnd()
		
func reachedEnd() -> void:
	GameManager.livesLost(playerDamage)
	
	queue_free()

func takeDamage(amount: int) -> void:
	health -= amount
	print("damage dealt")
	
	if health <= 0:
		die()

func die() -> void:
	GameManager.addMoney(value)
	queue_free()
