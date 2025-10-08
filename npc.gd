extends Area2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $Sprite2D


const lines: Array[String] = [
	"Sup Stinky",
	"Geez, You Stink!"
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	sprite.flip_h = true if interaction_area.get_overlapping_areas()[0].global_position.x < global_position.x else false
	await DialogManager.dialog_finished
