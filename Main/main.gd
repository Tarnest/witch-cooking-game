extends Node2D

signal spawn_customer

@onready var spawn_timer = $Customers/SpawnTimer
@onready var customers = $Customers

var day_started = false
var day = -1
var day_customers = [10, 12, 14, 16, 18]
var customer_amount

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

func _on_player_end_day():
	if customer_amount < 1 && customers.get_child_count() == 1:
		day_started = false

func _on_spawn_timer_timeout():
	if customer_amount > 0:
		spawn_customer.emit()
	else:
		spawn_timer.stop()
	
	customer_amount -= 1

