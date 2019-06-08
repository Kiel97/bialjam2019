extends CanvasLayer

onready var keys_counter : Label = $PanelContainer/VBoxContainer/CenterContainer/HBoxContainer/KeysCollected/KeyCounter
onready var prisoners_counter : Label = $PanelContainer/VBoxContainer/CenterContainer/HBoxContainer/PrisonersCounter/PrisonersLeft

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_Hero_key_collected(value) -> void:
	keys_counter.text = "x " + str(value).pad_zeros(2)

func _on_Hero_prisoners_count(value) -> void:
	prisoners_counter.text = "x " + str(value).pad_zeros(2)
