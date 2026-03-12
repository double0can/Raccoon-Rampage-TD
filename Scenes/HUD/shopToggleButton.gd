extends Button

@onready var shopMenu: PanelContainer = $"../shopMenu"

func _on_pressed() -> void:
	shopMenu.visible = !shopMenu.visible
