extends Node2D

signal open_menu

@export var player_inventory: Inventory
var object_closed = true


func open():
	open_menu.emit()
	object_closed = false


func _on_close_pressed():
	object_closed = true


func _on_panel_container_button_clicked(item_name):
	var item = player_inventory.get_item(item_name)
	if item != null:
		player_inventory.insert(item)
