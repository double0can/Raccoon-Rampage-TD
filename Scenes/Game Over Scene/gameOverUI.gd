extends CanvasLayer

@onready var restartButton = $Control/VBoxContainer/RestartButton
@onready var menuButton = $Control/VBoxContainer/MenuButton
@onready var quitButton = $Control/VBoxContainer/QuitButton

func _ready() -> void:
	# Hide the menu when the game starts
	visible = false
	
	restartButton.pressed.connect(_on_restart_pressed)
	quitButton.pressed.connect(_on_quit_pressed)
	
	# listens for Game Over signal
	GameManager.gameOver.connect(_on_game_over)

func _on_game_over() -> void:
	visible = true
	# pauses the game on loss
	get_tree().paused = true

func _on_restart_pressed() -> void:
	# Reset lives in GameManager
	GameManager.lives = 20 
	
	#Unpauses the game
	get_tree().paused = false
	
	#Reloades the current level
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
