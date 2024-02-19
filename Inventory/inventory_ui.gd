extends CanvasLayer

@onready var inventory: Inventory = preload("res://Player/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventory.update.connect(update_slots)
	update_slots()

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
