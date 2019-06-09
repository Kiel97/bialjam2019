extends CanvasLayer

var best_times_file = "user://besttimes.txt"

onready var scoreboard_label = $PanelContainer/MarginContainer/VBoxContainer/Scoreboard

func _ready() -> void:
	#print(OS.get_user_data_dir())
	open_besttimes_file()

func _on_Button_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	get_tree().change_scene("res://Menu/MainMenu.tscn")

func open_besttimes_file() -> void:
	var f : File = File.new()
	if not f.file_exists(best_times_file):
		f.open(best_times_file, File.WRITE)
		var content : String = ""
		f.store_string(content)
		f.close()
		
	f.open(best_times_file, File.READ)
	var content : String = f.get_as_text()
	scoreboard_label.text = content
	f.close()