extends KinematicBody2D

signal key_collected(value)
signal prisoners_count(value)
signal time_changed(value)

const MOVE_SPEED = 125
const JUMP_SPEED = -350
const GRAVITY = 1000
const TICKS_PER_SECOND = 21

onready var timer : Timer = $Timer

var velocity : Vector2 = Vector2()

var prisoners_left : int = 0 setget set_prisoners_left
var keys_collected : int = 0 setget set_keys_collected
var time_left : int = 9999 setget set_time_left

func _ready() -> void:
	timer.set_wait_time(pow(TICKS_PER_SECOND, -1))
	timer.start()

func _process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	if time_left > 0:
		get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if time_left == 0:
		die()

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

func set_prisoners_left(value: int) -> void:
	prisoners_left = value
	emit_signal("prisoners_count", self.prisoners_left)

func set_keys_collected(value: int) -> void:
	keys_collected = value
	emit_signal("key_collected", self.keys_collected)

func set_time_left(value: int) -> void:
	time_left = value
	emit_signal("time_changed", self.time_left)

func collect_key() -> void:
	self.keys_collected += 1

func free_prisoner() -> void:
	use_key()
	self.prisoners_left -= 1

func use_key() -> void:
	self.keys_collected -= 1

func die() -> void:
	timer.stop()

func _on_Level_counter_prisoners(value) -> void:
	self.prisoners_left = value

func _on_Timer_timeout() -> void:
	self.time_left -= 1