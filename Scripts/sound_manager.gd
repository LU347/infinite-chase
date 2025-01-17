extends Node2D

var sound_dict = {}

var current_sound = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sound_dict = {
		"jump": $JumpSound,
		"damage": $DamageSound,
		"title": $TitleMusic,
		"game": $BackgroundMusic,
		"game_end": $GameOverMusic
	}

func play_sound(sound_name):
	sound_dict[sound_name].play()
	current_sound = sound_name

func stop_sound():
	if current_sound:
		sound_dict[current_sound].stop()

