extends CharacterBody2D

var speed = 1200.0
var max_move_speed = 65.0
var friction = 0.05
var gravity = 600.

@onready var damage_area = $DamageArea

var activated = false
var activation_distance = 260.0

var player: CharacterBody2D
var attacking = 0.0
var attack_length = 0.4
var attacking_damage_done = false
var hit_force = 270.0

func _ready() -> void:
	player = get_node("../Player")

func _physics_process(delta: float) -> void:
	var on_floor = is_on_floor()
	var current_friction = friction
	var right_direction = Vector2.RIGHT
	var current_max_speed = max_move_speed
	
	velocity.y += gravity * delta
	
	var player_delta = player.position-position
	if !activated and player_delta.length() < activation_distance:
		activated = true
	
	if attacking > 0.0:
		current_friction *= 3.0
	
	var move_dir = 1.0 if player_delta.x > 0.0 else -1.0
	$Sprite.flip_h = move_dir > 0
	
	var normal = get_floor_normal()
	if on_floor:
		right_direction = normal.rotated(PI/2.0)
	
	if attacking > 0.0:
		$Sprite.animation = "slash"
	else:
		$Sprite.animation = "sprint" if abs(velocity.x) > 40.0 else "idle"
	
	if attacking > 0.0:
		attacking -= delta
		
	if attacking <= 0.0 and len(damage_area.get_overlapping_bodies()) > 0:
		attacking = attack_length
		attacking_damage_done = false
		
	elif attacking <= attack_length / 2.0 and !attacking_damage_done:
		attacking_damage_done = true
		var colliding = damage_area.get_overlapping_bodies()
		if len(colliding) > 0:
			colliding[0].velocity.x = lerp(colliding[0].velocity.x,0.0,0.3)
			colliding[0].velocity.x += player_delta.normalized().x * hit_force
			if colliding[0].position.y+8.0 >= position.y:
				colliding[0].velocity.y -= hit_force / 3.0 * 2.0
		
	
	var allow_move = false
	if velocity.x < -current_max_speed:
		allow_move = move_dir > 0 
	elif velocity.x > current_max_speed:
		allow_move = move_dir < 0 
	else:
		allow_move = true
		
	if allow_move and activated and attacking <= 0.0:
		velocity += right_direction * (move_dir * delta * speed)
			
	if on_floor:
		velocity.x = lerp(velocity.x,0.0,current_friction)
		
	move_and_slide()
	
	if is_on_floor():
		normal = get_floor_normal()
		$CollisionShape2D.rotation = atan2(normal.y,normal.x)+PI/2
	else:
		pass
		#$CollisionShape2D.rotation = 0
