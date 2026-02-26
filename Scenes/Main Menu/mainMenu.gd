extends Control

@onready var mainContainer = $MainContainer
@onready var levelContainer = $LevelContainer

func _ready() -> void:
	mainContainer.visible = true
	levelContainer.visible = false

func _on_play_button_pressed() -> void:
	mainContainer.visible = false
	levelContainer.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_map_1_button_pressed() -> void:
	#Loads map 1 (Back Roads)
	get_tree().change_scene_to_file("res://Scenes/Map/map_1.tscn")

func _on_back_button_pressed() -> void:
	levelContainer.visible = false
	mainContainer.visible = true
