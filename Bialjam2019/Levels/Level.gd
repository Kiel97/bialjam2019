extends Node2D

signal counter_prisoners(value)

export var level_name : String = "Default" setget ,get_name
export var miniature : StreamTexture = null setget ,get_miniature

export var bgm : AudioStream = null
export var end_bottom : int = 240
export var end_top : int = 0
export var end_left : int = 0
export var end_right : int = 320

export var time_to_complete : int = 9999

var err : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_bgm()
	set_hero_camera_limits()
	set_time_left()
	get_prisoners_count()
	
func set_time_left() -> void:
	$Hero.time_left = time_to_complete

func set_hero_camera_limits() -> void:
	var cam : Camera2D = $Hero/Camera2D
	cam.limit_left = end_left
	cam.limit_top = end_top
	cam.limit_right = end_right
	cam.limit_bottom = end_bottom

func get_prisoners_count():
	var prisoners = 0
	
	var cages = $Cages.get_children()
	for cage in cages:
		if cage.state == cage.cage_states.PRISONER:
			prisoners += 1
	
	emit_signal("counter_prisoners", prisoners)

func get_name() -> String:
	return level_name

func get_miniature() -> StreamTexture:
	return miniature

func play_bgm() -> void:
	$BackgroundPlayer.stream = bgm
	$BackgroundPlayer.play()

func _on_Hero_died() -> void:
	err = get_tree().reload_current_scene()
	if err != OK:
		ErrorReporter.raise_error(err)

func _on_Hero_won(score : int) -> void:
	HighscoreManager.new_score = score
	HighscoreManager.level_name = level_name
	
	err = get_tree().change_scene("res://Menu/LevelSummary.tscn")
	if err != OK:
		ErrorReporter.raise_error(err)

func _on_Level_tree_entered() -> void:
	$"/root/background_music".stop_playing_menu()

func _on_Level_tree_exiting() -> void:
	$"/root/background_music".start_playing_menu()
