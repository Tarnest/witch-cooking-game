extends CharacterBody2D

enum state {
	IDLE,
	MOVING,
	PAUSE
}

@export var speed = 200
@export var ray_length = 15
@onready var ray = $RayCast2D
var current_state = state.IDLE
var direction = Vector2.ZERO
var last_direction: Vector2

func _physics_process(delta):
	match current_state:
		state.IDLE: idle()
		state.MOVING: moving()
		state.PAUSE: pause()
	
	ray_direction()
	
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider.is_in_group("Shelf") && Input.is_action_just_pressed("open_menu"):
			collider.call("open")
			change_state(state.PAUSE)
	
	move_and_slide()

func ray_direction():
	ray.target_position = last_direction.normalized() * ray_length

func change_state(new_state):
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
	
	# TODO: MAKE SURE TO CHNAGE THIS, JUST A PLACEHOLDER
	if Input.is_action_just_pressed("left_click"):
		change_state(state.IDLE)
