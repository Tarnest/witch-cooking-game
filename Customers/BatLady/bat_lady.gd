extends CharacterBody2D

enum state {
	MOVING_TO_ORDER,
	WAITING_TO_ORDER,
	MOVING_TO_RECEIVE_ORDER,
	WAITING_TO_RECEIVE_ORDER,
	LEAVING
}

@export var properties = Customer.new()
@export var ray_length = 20

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var ray = $RayCast2D
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var player_inventory = preload("res://Player/player_inventory.tres")

var possible_item_names: Array[String] = ["red_potion"]
var items_requested: Dictionary

var accel = 7
var current_state: state = state.MOVING_TO_ORDER
var direction: Vector2

func _ready():
	var possible_items: Array[InventoryItem] = []
	
	for item in possible_item_names:
		possible_items.append(player_inventory.get_item(item))
	
	var item_amount = randi() % 3 + 1
	for i in range(item_amount):
		var rand_num = randi() % possible_items.size() - 1
		if !items_requested.has(possible_items[rand_num]):
			items_requested[possible_items[rand_num]] = 1
		else:
			items_requested[possible_items[rand_num]] += 1
	
func _physics_process(delta):
	match current_state:
		state.MOVING_TO_ORDER: moving_to_order()
		state.WAITING_TO_ORDER: waiting_to_order()
		state.MOVING_TO_RECEIVE_ORDER: moving_to_receive_order()
		state.WAITING_TO_RECEIVE_ORDER: waiting_to_receive_order()
		state.LEAVING: leaving()
		_: pass
	
	var distance = navigation.target_position - global_position
	
	direction = navigation.get_next_path_position() - global_position
	direction = direction.normalized()
	
	ray.target_position = direction * ray_length
	
	if ray.is_colliding():
		direction = Vector2.ZERO
	
	if distance.length() > 0.5:
		velocity = velocity.lerp(direction * properties.speed, accel * delta)
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func check_inventory():
	var items_to_remove: Dictionary = {}
	
	if player_inventory.is_empty():
		return
	
	for slot in player_inventory.slots:
		if !items_requested.has(slot.item):
			continue
		else:
			if slot.amount >= items_requested[slot.item]:
				items_to_remove[slot.item] = items_requested[slot.item]
	
	if items_requested != items_to_remove:
		return
	
	for item in items_to_remove:
		for i in range(items_to_remove[item]):
			player_inventory.remove(item)
	
	change_state(state.LEAVING)
	
func change_state(new_state):
	if current_state != new_state:
		current_state = new_state

func moving_to_order():
	var waiting_in_line = Vector2(283, -40)
	navigation.target_position = waiting_in_line
	
	var distance = global_position.distance_to(waiting_in_line)
	
	if distance < 0.5:
		change_state(state.WAITING_TO_ORDER)
	
	if direction != Vector2.ZERO:
		animation.play("move_left")
	else:
		animation.play("idle_left")
	
func waiting_to_order():
	var counter_position = Vector2(283, 12)
	navigation.target_position = counter_position
	
	if direction != Vector2.ZERO:
		animation.play("move_down")
	else:
		animation.play("idle_down")

func moving_to_receive_order():
	var waiting_in_line = Vector2(410, 12)
	navigation.target_position = waiting_in_line
	
	sprite.flip_h = true
	
	if direction != Vector2.ZERO:
		animation.play("move_left")
	
	if ray.is_colliding():
		sprite.flip_h = false
		animation.play("idle_down")
	
	var distance = global_position.distance_to(waiting_in_line)
	
	if distance < 0.5:
		change_state(state.WAITING_TO_RECEIVE_ORDER)
	

func waiting_to_receive_order():
	sprite.flip_h = false
	
	animation.play("idle_down")


func leaving():
	var leave_position = Vector2(465, -21)
	navigation.target_position = leave_position
	
	ray.enabled = false
	collision_shape.disabled = true
	
	sprite.flip_h = true
	
	if velocity != Vector2.ZERO:
		animation.play("move_left")
	else:
		animation.play("idle_left")
	
	var distance = global_position.distance_to(leave_position)
	
	if distance < 0.5:
		queue_free()
