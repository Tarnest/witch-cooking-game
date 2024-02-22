extends CharacterBody2D

enum State {
	MOVING_TO_ORDER,
	WAITING_TO_ORDER,
	WAITING_TO_RECEIVE_ORDER,
	MOVING_TO_RECEIVE_ORDER,
	LEAVING
}

@export var properties = Customer.new()
@export var ray_length = 20
@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var ray = $RayCast2D
var accel = 7
var current_state: State = State.MOVING_TO_ORDER
var direction: Vector2
var distance_from_current: Vector2

func _ready():
	# TODO: ADD RECIPES HERE
	pass

func _physics_process(delta):
	match current_state:
		State.MOVING_TO_ORDER: moving_to_order()
		State.WAITING_TO_ORDER: waiting_to_order()
		State.WAITING_TO_RECEIVE_ORDER: pass
		State.MOVING_TO_RECEIVE_ORDER: pass
		State.LEAVING: leaving()
		_: pass
	
	distance_from_current = navigation.target_position - global_position
	
	direction = navigation.get_next_path_position() - global_position
	direction = direction.normalized()
	
	ray.target_position = direction * ray_length
	
	if ray.is_colliding():
		direction = Vector2.ZERO
	
	if distance_from_current.length() > 0.5:
		velocity = velocity.lerp(direction * properties.speed, accel * delta)
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

#func _input(event):
	#if event.is_action_pressed("left_click"):
		#if current_state != State.LEAVING:
			#change_state(State.LEAVING)
		#else:
			#change_state(State.MOVING_TO_ORDER)

func change_state(new_state):
	if current_state != new_state:
		current_state = new_state

func moving_to_order():
	var waiting_in_line = Vector2(275, -40)
	navigation.target_position = waiting_in_line
	
	var distance = global_position.distance_to(waiting_in_line)
	
	if distance < 0.5:
		change_state(State.WAITING_TO_ORDER)

func waiting_to_order():
	var counter_position = Vector2(275, -16)
	navigation.target_position = counter_position
	
	var distance = global_position.distance_to(counter_position)
	
	if distance < 0.5:
		change_state(State.LEAVING)

func leaving():
	var leave_position = Vector2(474, -31)
	navigation.target_position = leave_position
	
	var distance = global_position.distance_to(leave_position)
	
	if distance < 0.5:
		queue_free()
