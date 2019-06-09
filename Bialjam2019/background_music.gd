extends AudioStreamPlayer

func _ready() -> void:
	stream = load("res://Music/menu.ogg")
	start_playing_menu()

func stop_playing_menu() -> void:
	stop()

func start_playing_menu() -> void:
	play()