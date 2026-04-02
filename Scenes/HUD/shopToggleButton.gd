extends Button

@onready var shopMenu: PanelContainer = $"../shopMenu"

func _on_pressed() -> void:
	print("clicked")
	shopMenu.visible = !shopMenu.visible
