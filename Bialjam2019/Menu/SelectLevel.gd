extends CanvasLayer

export var levels : Array = [
	"res://Levels/Level.tscn"
]

onready var level_name_label : Label = $PanelContainer/MarginContainer/VBoxContainer/LevelSelector/LevelName
onready var level_miniature : TextureRect = $PanelContainer/MarginContainer/VBoxContainer/LevelMiniature

var current_index : int = 0 setget set_curr_index

var err : int

func _ready() -> void:
	update_selected_level()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		_on_StartGameButton_pressed()
	elif event.is_action_pressed("escape"):
		_on_BackToMenuButton_pressed()
	elif event.is_action_pressed("move_left"):
		_on_LeftButton_pressed()
	elif event.is_action_pressed("move_right"):
		_on_RightButton_pressed()

func _on_LeftButton_pressed() -> void:
	play_select_sound()
	self.current_index -= 1

func _on_RightButton_pressed() -> void:
	play_select_sound()
	self.current_index += 1

func _on_BackToMenuButton_pressed() -> void:
	play_select_sound()
	yield($SelectSound, "finished")  # I don't know why it is required in this particular case
	err = get_tree().change_scene("res://Menu/MainMenu.tscn")
	if err != OK:
		ErrorReporter.raise_error(err)

func _on_StartGameButton_pressed() -> void:
	play_select_sound()
	err = get_tree().change_scene(levels[current_index])
	if err != OK:
		ErrorReporter.raise_error(err)

func update_selected_level() -> void:
	var lvl : PackedScene = load(levels[current_index]).instance()
	
	level_name_label.text = lvl.get_name()
	level_miniature.texture = lvl.get_miniature()

func set_curr_index(value: int) -> void:
	current_index = int(clamp(value, 0, levels.size() - 1))
	update_selected_level()
	print_debug("Curr: ", current_index, " Value: ", value)

func play_select_sound() -> void:
	$SelectSound.play()