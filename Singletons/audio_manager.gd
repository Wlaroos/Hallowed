extends Node

@export var music: AudioStreamPlayer
@export var move_sfx: AudioStreamPlayer
@export var hit_sfx: AudioStreamPlayer
@export var talk_sfx: AudioStreamPlayer
@export var button: Button

var music_pos: float = 0.0
var is_paused: bool = false

func _ready() -> void:
	if button:
		button.pressed.connect(_on_pause_music_pressed)
		
	button.z_index = 5
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	print("AudioManager loaded.")

	# Start background music
	play_sfx("Music")

# -----------------------------------------------------------
# PUBLIC METHODS
# -----------------------------------------------------------

func play_sfx(name: String) -> void:
	match name:
		"Move":
			if move_sfx: move_sfx.play()
		"Hit":
			if hit_sfx: hit_sfx.play()
		"Talk":
			if talk_sfx: talk_sfx.play()
		"Music":
			if music and not music.playing:
				music.play()
		_:
			push_warning("Unknown sound name: %s" % name)

func toggle_music_paused(pause: bool) -> void:
	if not music:
		push_warning("No music player node found in AudioManager.")
		return

	if pause and music.playing:
		music_pos = music.get_playback_position()
		music.stop()
	else:
		music.play(music_pos)

func _on_pause_music_pressed() -> void:
	is_paused = !is_paused
	toggle_music_paused(is_paused)

	if button:
		if(is_paused):
			button.text = "Resume Music"
		else:
			button.text = "Pause Music"
