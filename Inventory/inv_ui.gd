extends Control

@onready var inv: Inv = preload("res://Inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_slots();
	close();
	
func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i]);
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close();
		else:
			open();

func open():
	visible = true;
	is_open = true;

func close():
	visible = false;
	is_open = false;
