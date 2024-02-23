extends Node2D

@onready var bat_lady = preload("res://Customers/BatLady/bat_lady.tscn")
@onready var spawn_timer = $SpawnTimer

var customers: Array = [bat_lady]
var start_position: Vector2 = Vector2(493, 0) 


func _on_spawn_customer():
	var new_customer = bat_lady.instantiate()
	new_customer.position = start_position
	
	spawn_timer.add_sibling(new_customer)
