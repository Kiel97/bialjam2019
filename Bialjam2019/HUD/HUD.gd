extends CanvasLayer

onready var keys_counter : Label = $PanelContainer/CenterContainer/HBoxContainer/KeysCollected/KeyCounter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_Hero_key_collected(value) -> void:
	keys_counter.text = "x " + str(value)