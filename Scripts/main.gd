extends Node2D

signal start_game_objects
signal stop_game_objects

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

# Resets the score to 0, shows the get ready message, and starts platform movement and enemy spawners
func new_game() -> void:
	score = 0

	$Capy.hide()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")

	await $HUD.print_countdown()

	start_game_objects.emit() #This should start the platform and spawners

	$Capy.start($SpawnLocation.position)
	$ScoreTimer.start()
	$SoundManager.play_sound("game")

#TODO:
# Save high score
func game_over() -> void:
	stop_game_objects.emit() #This should stop the platform and spawners

	$ScoreTimer.stop()
	$Capy.hide()
	$HUD.show_game_over()

	$SoundManager.stop_sound()
	$SoundManager.play_sound("game_end")

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
