extends Node2D

func _process(_delta):
	if Input.is_action_pressed("escape_game"):
		get_tree().quit()
