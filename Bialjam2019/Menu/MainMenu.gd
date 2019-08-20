extends CanvasLayer

var err : int

func _on_StartButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	err = get_tree().change_scene("res://Menu/SelectLevel.tscn")
	if err != OK:
		ErrorReporter.raise_error(err)

func _on_QuitButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().quit()

func _on_CreditsButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	err = get_tree().change_scene("res://Menu/CreditsScreen.tscn")
	if err != OK:
		ErrorReporter.raise_error(err)

func _on_TimesButton_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	err = get_tree().change_scene("res://Menu/HighscoresScreen.tscn")
	if err != OK:
		ErrorReporter.raise_error(err)