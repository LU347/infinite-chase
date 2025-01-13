extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ScoreTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#TODO: stop obstacle spawner
func game_over() -> void:
	$HUD.show_game_over()
	$ScoreTimer.stop()

func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	$Capy.start($SpawnLocation.position)
	#TODO: Start obstacle spawner

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
