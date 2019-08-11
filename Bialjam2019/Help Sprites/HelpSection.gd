extends Node2D

func _ready() -> void:
	init_help_section()

func init_help_section() -> void:
	self.visible = OS.get_name() != "Android"