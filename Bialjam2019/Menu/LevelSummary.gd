extends CanvasLayer

onready var score_label = $PanelContainer/MarginContainer/VBoxContainer/Score

func _ready() -> void:
	open_last_score_from_file()

func open_last_score_from_file() -> void:
	var f : File = File.new()
	if f.file_exists("user://current_score.txt"):
		f.open("user://current_score.txt", File.READ)
		var content : String = f.get_as_text()
		score_label.text = "Your score: " + content.pad_zeros(4)
		f.close()

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")