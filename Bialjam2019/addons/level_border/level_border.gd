tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("LevelBorder", "Node2D", preload("res://addons/level_border/borders.gd"), preload("res://addons/level_border/level_border_icon.svg"))

func _exit_tree():
	remove_custom_type("LevelBorder")
