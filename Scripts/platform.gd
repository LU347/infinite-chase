extends Node2D

@export var obstacle_scene: PackedScene

@export var VELOCITY: float = -1.2

var can_move = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_move:
		for child in get_children():
			if child is not Sprite2D:
				continue
			_move_sprite(child, delta)

func _move_sprite(sprite: Sprite2D,_delta: float) -> void:
	#var texture_width = sprite.texture.get_size().x * sprite.scale.x
	var platform = sprite.get_node("PlatformTip")
	sprite.position.x += VELOCITY

	if platform.global_position.x <= $EndPosition.global_position.x:
		sprite.position.x = $SpawnPosition.position.x


func _on_main_start_game_objects() -> void:
	can_move = true
