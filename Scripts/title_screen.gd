extends Control

#Notifies the main scene when the button is pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SoundManager.play_sound("title")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	start_game.emit()
	get_tree().change_scene_to_file("res://main.tscn")
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
