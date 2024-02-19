extends CharacterBody2D

enum state {
	IDLE,
	MOVING,
	PAUSE
}

@export var speed = 200
@export var ray_length = 15
@export var inventory: Inventory
#TODO: Remove After Test
@export var item: InventoryItem
@onready var ray = $RayCast2D
var current_state = state.IDLE
var direction = Vector2.ZERO
var last_direction = Vector2.LEFT

func _physics_process(delta):
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
	
	# TODO: Remove after test
	if Input.is_action_just_pressed("left_click"):
		inventory.insert(item)
	if Input.is_action_just_pressed("open_menu"):
		inventory.remove(item)
	
	move_and_slide()

func change_state(new_state):
	if current_state != new_state:
		current_state = new_state

func idle():
	if Input.is_action_pressed("moving"):
		change_state(state.MOVING)

func moving():
	if !Input.is_action_pressed("moving"):
		change_state(state.IDLE)
	
	var direction = Vector2.ZERO
	
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
	
	if direction != Vector2.ZERO:
		last_direction = direction
	
	velocity = direction.normalized() * speed

func pause():
	velocity = Vector2.ZERO
