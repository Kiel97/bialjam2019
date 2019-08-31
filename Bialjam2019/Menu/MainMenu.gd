extends CanvasLayer

const PROJECT_AUTHOR : String = "Kiel97"
const PROJECT_VERSION : String = "1.2-beta2"
const PROJECT_INFO : String = "v. %s by %s"

onready var project_label : Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ProjectLabel

var err : int

func _ready() -> void:
	project_label.text = PROJECT_INFO % [PROJECT_VERSION, PROJECT_AUTHOR]

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