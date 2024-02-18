extends CharacterBody2D

enum state {
	IDLE,
	MOVING
}

@export var speed = 200
var current_state = state.IDLE
var direction = Vector2.ZERO

func _physics_process(delta):
	match current_state:
		state.IDLE: idle()
		state.MOVING: moving()
	

func idle():
	if Input.is_action_pressed("moving"):
		current_state = state.MOVING
	
func moving():
	if !Input.is_action_pressed("moving"):
		current_state = state.IDLE
	
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		direction.y += -1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x += -1
		$Sprite2D.flip_h = false
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		$Sprite2D.flip_h = true
	
	velocity = direction.normalized() * speed
	
	move_and_slide()
	

