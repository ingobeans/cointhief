extends CharacterBody2D

var speed = 1200.0
var max_move_speed = 200.0
var friction = 0.05
var gravity = 600.0
var jump_force = 200.0


func _physics_process(delta: float) -> void:
	var on_floor = is_on_floor()
	var move_dir = Input.get_axis("left","right")
	var current_friction = friction
	
	if move_dir != 0:
		$Sprite.flip_h = move_dir < 0
	elif on_floor:
		current_friction *= 3
	
	$Sprite.animation = "sprint" if abs(velocity.x) > 90.0 else "idle"

	velocity.y += gravity * delta
	
	var allow_move = false
	if velocity.x < -max_move_speed:
		allow_move = move_dir > 0 
	elif velocity.x > max_move_speed:
		allow_move = move_dir < 0 
	else:
		allow_move = true
	if allow_move:
		velocity.x += move_dir * delta * speed
			
	if on_floor:
		velocity.x = lerp(velocity.x,0.0,current_friction)
		
		if Input.is_action_pressed("jump"):
			velocity.y = -jump_force
	
	move_and_slide()
