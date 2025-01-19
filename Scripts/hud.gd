extends CanvasLayer

#Notifies the main scene when the button is pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RestartButton.hide()
	$QuitButton.hide()

func update_score(score):
	$ScoreLabel.text = str(score)

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func hide_HUD():
	$Message.hide()
	$RestartButton.hide()
	$QuitButton.hide()

func print_countdown():
	var start_message = ["3", "2", "1", "Go!"]
	for message in start_message:
		await get_tree().create_timer(1.0).timeout
		show_message(message)

#Called when the player loses
#TODO: Return to title scene
func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$Message.show()

	#Creates a one-shot timer and waits for it to finish
	await get_tree().create_timer(1.0).timeout
	$RestartButton.show()
	$QuitButton.show()

func _on_message_timer_timeout() -> void:
	$Message.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_button_pressed() -> void:
	hide_HUD()
	start_game.emit()
