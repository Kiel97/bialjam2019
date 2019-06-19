extends CanvasLayer

onready var scoreboard_label : Label = $PanelContainer/MarginContainer/VBoxContainer/Scoreboard

const SCORE_STRING : String = "%d. %s - %d\n"

func _ready() -> void:
	display_highscores()

func display_highscores() -> void:
	var scores : Array = HighscoreManager.load_highscores_from_file()
	var to_display : String
	
	if len(scores) == 0:
		to_display = "This game hasn't been beaten yet. Be first!"
	else:
		var i = 0
		for score in scores:
			i += 1
			to_display += SCORE_STRING % [i, score[0], score[1]]

	scoreboard_label.text = to_display.strip_edges()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		go_to_main_menu()

func _on_Button_pressed() -> void:
	$SelectSound.play()
	yield($SelectSound, "finished")
	go_to_main_menu()

func go_to_main_menu() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")