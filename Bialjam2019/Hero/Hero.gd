extends KinematicBody2D

signal key_collected(value)

const MOVE_SPEED = 125
const JUMP_SPEED = -300
const GRAVITY = 1000

var velocity : Vector2 = Vector2()

var keys_collected : int = 0

func _ready() -> void:
	refresh_key_counter()

func _process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func get_input() -> void:
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_just_pressed("jump")
	
	velocity.x = 0
	if right:
		velocity.x += MOVE_SPEED
		$Sprite.flip_h = false
	if left:
		velocity.x -= MOVE_SPEED
		$Sprite.flip_h = true
	if jump and is_on_floor():
		velocity.y = JUMP_SPEED

func collect_key() -> void:
	keys_collected += 1
	refresh_key_counter()

func refresh_key_counter() -> void:
	emit_signal("key_collected", keys_collected)