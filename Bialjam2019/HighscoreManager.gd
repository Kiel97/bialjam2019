extends Node

var highscores_path := "user://highscore.txt"

func _ready() -> void:
	print("Hello from HighScore Manager")
	
func open_highscores_file() -> void:
	var f : File = File.new()
	if not f.file_exists(highscores_path):
		f.open(highscores_path, File.WRITE)
		var content : String = ""
		f.store_string(content)
		f.close()
		
	f.open(highscores_path, File.READ)
	var content : String = f.get_as_text()
	print(content)
	f.close()