extends Node2D

signal open_menu(container)

@export var container: String
var object_closed = true

func open():
	open_menu.emit(container)
	object_closed = false


func _on_close_pressed():
	object_closed = true
