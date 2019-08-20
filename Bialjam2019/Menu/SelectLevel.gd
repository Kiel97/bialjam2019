extends CanvasLayer

onready var level_name_label : Label = $PanelContainer/MarginContainer/VBoxContainer/LevelSelector/LevelName
onready var level_miniature : TextureRect = $PanelContainer/MarginContainer/VBoxContainer/LevelMiniature

var err : int

func _ready() -> void:
	level_name_label.text = "Beginning"
	level_miniature.set("expand", true)

func _on_LeftButton_pressed() -> void:
	play_select_sound()
	print("Previous level")

func _on_RightButton_pressed() -> void:
	play_select_sound()
	print("Next level")

func _on_BackToMenuButton_pressed() -> void:
	play_select_sound()
	yield($SelectSound, "finished")  # I don't know why it is required in this particular case
	err = get_tree().change_scene("res://Menu/MainMenu.tscn")
	if err != OK:
		ErrorReporter.raise_error(err)

func _on_StartGameButton_pressed() -> void:
	play_select_sound()
	err = get_tree().change_scene("res://Levels/Level.tscn")
	if err != OK:
		ErrorReporter.raise_error(err)

func play_select_sound() -> void:
	$SelectSound.play()