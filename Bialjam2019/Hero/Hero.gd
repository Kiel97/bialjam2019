extends KinematicBody2D

signal key_collected(value)
signal prisoners_count(value)
signal time_changed(value)

signal died
signal won

const MOVE_SPEED = 125
const JUMP_SPEED = -353
const DIE_JUMP_HEIGHT = -300
const GRAVITY = 1000
const TICKS_PER_SECOND = 21

var hero_frames = {hero_states.IDLE: 0,
					hero_states.JUMP: 32,
					hero_states.FALL: 64,
					hero_states.DEAD: 96}

enum hero_states {IDLE, JUMP, FALL, DEAD, WIN}

onready var timer : Timer = $Timer

var velocity : Vector2 = Vector2()
var state : int = hero_states.IDLE setget change_state

var prisoners_left : int = 0 setget set_prisoners_left
var keys_collected : int = 0 setget set_keys_collected
var time_left : int = 9999 setget set_time_left

func _ready() -> void:
	timer.set_wait_time(pow(TICKS_PER_SECOND, -1))
	timer.start()

func _process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	if self.state != hero_states.DEAD:
		if time_left == 0:
			die()
		elif self.state != hero_states.WIN:
			get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _physics_process(delta: float) -> void:
	
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.is_in_group("gate"):
			if keys_collected > 0:
				use_key()
				collision.collider.queue_free()

func get_input() -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene("res://Menu/MainMenu.tscn")
	if Input.is_action_just_pressed("retry"):
		die()
	
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
		
	if jump and not(self.state in [hero_states.JUMP, hero_states.FALL]):
		self.state = hero_states.JUMP
		velocity.y = JUMP_SPEED
		$SFX/JumpSound.play()
	
	elif self.state in [hero_states.JUMP, hero_states.IDLE] and !is_on_floor() and velocity.y > 0:
		self.state = hero_states.FALL
	elif self.state in [hero_states.JUMP, hero_states.FALL] and is_on_floor():
		self.state = hero_states.IDLE

func set_prisoners_left(value: int) -> void:
	prisoners_left = value
	emit_signal("prisoners_count", self.prisoners_left)
	
	if prisoners_left == 0:
		self.state = hero_states.WIN

func set_keys_collected(value: int) -> void:
	keys_collected = value
	emit_signal("key_collected", self.keys_collected)

func set_time_left(value: int) -> void:
	time_left = value
	emit_signal("time_changed", self.time_left)

func change_state(new_state) -> void:
	state = new_state
	if new_state != hero_states.WIN:
		var coords_x = hero_frames[new_state]
		$Sprite.region_rect = Rect2(coords_x, 0, 32 ,32)
	
	if new_state == hero_states.DEAD:
		$SFX/DieSound.play()
		velocity.y = DIE_JUMP_HEIGHT
		$CollisionShape2D.disabled = true
		$Camera2D.current = false
		yield(get_tree().create_timer(2.5), "timeout")
		emit_signal("died")
	
	elif new_state == hero_states.WIN:
		velocity = Vector2(0,0)
		timer.stop()
		$SFX/WinSound.play()
		yield($SFX/WinSound, "finished")
		emit_signal("won", time_left)

func collect_key() -> void:
	$SFX/KeyCollectSound.play()
	self.keys_collected += 1

func free_prisoner() -> void:
	use_key()
	self.prisoners_left -= 1

func use_key() -> void:
	self.keys_collected -= 1
	$SFX/CageGateOpenSound.play()

func die() -> void:
	timer.stop()
	self.state = hero_states.DEAD

func _on_Level_counter_prisoners(value) -> void:
	self.prisoners_left = value

func _on_Timer_timeout() -> void:
	self.time_left -= 1