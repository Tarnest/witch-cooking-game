extends CanvasLayer

@onready var exit_timer = $exit_timer
@onready var exit_text = $exit_text

func _on_exit_timer_timeout():
	if exit_text.is_visible_in_tree():
		exit_text.hide()
	else:
		exit_text.show()
	exit_timer.start()
