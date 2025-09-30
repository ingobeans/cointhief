extends CharacterBody2D

var speed = 1200.0
var max_move_speed = 200.0
var friction = 0.05
var gravity = 600.0
var jump_force = 200.0
var slide_speed_multiplier = 300.0
var slide_per_frame = 0.1
var slide_slope_multiplier = 100.0

var sliding = false
var fall_distance = 0.0

func _physics_process(delta: float) -> void:
	var on_floor = is_on_floor()
	var move_dir = Input.get_axis("left","right")
	var current_friction = friction
	var right_direction = Vector2.RIGHT
	
	sliding = Input.is_action_pressed("slide")
	velocity.y += gravity * delta
	
	if move_dir != 0:
		$Sprite.flip_h = move_dir < 0
	elif on_floor and !sliding:
		current_friction *= 3
	elif on_floor and sliding:
		current_friction /= 2
	
	var normal = get_floor_normal()
	if on_floor:
		right_direction = normal.rotated(PI/2.0)
	
	if sliding:
		$Sprite.animation = "slide"
		if on_floor:
			$Sprite.rotation = atan2(normal.y,normal.x)+PI/2.0
	else:
		$Sprite.animation = "sprint" if abs(velocity.x) > 90.0 else "idle"
		$Sprite.rotation = 0.0
	
	var allow_move = false
	if velocity.x < -max_move_speed:
		allow_move = move_dir > 0 
	elif velocity.x > max_move_speed:
		allow_move = move_dir < 0 
	else:
		allow_move = true
	if allow_move and !sliding:
		velocity += right_direction * (move_dir * delta * speed)
			
	if on_floor:
		if fall_distance > 0.0:
			if sliding:
				velocity += right_direction * (fall_distance * slide_per_frame * slide_speed_multiplier * (-1.0 if velocity.x < 0 else 1.0))
				fall_distance -= fall_distance * slide_per_frame
				if fall_distance < 0.1:
					fall_distance = 0.0
			else:
				fall_distance = 0.0
		velocity.x = lerp(velocity.x,0.0,current_friction)
		
		if Input.is_action_pressed("jump"):
			var force = -jump_force
			if sliding:
				force *= min(abs(velocity.x) / 200.0,1.65)
				if abs(velocity.x)  < 20.0:
					force = 0.0
			velocity.y = force
	else:
		fall_distance += delta
		
	move_and_slide()
	
	if is_on_floor():
		var angle = get_floor_angle(Vector2.UP)
		normal = get_floor_normal()
		
		$CollisionShape2D.rotation = atan2(normal.y,normal.x)+PI/2
		
		if sliding:
			var force = ((angle * slide_slope_multiplier) ** 2 * delta)
			velocity += force * normal.rotated(PI / 2 * (1.0 if normal.x > 0 else -1.0)).normalized()
	else:
		pass
		#$CollisionShape2D.rotation = 0
