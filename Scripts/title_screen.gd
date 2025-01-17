extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_resolution = DisplayServer.window_get_size_with_decorations()
	DisplayServer.window_set_size(screen_resolution)
	DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED)
	
	$SoundManager.play_sound("title")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
