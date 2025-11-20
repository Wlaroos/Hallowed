extends Control

@onready var is_paused = false
@onready var music_paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
		
func toggle_pause() -> void:
	change_text()
	is_paused = !is_paused
	get_tree().paused = is_paused
	
	$PanelContainer/VBoxContainer/ResumeButton.grab_focus()

	if is_paused:
		show()
		$AnimationPlayer.play("blur")
	else: 
		$AnimationPlayer.play_backwards("blur")
		await $AnimationPlayer.animation_finished
		hide()

func _on_resume_button_pressed() -> void:
	toggle_pause()


func _on_restart_button_pressed() -> void:
	toggle_pause()
	get_tree().reload_current_scene()


func _on_pause_music_button_pressed() -> void:
	AudioManager._on_pause_music_pressed()
	change_text()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func change_text():
	if(AudioManager.is_paused):
		$PanelContainer/VBoxContainer/PauseMusicButton.text = "Resume Music"
	else:
		$PanelContainer/VBoxContainer/PauseMusicButton.text = "Pause Music"
