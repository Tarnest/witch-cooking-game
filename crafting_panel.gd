extends Node

@onready var player_inventory = preload("res://Player/player_inventory.tres")
@onready var slots: Array = $VBoxContainer/NinePatchRect/GridContainer.get_children()

func _ready():
	player_inventory.update.connect(update_slots)

func update_slots():
	for i in range(min(player_inventory.slots.size(), slots.size())):
		slots[i].update(player_inventory.slots[i])

