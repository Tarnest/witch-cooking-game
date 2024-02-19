extends Node2D

signal open_menu

@onready var player_inventory = preload("res://Player/player_inventory.tres")
var object_closed = true
var items_in_pot: Array[InventoryItem]


func open():
	open_menu.emit()
	object_closed = false


func _on_close_pressed():
	object_closed = true


func use_item(item_name):
	var item = player_inventory.get_item(item_name)
	if item != null:
		player_inventory.remove(item)
		add_to_pot(item)


func add_to_pot(item: InventoryItem):
	items_in_pot.append(item)
