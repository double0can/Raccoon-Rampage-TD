extends Node

signal livesChanged(currentLives)
signal gameOver
signal waveChanged(currentWave)
signal moneyChanged(currentMoney)
signal gameWon

var lives = 5
var currentWave = 1
var money = 100

func _ready() -> void:
	# Emit the initial value so UI can update
	livesChanged.emit(lives)
	waveChanged.emit(currentWave)
	moneyChanged.emit(money)
	gameWon.connect(victoryScreen)

func livesLost(amount: int) -> void:
	lives -= amount
	livesChanged.emit(lives)
	print("Lives remaining: ", lives)
	
	if lives <= 0:
		gameOver.emit()
		print("Game over!")

func addMoney(amount: int) -> void:
	money += amount
	moneyChanged.emit(money)
	print("money added, Total: $", money)

func spendMoney(amount: int) -> bool:
	if money >= amount:
		money -= amount
		moneyChanged.emit(money)
		return true
		
	else:
		print("Not enough money")
		return false

func victoryScreen():
	var victory = preload("res://Scenes/Victory Scene/Victory.tscn").instantiate()
	add_child(victory)
	get_tree().paused = true 
