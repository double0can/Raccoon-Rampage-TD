extends Node

signal livesChanged(currentLives)
signal gameOver
signal waveChanged(currentWave)

var lives = 20
var currentWave = 1

func _ready() -> void:
	# Emit the initial value so UI can update
	livesChanged.emit(lives)
	waveChanged.emit(currentWave)

func livesLost(amount: int) -> void:
	lives -= amount
	livesChanged.emit(lives)
	print("Lives remaining: ", lives)
	
	if lives <= 0:
		gameOver.emit()
		#add game over logic here later
		print("Game Over!")
