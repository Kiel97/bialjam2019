extends PanelContainer

func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Levels/Level.tscn")

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
