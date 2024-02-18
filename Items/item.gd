extends Node2D


var mouse_in = false
var clicked = false


func _physics_process(delta):
	if clicked:
		rotation += deg_to_rad(90) * delta


func _input(event):
	if event.is_action_pressed("left_click") && mouse_in:
		clicked = !clicked


func _on_mouse_entered():
	mouse_in = true


func _on_mouse_exited():
	mouse_in = false
