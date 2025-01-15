extends Node2D

@export var obstacle_scene: PackedScene

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

func _on_main_start_game_objects() -> void:
	$SpawnTimer.start()
