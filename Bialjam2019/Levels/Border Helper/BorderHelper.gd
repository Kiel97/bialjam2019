tool
class_name BorderHelper
extends Node2D

export var limit_bottom : int = 200 setget set_bottom
export var limit_top : int = -200 setget set_top
export var limit_left : int = -300 setget set_left
export var limit_right : int = 500 setget set_right
export var helper_color : Color = Color(0, 0.6, 1, 0.5) setget set_color

func set_bottom(value: int) -> void:
	limit_bottom = value
	update()

func set_top(value: int) -> void:
	limit_top = value
	update()

func set_left(value: int) -> void:
	limit_left = value
	update()

func set_right(value: int) -> void:
	limit_right = value
	update()

func set_color(value: Color) -> void:
	helper_color = value
	update()

func _draw() -> void:
	if Engine.editor_hint:
		draw_rect(_get_rect(), helper_color, false)

func _get_rect() -> Rect2:
	var position : Vector2 = Vector2(limit_left, limit_top)
	var size : Vector2 = Vector2(limit_right-limit_left, limit_bottom-limit_top)
	var rect : Rect2 = Rect2(position, size)
	
	return rect