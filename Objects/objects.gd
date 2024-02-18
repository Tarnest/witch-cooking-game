extends Node2D


signal open_menu(container)

@export var container: String
var player_in_area = false
var player

func _physics_process(delta):
	if Input.is_action_just_pressed("open_menu") && player_in_area:
		rotation += deg_to_rad(90) * delta
		player.change_state(player.state.PAUSE)
		open()

func open():
	open_menu.emit(container)
	print("called open")


func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true
		player = body


func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		player = null
