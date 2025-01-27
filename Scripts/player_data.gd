extends Node

var player_score: int = 0
var high_score: int = 0

func set_score(score: int) -> void:
	player_score = score
	if player_score > high_score:
		high_score = player_score

func get_player_score() -> int:
	return player_score

func get_high_score() -> int:
	return high_score

