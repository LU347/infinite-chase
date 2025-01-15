extends Node2D

var sound_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sound_dict = {
		"jump": $JumpSound,
		"damage": $DamageSound,
		"title": $TitleMusic,
		"game": $BackgroundMusic
	}

func play_sound(sound_name):
	sound_dict[sound_name].play()
