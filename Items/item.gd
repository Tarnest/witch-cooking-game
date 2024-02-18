extends Node2D


var mouse_in = false


func _input(event):
	if event.is_action_pressed("left_click") && mouse_in:
		print("Yellow!")


func _on_mouse_entered():
	mouse_in = true


func _on_mouse_exited():
	mouse_in = false
