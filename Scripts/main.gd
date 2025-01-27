extends Node2D

signal start_game_objects
signal stop_game_objects

var Enums
var PlayerData

var high_score: int = 0
var player_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Enums = get_node("/root/GameState")
	PlayerData = get_node("/root/PlayerData")

	high_score = PlayerData.get_high_score() or 0
	player_score = PlayerData.get_player_score() or 0

	start_game()

func _process(_delta: float):
	if Input.is_action_pressed("pause"):
		pause_game()
		$HUD.show_menu()

func game_state_manager() -> void:
	match Enums.current_state:
		Enums.GameStates.MAIN_MENU:
			pass
		Enums.GameStates.ACTIVE:
			pass
		Enums.GameStates.PAUSED:
			pass
		Enums.GameStates.RESTARTING:
			pass
		Enums.GameStates.OVER:
			pass

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

func game_over() -> void:	
	PlayerData.set_score(player_score)
	print(PlayerData.get_player_score())
	print(PlayerData.get_high_score())

	stop_game_objects.emit() #This should stop the platform and spawners

	$ScoreTimer.stop()
	$Capy.hide()

	$SoundManager.stop_sound()
	$SoundManager.play_sound("game_end")
	$HUD.show_game_over()
