extends CanvasLayer

#Notifies the main scene when the button is pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_score(score):
	$ScoreLabel.text = str(score)

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

#Called when the player loses
#TODO: Return to title scene
func show_game_over():
	show_message("Game Over")

	await $MessageTimer.timeout

	$Message.text = "Infinite Chase"
	$Message.show()

	#Creates a one-shot timer and waits for it to finish
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func _on_message_timer_timeout() -> void:
	$Message.hide()
