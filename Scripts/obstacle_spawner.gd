extends Node2D

@export var obstacle_scene: PackedScene

func _ready() -> void:
	# Start the spawn timer
	$SpawnTimer.start()

#TODO:
# Make obstacle move with platform

func _on_spawn_timer_timeout() -> void:
	# Instantiate the obstacle
	var obstacle = obstacle_scene.instantiate()
	var obstacle_spawn_location = Vector2(0, 0)
	
	# Set obstacle position
	obstacle.position = obstacle_spawn_location
	
	# Add obstacle to the scene tree
	add_child(obstacle)
