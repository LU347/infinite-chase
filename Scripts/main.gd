extends Node2D

signal start_game_objects
signal stop_game_objects

var player_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func _process(_delta: float):
	if Input.is_action_pressed("pause"):
		pause_game()
		$HUD.show_menu()

# Resets the score to 0, shows the get ready message, and starts platform movement and enemy spawners
func start_game() -> void:
	player_score = 0

	$Capy.hide()
	$HUD.update_score(player_score)
	$HUD.show_message("Get Ready!")

	await $HUD.print_countdown()

	start_game_objects.emit() #This should start the platform and spawners

	$Capy.start($SpawnLocation.position)
	$ScoreTimer.start()
	$SoundManager.play_sound("game")

# Increments the player score every second
func _on_score_timer_timeout() -> void:
	player_score += 1
	$HUD.update_score(player_score)

func pause_game() -> void:
	get_tree().paused = true

func resume_game() -> void:
	get_tree().paused = false
#TODO:
# Save high score
func game_over() -> void:
	stop_game_objects.emit() #This should stop the platform and spawners

	$ScoreTimer.stop()
	$Capy.hide()
	$HUD.show_game_over()

	$SoundManager.stop_sound()
	$SoundManager.play_sound("game_end")
