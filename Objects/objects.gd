extends Node2D

signal open_menu

var object_closed = true


func open():
	open_menu.emit()
	object_closed = false


func _on_close_pressed():
	object_closed = true
