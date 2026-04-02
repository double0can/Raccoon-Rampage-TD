extends CanvasLayer

@onready var restartButton: Button = $Control/VBoxContainer/RestartButton
@onready var menuButton: Button = $Control/VBoxContainer/MainMenuButton
@onready var quitButton: Button = $Control/VBoxContainer/QuitButton

func _ready() -> void:
	restartButton.pressed.connect(_on_restart_pressed)
	menuButton.pressed.connect(_on_menu_pressed)
	quitButton.pressed.connect(_on_quit_pressed)

func _on_game_won() -> void:
	visible = true
	# pauses the game on loss
	get_tree().paused = true

func _on_restart_pressed() -> void:
	visible = false
	# Reset lives in GameManager
	GameManager.lives = 5 
	
	#Unpauses the game
	get_tree().paused = false
	
	#Reloades the current level
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
