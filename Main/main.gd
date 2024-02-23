extends Node2D

signal spawn_customer

enum state {
	ENABLED,
	DISABLED
}

@onready var spawn_timer = $Customers/SpawnTimer

var day_started = false
var current_state = state.DISABLED
var day = -1
var day_customers = [10, 12, 14, 16, 18]
var customer_amount

func _process(_delta):
	if Input.is_action_pressed("escape_game"):
		get_tree().quit()

func _on_player_start_day():
	if not day_started:
		day_started = true
		spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_customer.emit()
