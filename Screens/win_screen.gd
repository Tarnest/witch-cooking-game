extends CanvasLayer

@onready var exit_timer = $exit_timer
@onready var exit_text = $exit_text

func _on_exit_timer_timeout():
	if exit_text.is_visible_in_tree():
		exit_text.hide()
	else:
		exit_text.show()
	exit_timer.start()

func _input(event):
	if event.is_action_pressed("back_to_main"):
		get_tree().change_scene_to_file("res://Screens/main_menu.tscn")
		
func _process(_delta):
	if Input.is_action_pressed("escape_game"):
		get_tree().quit()
