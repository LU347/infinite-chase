extends Node2D

# Handles player data, such as their score, high-score, username, and user authentication.
var score = 0
var high_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Triggered when the game ends
func update_score(new_score):
	score = new_score
	if score > high_score:
		high_score = score