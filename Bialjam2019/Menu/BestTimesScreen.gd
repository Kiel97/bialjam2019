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
		var content : String = "Albert 3000\nBob 2000\nCharlie 1500\nDonald 1000\nEliah 500"
		f.store_string(content)
		f.close()
		
	f.open(best_times_file, File.READ)
	var content : String = f.get_as_text()
	scoreboard_label.text = parse_scoreboard_from_file(content)
	f.close()

func parse_scoreboard_from_file(content : String) -> String:
	var scores = content.split("\n")
	var output = ""
	for index in range(len(scores)):
		var score_info = scores[index].split(" ")
		output += str(index+1, ". ", score_info[0], " - ", score_info[1], "\n")
	return output