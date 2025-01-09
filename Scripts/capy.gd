extends Area2D

signal hit

var speed = 400
var screen_size: Vector2
var velocity = Vector2.ZERO
var floor_y = 420

# Constants for jumping mechanics
const PLAYER_GRAVITY = 1500 # Adjust this value as needed for more realistic gravity
const JUMP_STRENGTH = -600.0    # Adjust for stronger or weaker jumps
const MAX_SPEED = 200.0

var is_on_floor = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	print("Initial Position:", position)

# Called every physics frame. Use this for movement and physics updates.
func _physics_process(delta: float) -> void:
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
		print(position.y)
		position.y = floor_y
		velocity.y = 0
		is_on_floor = true
	
	# Handle jumping
	if Input.is_action_pressed("jump") and is_on_floor:
		print("Jump!")
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

func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

# Function to start the player at a specific position
func start(pos: Vector2) -> void:
	position = pos  # Ensure this position is above floor_y for jumping
	show()
	$CollisionShape2D.disabled = false
