extends Node2D

enum state {
	GROWN,
	HARVESTED
}

@export var item_to_give: InventoryItem

@onready var timer = $Timer
@onready var animation = $AnimationPlayer
@onready var player_inventory = preload("res://Player/player_inventory.tres")

var time_to_grow = 20
var current_state = state.GROWN

func _ready():
	timer.timeout.connect(on_timer_timeout)

func _physics_process(delta):
	match current_state:
		state.GROWN: grown()
		state.HARVESTED: harvested()

func get_plant():
	if current_state == state.GROWN:
		player_inventory.insert(item_to_give)
		change_state(state.HARVESTED)
		timer.start(time_to_grow)

func on_timer_timeout():
	change_state(state.GROWN)

func change_state(_state):
	current_state = _state

func grown():
	animation.play("grown")

func harvested():
	animation.play("harvested")
