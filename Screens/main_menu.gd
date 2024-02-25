extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("escape_game"):
			get_tree().quit()

func _on_exit_button_pressed():
	get_tree().quit()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Main/main.tscn")
