extends CharacterBody2D

var direction = Vector2.ZERO
@export var speed = 200

func _physics_process(delta):
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
