extends Area2D

signal game_over
signal num_lives_changed(num_lives: int)

var speed = 400
var screen_size: Vector2
var velocity = Vector2.ZERO
var floor_y = 420
var num_lives = 3

# Constants for jumping mechanics
const PLAYER_GRAVITY = 1500 # Adjust this value as needed for more realistic gravity
const JUMP_STRENGTH = -600.0    # Adjust for stronger or weaker jumps
const MAX_SPEED = 200.0

var is_on_floor = false
var can_move = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	print("Initial Position:", position)

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
	if position.y >= floor_y:
		position.y = floor_y
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
	position = position.clamp(Vector2.ZERO, screen_size)

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
	num_lives -= 1
	num_lives_changed.emit(num_lives)
	
	if num_lives <= 0:	
		print("game_over")
		game_over.emit()  #TODO: Change to game_over signal
		hide()
		$CollisionShape2D.set_deferred("disabled", true)


# Function to start the player at a specific position
func start(pos: Vector2) -> void:
	num_lives = 3
	position = pos  # Ensure this position is above floor_y for jumping
	show()
	$CollisionShape2D.disabled = false

func _on_main_start_game_objects() -> void:
	can_move = true

func _on_main_stop_game_objects() -> void:
	can_move = false
