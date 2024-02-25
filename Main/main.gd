extends Node2D

signal spawn_customer

@onready var spawn_timer = $Customers/SpawnTimer
@onready var customers = $Customers
@onready var game_over_timer = $CanvasLayer/GameOver/Timer
@onready var countdown_label = $CanvasLayer/GameOver/Label

var day_started = false
var day = -1
var day_customers = [10, 12, 14, 16, 18]
var customer_amount
var day_time = 180
var spawn_time = [1, 13, 11, 9, 8]
var current_spawn_time

func _process(_delta):
	if Input.is_action_pressed("escape_game"):
		get_tree().quit()
	if day_started:
		time_update()
		if customer_amount < 1 && customers.get_child_count() == 1:
			spawn_timer.stop()
			game_over_timer.stop()

func _on_player_start_day():
	if not day_started:
		countdown_label.visible = true
		day_started = true
		day += 1
		
		customer_amount = day_customers[day] - 1
		current_spawn_time = spawn_time[day]
		spawn_customer.emit()
		spawn_timer.start(current_spawn_time)
		
		game_over_timer.start(day_time + 1)

func _on_player_end_day():
	if customer_amount < 1 && customers.get_child_count() == 1:
		day_started = false
		countdown_label.visible = false
	if day == 5:
		get_tree().change_scene_to_file("res://Screens/win_screen.tscn")

func _on_spawn_timer_timeout():
	if customer_amount > 0:
		spawn_customer.emit()
		customer_amount -= 1

func _on_game_over_timer_timeout():
	get_tree().change_scene_to_file("res://Screens/game_over.tscn")

func time_update():
	countdown_label.text = str(int(game_over_timer.get_time_left()))
