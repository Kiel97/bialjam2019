extends CanvasLayer

const YOUR_SCORE_MESSAGE : String = "Your score: %d"
const IN_TOP_MESSAGE : String = "Congratulations! Your score is number %d!"
const OUT_TOP_MESSAGE : String = "Sorry! Your score is below top scores."

onready var comment_label : Label = $PanelContainer/MarginContainer/VBoxContainer/Comment
onready var score_label : Label = $PanelContainer/MarginContainer/VBoxContainer/Score
onready var save_score_button : Button = $PanelContainer/MarginContainer/VBoxContainer/InsertNameContainer/VBoxContainer/SaveScoreButton


func _ready() -> void:
	update_summary()

func _on_Button_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	go_to_main_menu()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		go_to_main_menu()

func update_summary() -> void:
	score_label.text = YOUR_SCORE_MESSAGE % [HighscoreManager.new_score]
	
	var achieved_rank = HighscoreManager.insert_new_highscore()
	if achieved_rank < HighscoreManager.SCORES_IN_TOP:
		comment_label.text = IN_TOP_MESSAGE % [achieved_rank + 1]
	else:
		comment_label.text = OUT_TOP_MESSAGE

func go_to_main_menu() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")

func _on_TextEdit_text_changed(new_text: String) -> void:
	save_score_button.disabled = true if len(new_text) == 0 else false

func _on_SaveScoreButton_pressed() -> void:
	print("Save score")
