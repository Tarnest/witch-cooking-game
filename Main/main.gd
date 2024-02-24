extends Node2D

signal spawn_customer

@onready var spawn_timer = $Customers/SpawnTimer
@onready var customers = $Customers
@onready var game_over_timer = $GameOver/Timer
@onready var countdown_label = $GameOver/Label

var day_started = false
var day = -1
var day_customers = [10, 12, 14, 16, 18]
var customer_amount
var day_time = 180

func _process(_delta):
	if Input.is_action_pressed("escape_game"):
		get_tree().quit()
	if day_started:
		score_update()

func _on_player_start_day():
	if not day_started:
		day_started = true
		day += 1
		customer_amount = day_customers[day] - 1
		spawn_customer.emit()
		spawn_timer.start()
		game_over_timer.start(day_time)

func _on_player_end_day():
	if customer_amount < 1 && customers.get_child_count() == 1:
		day_started = false
	if day == 5:
		get_tree().change_scene_to_file("res://Screens/win_screen.tscn")

func _on_spawn_timer_timeout():
	if customer_amount > 0:
		spawn_customer.emit()
	else:
		spawn_timer.stop()
		game_over_timer.stop()
	
	customer_amount -= 1

func _on_game_over_timer_timeout():
	get_tree().change_scene_to_file("res://Screens/game_over.tscn")

func score_update():
	countdown_label.text = str(int(game_over_timer.get_time_left()))
