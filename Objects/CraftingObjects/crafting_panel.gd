extends Node

@onready var player_inventory = preload("res://Player/player_inventory.tres")
@onready var slots: Array = $VBoxContainer/NinePatchRect/GridContainer.get_children()
@onready var items_to_craft: Array = $VBoxContainer/ToCraft/GridContainer.get_children()
var items_in_pot: Array[InventoryItem]

func _ready():
	player_inventory.update.connect(update_slots)

func update_slots():
	for i in range(min(player_inventory.slots.size(), slots.size())):
		slots[i].update(player_inventory.slots[i])

func _on_cauldron_add_item_to_pot(pot):
	items_in_pot = pot
	for i in range(min(pot.size(), items_to_craft.size())):
		items_to_craft[i].update(pot[i])

func _on_confirm_pressed():
	for i in range(items_in_pot.size()):
		items_in_pot[i] = null
	for i in range(min(items_in_pot.size(), items_to_craft.size())):
		items_to_craft[i].update(items_in_pot[i])
	items_in_pot.clear()
