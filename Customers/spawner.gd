extends Node2D

signal customer_left

@onready var bat_lady = preload("res://Customers/BatLady/bat_lady.tscn")
@onready var dr_frankenstein = preload("res://Customers/DrFrankenstein/dr_frankenstein.tscn")
@onready var invisible_man = preload("res://Customers/InvisibleMan/invisible_man.tscn")
@onready var ghost = preload("res://Customers/Ghost/ghost.tscn")
@onready var frankensteins_monster = preload("res://Customers/FrankensteinsMonster/frankensteins_monster.tscn")
@onready var christian = preload("res://Customers/Christian/christian.tscn")
@onready var spawn_timer = $SpawnTimer
@onready var customers: Array = [bat_lady, dr_frankenstein, invisible_man, ghost, frankensteins_monster, christian]

var start_position: Vector2 = Vector2(493, 0) 


func _on_spawn_customer():
	var num = randi() % customers.size()
	var new_customer = customers[num].instantiate()
	new_customer.position = start_position
	
	spawn_timer.add_sibling(new_customer)
