extends Node2D

const VELOCITY: float = -1.2
var g_texture_width: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in get_children():
		if child is not Sprite2D:
			continue
		_move_sprite(child, delta)

func _move_sprite(sprite: Sprite2D, delta: float) -> void:
	var texture_width = sprite.texture.get_size().x * sprite.scale.x
	sprite.position.x += VELOCITY

	if sprite.position.x <= $End.position.x:
		sprite.position.x = $Start.position.x
