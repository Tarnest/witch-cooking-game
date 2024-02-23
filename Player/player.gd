extends CharacterBody2D

signal start_day

enum state {
	IDLE,
	MOVING,
	PAUSE
}

@export var speed = 200
@export var ray_length = 15
@export var inventory: Inventory

@onready var ray = $RayCast2D
@onready var inventoryUI = $InventoryUI
@onready var animation_player = $AnimationPlayer
@onready var bell = get_node("../Objects/Bell/AudioStreamPlayer2D")

var current_state = state.IDLE
var direction = Vector2.ZERO
var last_direction = Vector2.LEFT
var is_moving = false

func _physics_process(_delta):
	match current_state:
		state.IDLE: idle()
		state.MOVING: moving()
		state.PAUSE: pause()
	
	# get ray direction based on player last direction while moving
	ray.target_position = last_direction.normalized() * ray_length
	
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider.is_in_group("Container") && Input.is_action_just_pressed("open_menu"):
			collider.call("open")
			change_state(state.PAUSE)
		
		if collider.is_in_group("Container") && collider.object_closed:
			if current_state != state.MOVING:
				change_state(state.IDLE)
		
		if collider.is_in_group("Trash") && Input.is_action_just_pressed("open_menu"):
			inventory.clear()
		
		if collider.is_in_group("Customer") && Input.is_action_just_pressed("open_menu"):
			if collider.current_state == collider.state.WAITING_TO_ORDER:
				collider.change_state(collider.state.MOVING_TO_RECEIVE_ORDER)
			if collider.current_state == collider.state.WAITING_TO_RECEIVE_ORDER:
				collider.check_inventory()
		
		if collider.is_in_group("Bell") && Input.is_action_just_pressed("open_menu"):
			bell.play()
			start_day.emit()
		
	move_and_slide()

func change_state(new_state):
	if current_state != new_state:
		current_state = new_state

func idle():
	if Input.is_action_pressed("moving"):
		change_state(state.MOVING)
	play_animation("idle", last_direction)
	
func moving():
	if !Input.is_action_pressed("moving"):
		change_state(state.IDLE)
	
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		direction.y += -1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x += -1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	if direction.x == 1:
		$Sprite2D.flip_h = true
	elif direction.x == -1:
		$Sprite2D.flip_h = false
	
	play_animation("run", direction)
	
	if direction != Vector2.ZERO:
		last_direction = direction
	
	velocity = direction.normalized() * speed

func pause():
	velocity = Vector2.ZERO
	play_animation("idle", last_direction)

func play_animation(type, dir):
	var animation: String
	var up_right = Vector2(1, -1)
	var up_left = Vector2(-1, -1)
	var down_right = Vector2(1, 1)
	var down_left = Vector2(-1, 1)
	match dir:
		Vector2.UP: animation = type + "_" + "north"
		Vector2.DOWN: animation = type + "_" + "south"
		Vector2.LEFT: animation = type + "_" + "west"
		Vector2.RIGHT: animation = type + "_" + "west"
		up_right: animation = type + "_" + "northwest"
		up_left: animation = type + "_" + "northwest"
		down_right: animation = type + "_" + "southwest"
		down_left: animation = type + "_" + "southwest"
	
	animation_player.play(animation)
