extends CanvasLayer

@onready var exit_timer = $exit_timer
@onready var exit_text = $exit_text
@onready var text1 = $text1
@onready var text2 = $text2

func _ready():
	text2.hide()

func _on_exit_timer_timeout():
	if exit_text.is_visible_in_tree():
		exit_text.hide()
	else:
		exit_text.show()
	exit_timer.start()
	
func _input(event):
	if event.is_action_pressed("back_to_main"):
		get_tree().change_scene_to_file("res://Screens/main_menu.tscn")
	if event.is_action_pressed("escape_game"):
		get_tree().quit()
	if event.is_action_pressed("right_arrow"):
		_page2()
	if event.is_action_pressed("left_arrow"):
		_page1()

func _on_arrow_r_pressed():
	_page2()

func _on_arrow_l_pressed():
	_page1()
	
func _page1():
	text1.show()
	text2.hide()
	
func _page2():
	text1.hide()
	text2.show()
