extends CanvasLayer

@onready var livesUI: Label = $MarginContainer/VBoxContainer/LivesUI
@onready var waveUI: Label = $MarginContainer/VBoxContainer/waveUI


func _ready() -> void:
	GameManager.livesChanged.connect(_on_lives_changed)
	_on_lives_changed(GameManager.lives)
	
	GameManager.waveChanged.connect(_on_wave_changed)
	_on_wave_changed(GameManager.currentWave)

func _on_lives_changed(currentLives: int) -> void:
	livesUI.text = "Lives: " + str(currentLives)

func _on_wave_changed(currentWave: int) -> void:
	waveUI.text = "Wave: " + str(currentWave)
