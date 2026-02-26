extends CanvasLayer

@onready var livesUI = $MarginContainer/LivesUI

func _ready() -> void:
	GameManager.livesChanged.connect(_on_lives_changed)
	_on_lives_changed(GameManager.lives)

func _on_lives_changed(current_lives: int) -> void:
	livesUI.text = "Lives: " + str(current_lives)
