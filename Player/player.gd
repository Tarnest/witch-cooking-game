extends CharacterBody2D

enum state {
	IDLE,
	MOVING,
	PAUSE
}

@export var speed = 200
var current_state = state.IDLE
var direction = Vector2.ZERO

func _physics_process(delta):
	match current_state:
		state.IDLE: idle()
		state.MOVING: moving()
		state.PAUSE: pause()
	
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("Yippee")
		var body = collision.get_collider()
		if body.is_in_group("Shelf"):
			body.call("open")
			print("Yippee!!!")
			

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
	
	velocity = direction.normalized() * speed

func pause():
	velocity = Vector2.ZERO
	
	# TODO: MAKE SURE TO CHNAGE THIS, JUST A PLACEHOLDER
	if Input.is_action_just_pressed("left_click"):
		change_state(state.IDLE)
