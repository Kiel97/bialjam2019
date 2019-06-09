extends Node2D

signal counter_prisoners(value)

export var end_bottom : int = 240
export var end_top : int = 0
export var end_left : int = 0
export var end_right : int = 320

export var time_to_complete : int = 9999

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_hero_camera_limits()
	set_time_left()
	get_prisoners_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("retry"):
		get_tree().reload_current_scene()

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

func _on_Hero_died() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")

func _on_Hero_won() -> void:
	get_tree().change_scene("res://Menu/MainMenu.tscn")
