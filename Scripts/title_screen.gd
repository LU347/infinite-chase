extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SoundManager.play_sound("title")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
