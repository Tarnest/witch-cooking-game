extends Node2D

signal open_menu

@onready var player_inventory = preload("res://Player/player_inventory.tres")
var object_closed = true


func open():
	open_menu.emit()
	object_closed = false


func _on_close_pressed():
	object_closed = true


func use_item(item_name):
	var item = player_inventory.get_item(item_name)
	if item != null:
		player_inventory.remove(item)
