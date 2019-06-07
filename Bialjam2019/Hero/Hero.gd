extends KinematicBody2D

const MOVE_SPEED = 125
const JUMP_SPEED = -300
const GRAVITY = 1000

var velocity : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
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