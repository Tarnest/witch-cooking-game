extends Node

@onready var player_inventory = preload("res://Player/player_inventory.tres")
@onready var slots: Array = $TextureRect/GridContainer.get_children()
@onready var items_to_craft: Array = $TextureRect/ToCraft.get_children()
var items_in_pot: Array

func _ready():
	player_inventory.update.connect(update_slots)

func update_slots():
	for i in range(min(player_inventory.slots.size(), slots.size())):
		slots[i].update(player_inventory.slots[i])

func _on_cauldron_add_item_to_pot(pot: Dictionary):
	items_in_pot = dict_to_arr(pot)
	
	for i in range(min(items_in_pot.size(), items_to_craft.size())):
		items_to_craft[i].update(items_in_pot[i])

func _on_confirm_pressed():
	for i in range(items_in_pot.size()):
		items_in_pot[i] = null
	for i in range(min(items_in_pot.size(), items_to_craft.size())):
		items_to_craft[i].update(items_in_pot[i])

func dict_to_arr(dict: Dictionary) -> Array:
	var arr: Array = []
	for item in dict:
		for i in range(dict[item]):
			arr.append(item)
	return arr
