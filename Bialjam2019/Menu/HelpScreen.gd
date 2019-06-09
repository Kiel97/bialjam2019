extends CanvasLayer

func _on_Button_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().change_scene("res://Menu/MainMenu.tscn")
