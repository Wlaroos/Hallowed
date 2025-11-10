extends Node2D

@onready var music:AudioStreamPlayer = $Music
@onready var pause_button:Button = %PauseMusicButton
var music_pos = 0.0

func _ready() -> void:
	_playSFX("Music")

func _playSFX(name: String):
	match name:
		"Move":
			$MoveSfx.play()
		"Hit":
			$HitSfx.play()
		"Talk":
			$TalkSfx.play()
		"Music":
			$Music.play()
	
func _on_pause_music_toggled(toggled_on: bool) -> void:
	if toggled_on and music.playing:
		music_pos = music.get_playback_position()
		music.stop()
		pause_button.text = "Resume Music"
	else:
		music.play(music_pos)
		pause_button.text = "Pause Music"
