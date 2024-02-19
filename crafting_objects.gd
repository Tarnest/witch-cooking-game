extends Node2D

signal open_menu
signal add_item_to_pot(item: InventoryItem)

@onready var player_inventory = preload("res://Player/player_inventory.tres")
@onready var slot_size = $CanvasLayer/PanelContainer/VBoxContainer/ToCraft/GridContainer.get_children().size()
var object_closed = true
var items_in_pot: Array[InventoryItem]


func open():
	open_menu.emit()
	object_closed = false


func _on_close_pressed():
	object_closed = true


func use_item(item_name):
	var item = player_inventory.get_item(item_name)
	# check if pot is full
	if item != null && items_in_pot.size() < slot_size:
		player_inventory.remove(item)
		add_to_pot(item)


func add_to_pot(item: InventoryItem):
	if items_in_pot.size() < slot_size:
		items_in_pot.append(item)
		add_item_to_pot.emit(items_in_pot)
