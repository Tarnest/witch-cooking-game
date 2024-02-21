extends CharacterBody2D

enum State {
	MOVING_TO_ORDER,
	WAITING_TO_ORDER,
	WAITING_TO_RECEIVE_ORDER,
	MOVING_TO_RECEIVE_ORDER,
	LEAVING
}

@export var properties = Customer.new()
@onready var navigation: NavigationAgent2D = $NavigationAgent2D
var accel = 7
var current_state: State = State.MOVING_TO_ORDER
var direction: Vector2
var distance: Vector2

func _ready():
	# TODO: ADD RECIPES HERE
	pass

func _physics_process(delta):
	match current_state:
		State.MOVING_TO_ORDER: moving_to_order()
		State.WAITING_TO_ORDER: pass
		State.WAITING_TO_RECEIVE_ORDER: pass
		State.MOVING_TO_RECEIVE_ORDER: pass
		State.LEAVING: leaving()
	
	distance = navigation.target_position - global_position
	
	direction = navigation.get_next_path_position() - global_position
	direction = direction.normalized()
	
	print(current_state)
	if distance.length() > 0.5:
		velocity = velocity.lerp(direction * properties.speed, accel * delta)
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _input(event):
	if event.is_action_pressed("left_click"):
		if current_state != State.LEAVING:
			change_state(State.LEAVING)
		else:
			change_state(State.MOVING_TO_ORDER)

func change_state(new_state):
	if current_state != new_state:
		current_state = new_state

func moving_to_order():
	navigation.target_position = Vector2(274, -16)

func leaving():
	navigation.target_position = Vector2(474, -31)
