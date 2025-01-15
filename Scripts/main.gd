extends Node2D

signal start_game_objects

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

#TODO: stop obstacle spawner
func game_over() -> void:
	$HUD.show_game_over()
	$ScoreTimer.stop()

# Resets the score to 0, shows the get ready message, and starts platform movement and enemy spawners
func new_game():
	score = 0

	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	$Capy.hide()

	await $HUD.print_countdown()

	start_game_objects.emit() #This should start the platform and spawners
	$Capy.start($SpawnLocation.position)
	$ScoreTimer.start()
	$SoundManager.play_sound("game")

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
