extends Node

const NAME_IDX = 0
const SCORE_IDX = 1

var highscores_path := "user://highscores.txt"

func _ready() -> void:
	pass

func load_highscores_from_file() -> Array:
	var scores = []
	
	var f : File = File.new()
	
	if not f.file_exists(highscores_path):
		f.open(highscores_path, File.WRITE)
		f.close()
	
	f.open(highscores_path, File.READ)
	var content : String = f.get_as_text().strip_edges()
	if content != "":
		for record in content.split("\n"):
			var record_parts = record.split(" ")
			scores.append([record_parts[0], int(record_parts[1])])
			
	f.close()
	
	return scores