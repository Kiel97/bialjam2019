extends CanvasLayer

var best_times_file = "user://besttimes.txt"

onready var scoreboard_label = $PanelContainer/MarginContainer/VBoxContainer/Scoreboard

func _ready() -> void:
	#print(OS.get_user_data_dir())
	open_besttimes_file()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		go_to_main_menu()

func _on_Button_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	go_to_main_menu()

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

func go_to_main_menu() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")