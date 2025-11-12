extends StaticBody2D

@export var scene_path: String

func _changeScene():
	if scene_path != "":
		get_tree().change_scene_to_file(scene_path)
