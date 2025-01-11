extends RigidBody2D

@export var VELOCITY: float = -200

func _ready() -> void:
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    linear_velocity = Vector2(VELOCITY,0)

