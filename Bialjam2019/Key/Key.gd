extends Area2D

func _ready() -> void:
	randomize()
	choose_sprite()

func choose_sprite() -> void:
	var sprite_index : int = randi() % 3
	$Sprite.region_rect = Rect2(32 * sprite_index, 0, 32, 32)

func _on_Key_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"):
		body.collect_key()
		queue_free()