extends Node

const NAME_IDX = 0
const SCORE_IDX = 1
const SCORES_IN_TOP = 10

var highscores_path := "user://highscoresv2.txt"

var new_score : int
var level_name : String setget set_level_name

var err : int

func _ready() -> void:
	pass

func load_highscores_from_file() -> Array:
	var scores = []
	
	var f : File = File.new()
	
	if not f.file_exists(highscores_path):
		err = f.open(highscores_path, File.WRITE)
		if err != OK:
			ErrorReporter.raise_error(err)
		f.close()
	
	err = f.open(highscores_path, File.READ)
	if err != OK:
		ErrorReporter.raise_error(err)
	var content : String = f.get_as_text().strip_edges()
	if content != "":
		for record in content.split("\n"):
			var record_parts = record.split(" -x")
			scores.append([record_parts[0], int(record_parts[1]), record_parts[2]])
			
	f.close()
	
	return scores

func get_new_highscore_rank() -> int:
	var scores : Array = load_highscores_from_file()
	var rank = 0
	
	while rank < SCORES_IN_TOP:
		if len(scores) == rank or new_score > scores[rank][SCORE_IDX]:
			break
		rank += 1
	
	return rank

func insert_new_highscore(score : int, rank : int, player_name : String, level_name : String) -> void:
	var scores : Array = load_highscores_from_file()
	scores.insert(rank, [player_name, score, level_name])
	
	if len(scores) > SCORES_IN_TOP:
		scores.remove(SCORES_IN_TOP)
	
	save_highscores_to_file(scores)

func save_highscores_to_file(scores : Array) -> void:
	var f := File.new()
	err = f.open(highscores_path, File.WRITE)
	if err != OK:
		ErrorReporter.raise_error(err)
	
	for score in scores:
		f.store_line(score[0] + " -x" + str(score[1]) + " -x" + score[2])
	
	f.close()

func set_level_name(value: String) -> void:
	level_name = value
