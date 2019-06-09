extends CanvasLayer

func _on_StartButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().change_scene("res://Levels/Level.tscn")

func _on_QuitButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().quit()

func _on_HowButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().change_scene("res://Menu/HelpScreen.tscn")

func _on_TimesButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().change_scene("res://Menu/BestTimesScreen.tscn")
