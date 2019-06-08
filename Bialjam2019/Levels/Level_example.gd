extends Node2D

export var end_bottom : int = 240
export var end_top : int = 0
export var end_left : int = 0
export var end_right : int = 320

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_hero_camera_limits()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func set_hero_camera_limits() -> void:
	var cam : Camera2D = $Hero/Camera2D
	cam.limit_left = end_left
	cam.limit_top = end_top
	cam.limit_right = end_right
	cam.limit_bottom = end_bottom