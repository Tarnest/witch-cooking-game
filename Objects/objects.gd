extends Node2D

signal open_menu(container)

@export var container: String

func open():
	open_menu.emit(container)
