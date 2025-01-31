extends Node2D

@export var obstacle_scene: PackedScene

@export var VELOCITY: float = -1.2

var can_move: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if can_move:
		for child in get_children():
			if child is Sprite2D:
				_move_sprite(child)

func _move_sprite(sprite: Sprite2D) -> void:
	var platform = sprite.get_node("PlatformTip")
	sprite.position.x += VELOCITY

	var platform_local_position = to_local(platform.global_position).x
	var end_position_local = to_local($EndPosition.global_position).x

	if platform_local_position <= end_position_local:
		sprite.position.x = $SpawnPosition.position.x

func _on_main_start_game_objects() -> void:
	can_move = true

func _on_main_stop_game_objects() -> void:
	can_move = false
