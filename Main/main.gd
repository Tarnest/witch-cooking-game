extends Node2D

signal spawn_customer

@onready var spawn_timer = $Customers/SpawnTimer
@onready var customers = $Customers
@onready var game_over_timer = $game_over_canvas/game_over_timer
@onready var countdown = $game_over_canvas/game_over_label

var day_started = false
var day = -1
var day_customers = [10, 12, 14, 16, 18]
var customer_amount
var countdown_active = false
var countdown_var = 0
var day_time = 180

func _process(_delta):
	if Input.is_action_pressed("escape_game"):
		get_tree().quit()

func _on_player_start_day():
	if not day_started:
		day_started = true
		day += 1
		customer_amount = day_customers[day] - 1
		spawn_customer.emit()
		spawn_timer.start()
		game_over_timer.start()
		countdown_var = day_time
		countdown_active = true
		_score_update()

func _on_player_end_day():
	game_over_timer.stop()
	if customer_amount < 1 && customers.get_child_count() == 1:
		day_started = false
	if day == 5:
		get_tree().change_scene_to_file("res://Screens/win_screen.tscn")
	countdown_var = day_time
	countdown_active = false

func _on_spawn_timer_timeout():
	if customer_amount > 0:
		spawn_customer.emit()
	else:
		spawn_timer.stop()
	
	customer_amount -= 1

func _on_game_over_timer_timeout():
	get_tree().change_scene_to_file("res://Screens/game_over.tscn")

func _score_update():
	if countdown_active:
		countdown_var -= 1
		countdown.text = str(countdown_var)
		await get_tree().create_timer(1.0).timeout
		_score_update()
		
