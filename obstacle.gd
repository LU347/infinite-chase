extends RigidBody2D

@export var VELOCITY: float = -300

#TODO:
# fix velocity since it's not
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    linear_velocity = Vector2(VELOCITY, 0)  # Set the velocity in the x-axis

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    linear_velocity = Vector2(VELOCITY,0)

