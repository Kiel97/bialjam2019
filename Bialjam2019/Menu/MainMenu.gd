extends CanvasLayer

func _ready() -> void:
	print(OS.get_name())

func _on_StartButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().change_scene("res://Levels/Level.tscn")

func _on_QuitButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().quit()

func _on_CreditsButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().change_scene("res://Menu/CreditsScreen.tscn")

func _on_TimesButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().change_scene("res://Menu/HighscoresScreen.tscn")
