extends Area2D

signal game_over
signal num_lives_changed(num_lives: int)

var SCREEN_SIZE: Vector2

# Constants for jumping mechanics
const PLAYER_GRAVITY = 1500 # Adjust this value as needed for more realistic gravity
const JUMP_STRENGTH = -600.0    # Adjust for stronger or weaker jumps
const MAX_SPEED = 200.0
var FLOOR_Y = 420

# Constants for player health
var DEFAULT_LIVES = 3

# Booleans for player states
var is_on_floor = false
var can_move = false
var is_paused = false

# Movement variables
var speed = 400
var velocity = Vector2.ZERO

# Health
var num_lives = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SCREEN_SIZE = get_viewport_rect().size

# Function to start the player at a specific position
func start(pos: Vector2) -> void:
	update_lives(DEFAULT_LIVES)
	position = pos  # Ensure this position is above floor_y for jumping
	show()
	$CollisionShape2D.disabled = false

# Called every physics frame. Use this for movement and physics updates.
func _physics_process(delta: float) -> void:
	if not can_move:
		return
	
	# Apply gravity if not on the floor
	if not is_on_floor:
		velocity.y += PLAYER_GRAVITY * delta
	
	# Handle horizontal movement
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
	else:
		velocity.x = 0

	# Floor collision logic
	if position.y >= FLOOR_Y:
		position.y = FLOOR_Y
		velocity.y = 0
		is_on_floor = true
	
	# Handle jumping
	if Input.is_action_pressed("jump") and is_on_floor:
		$SoundManager.play_sound("jump")
		velocity.y = JUMP_STRENGTH 
		is_on_floor = false
	
	# Update position
	position += velocity * delta
	
	# Keep player within screen bounds
	position = position.clamp(Vector2.ZERO, SCREEN_SIZE)

	# Animation logic
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "walk"
	
	$AnimatedSprite2D.play()

#TODO: Implement health system
# Player collides with an obstacle
func _on_body_entered(_body: Node2D) -> void:
	$SoundManager.play_sound("damage")

	update_lives(num_lives-1)
	
	if num_lives <= 0:	
		game_over.emit()  #TODO: Change to game_over signal
		hide()
		$CollisionShape2D.set_deferred("disabled", true)

func update_lives(new_num):
	num_lives = new_num
	num_lives_changed.emit(num_lives)

func _on_main_start_game_objects() -> void:
	can_move = true

func _on_main_stop_game_objects() -> void:
	can_move = false
