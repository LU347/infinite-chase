extends CanvasLayer

#Notifies the main scene when the button is pressed
signal start_game

@export var ScoreLabel: Label
@export var HeartsContainer: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.hide()

func print_countdown():
	var start_message = ["3", "2", "1", "Go!"]
	for message in start_message:
		await get_tree().create_timer(1.0).timeout
		show_message(message)
		
func show_menu():
	$Menu.show()
	$MessageLabel.hide()

# Game Status Messages
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _on_message_timer_timeout() -> void:
	$MessageLabel.hide()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$MessageLabel.show()

	#Creates a one-shot timer and waits for it to finish
	await get_tree().create_timer(1.0).timeout
	$Menu.show()

# Menu Buttons
func _on_quit_button_pressed() -> void:
	get_tree().quit()

# TODO:
# This should be connected to the Main function instead
func _on_restart_button_pressed() -> void:
	$Menu.hide()
	start_game.emit() 

# Player Status UI (Score & Health)
func update_score(score):
	if score < 10:
		ScoreLabel.text = "0000" + str(score)
	elif score < 100:
		ScoreLabel.text = "000" + str(score)
	elif score < 1000:
		ScoreLabel.text = "00" + str(score)
	else:
		ScoreLabel.text = str(score)

# Updates the heart texture to display the player's current number of lives
func _on_capy_num_lives_changed(num_lives:Variant) -> void:
	var curr_lives = num_lives
	for heart in HeartsContainer.get_children():
		if curr_lives > 0:
			heart.texture = load("res://Assets/HUD/HeartFull_1.png")
		else:
			heart.texture = load("res://Assets/HUD/HeartEmptyGlass.png")
		curr_lives -= 1
