extends CanvasLayer

func go_to_main_menu() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")

func _on_Button_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	go_to_main_menu()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		go_to_main_menu()