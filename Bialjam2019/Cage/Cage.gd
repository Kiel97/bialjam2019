extends Area2D

enum cage_states {PRISONER, OPENED, CLOSED}

export (cage_states) var state = cage_states.OPENED setget set_cage_state

var sprite_state = {cage_states.CLOSED: Vector2(0,0),
					cage_states.OPENED: Vector2(48, 0),
					cage_states.PRISONER: Vector2(0, 48)}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func set_cage_state(new_state) -> void:
	state = new_state
	var coords = sprite_state[state]
	$Sprite.region_rect = Rect2(coords.x, coords.y, 48, 48)