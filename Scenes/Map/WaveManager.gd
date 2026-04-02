extends Node

@export var enemyScene: PackedScene
@export var path: Path2D
@onready var spawnTimer: Timer = $Timer

var currentWaveIndex = 1
var maxWaves = 15
var enemiesToSpawn = 0

#trackers to start next wave
var enemiesAlive = 0 
var isSpawningDone = false

func _ready() -> void:
	spawnTimer.timeout.connect(_on_timer_timeout)
	nextWave()

func nextWave() -> void:
	if currentWaveIndex > maxWaves:
		print("victory!")
		GameManager.gameWon.emit()
		return
		
	#Reset tracking for new wave
	isSpawningDone = false
	enemiesAlive = 0
		
	#increments difficulty
	enemiesToSpawn = 20 + (currentWaveIndex * 10)
	var spawnSpeed = max(0.2, 1.5 - (currentWaveIndex * 0.25))
	
	spawnTimer.wait_time = spawnSpeed
	
	GameManager.currentWave = currentWaveIndex
	GameManager.waveChanged.emit(GameManager.currentWave)
	
	print("Starting Wave ", currentWaveIndex)
	spawnTimer.start()

func _on_timer_timeout() -> void:
	if enemiesToSpawn > 0:
		spawnEnemy()
		enemiesToSpawn -= 1
		
	if enemiesToSpawn <= 0:
		spawnTimer.stop()
		isSpawningDone = true

func spawnEnemy() -> void:
	if enemyScene and path:
		var newEnemy = enemyScene.instantiate()
		path.add_child(newEnemy)
		newEnemy.progress_ratio = 0.0

		# tells the WaveManager when this specific enemy dies
		newEnemy.tree_exited.connect(_on_enemy_destroyed)
		enemiesAlive += 1

# runs every time an enemy is no longer in the scene either by dying or reaching end
func _on_enemy_destroyed() -> void:
	enemiesAlive -= 1
	
	if not is_inside_tree(): #fix for mud run restart not working
		return
		
	#If spawning is finished and no enemies remaining
	if isSpawningDone and enemiesAlive <= 0:
		print("Wave cleared")
		currentWaveIndex += 1
		
		#waits 7 seconds before next wave
		await get_tree().create_timer(7.0).timeout
		nextWave()
