extends CanvasLayer

signal saved_name

const YOUR_SCORE_MESSAGE : String = "Your score: %d"
const IN_TOP_MESSAGE : String = "Congratulations! Your score is number %d!"
const OUT_TOP_MESSAGE : String = "Sorry! Your score is below top scores."

onready var comment_label : Label = $PanelContainer/MarginContainer/VBoxContainer/Comment
onready var score_label : Label = $PanelContainer/MarginContainer/VBoxContainer/Score
onready var save_score_button : Button = $PanelContainer/MarginContainer/VBoxContainer/InsertNameContainer/VBoxContainer/SaveScoreButton
onready var insert_name_cont : VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/InsertNameContainer/VBoxContainer
onready var main_menu_button : Button = $PanelContainer/MarginContainer/VBoxContainer/Button
onready var textedit : TextEdit = $PanelContainer/MarginContainer/VBoxContainer/InsertNameContainer/VBoxContainer/TextEdit
onready var click_sound : AudioStreamPlayer = $PanelContainer/MarginContainer/VBoxContainer/InsertNameContainer/VBoxContainer/SaveScoreButton/ClickSound

func _ready() -> void:
	textedit.grab_focus()
	update_summary()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		if not save_score_button.disabled and insert_name_cont.visible:
			_on_SaveScoreButton_pressed()

func _on_Button_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	go_to_main_menu()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		go_to_main_menu()

func update_summary() -> void:
	var score = HighscoreManager.new_score
	
	score_label.text = YOUR_SCORE_MESSAGE % [score]
	var achieved_rank = HighscoreManager.get_new_highscore_rank()
	
	if achieved_rank < HighscoreManager.SCORES_IN_TOP:
		comment_label.text = IN_TOP_MESSAGE % [achieved_rank + 1]
		
		_toggle_player_name_popup(true)
		
		yield(self, "saved_name")
		
		HighscoreManager.insert_new_highscore(score, achieved_rank, textedit.text)
		
	else:
		_toggle_player_name_popup(false)
		
		comment_label.text = OUT_TOP_MESSAGE

func go_to_main_menu() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")

func _on_TextEdit_text_changed(new_text: String) -> void:
	save_score_button.disabled = true if len(new_text) == 0 else false

func _on_SaveScoreButton_pressed() -> void:
	click_sound.play()
	
	emit_signal("saved_name")
	yield(click_sound, "finished")
	
	_toggle_player_name_popup(false)

func _toggle_player_name_popup(new_state : bool) -> void:
	insert_name_cont.visible = new_state
	main_menu_button.disabled = new_state