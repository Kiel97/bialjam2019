extends CanvasLayer

#class SortScores:
#	static func sort(a, b):
#		if a[1] > b[1]:
#			return true
#		return false

onready var score_label = $PanelContainer/MarginContainer/VBoxContainer/Score

func _ready() -> void:
	var score : PoolStringArray = open_last_score_from_file()
	var highs : String = get_high_scores_from_file()
	highs += "\n" + score.join(" ")
	#update_highscore_file(score, highs)
	save_new_high_scores(highs)

func open_last_score_from_file() -> PoolStringArray:
	var f : File = File.new()
	
	f.open("user://current_score.txt", File.READ)
	var content : PoolStringArray = f.get_as_text().split(" ")
	score_label.text = "Your score: " + content[1]
	f.close()
	
	return content

func get_high_scores_from_file() -> String:
	var f : File = File.new()
	if f.file_exists("user://besttimes.txt"):
		f.open("user://besttimes.txt", File.READ)
		var content : String = f.get_as_text()
		f.close()
		return content
	return ""

#func update_highscore_file(current : PoolStringArray, best : String) -> void:
#	print(str(current[0], " ", current[1]))
#	var s1 = best.split("\n")
#	var s2 = []
#	for score in s1:
#		s2.append(score.split(" "))
#	print(s1)
#	print(s2)
#	s2.append(current)
#	s2.sort_custom(SortScores, "sort")
#	print(s2)
#	

func save_new_high_scores(content : String) -> void:
	var f = File.new()
	f.open("user://besttimes.txt", File.WRITE)
	f.store_string(content)
	f.close()

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")