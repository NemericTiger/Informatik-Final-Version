extends CharacterBody2D

@export var speed : float = 260.0
@export var jump_force : float = -290.0
@export var jump_time : float = 0.18
@export var coyote_time : float = 0.075
@export var gravity_multiplier : float = 2.3

@onready var anima = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping : bool = false
var jump_timer : float = 0
var coyote_timer : float = 0
var can_control : bool = true

#Battle system variablen
var enemy_in_range = false
var enemy_cooldown = true
var health = 300 
var attack_ip = false





func _physics_process(delta):
	#print(velocity.x)
	#print(GlobalVar.alive)
	
	if not can_control: return
	
	# Add the gravity.
	if not is_on_floor() and not is_jumping:
		velocity.y += gravity * gravity_multiplier * delta
		coyote_timer += delta
	else:
		coyote_timer = 0

	#print(velocity.y)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer < coyote_time):
		velocity.y = jump_force
		is_jumping = true
		
	elif Input.is_action_pressed("jump") and is_jumping:
		velocity.y = jump_force
		
	if is_jumping and Input.is_action_pressed("jump") and jump_timer < jump_time:
		jump_timer += delta
		
	else:
		is_jumping = false
		jump_timer = 0
		
	if not is_on_floor() and velocity.y < -1:
		$AnimatedSprite2D.play("jump")

	#if not is_on_floor() and velocity.y > 0:
		#$AnimatedSprite2D.play("fall")
		
		
	# Get the input direction and handle the movement/deceleration.

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed

		if velocity.x < 2 and GlobalVar.player_attack == false:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = true
			
		elif velocity.x > 2 and GlobalVar.player_attack == false:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = false
			
	elif GlobalVar.player_attack == false:
		velocity.x = move_toward(velocity.x, 0, speed)
		$AnimatedSprite2D.play("idle")


	move_and_slide()
	enemy_attack()
	player_attack()
	update_health()
	
	
	if health <= 0:
		health = 0
		#get_tree().change_scene_to_file("res://scenes/deathscreen.tscn")
		$AnimatedSprite2D.play("dead")
		can_control = false
		GlobalVar.alive = false
		
	
	
	
func player():
	pass


func update_health():
	var healthbar = $healthbar
	healthbar.value = health

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true
		print("enemy_cooldown" + str(enemy_cooldown))

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false


func enemy_attack():
	if enemy_in_range and enemy_cooldown:
		health = health - 20
		enemy_cooldown = false
		$enemy_cooldown.start()
		print("player_health " + str(health))



func _on_enemy_cooldown_timeout():
	enemy_cooldown = true


func player_attack():
	#var current_direction = "right"

	#if Input.is_action_just_pressed("walk_left"):
		#print("left")
		#current_direction = "left"
	#elif Input.is_action_just_pressed("walk_right"):
		#print("right")
		#current_direction = "right"
	
	if Input.is_action_just_pressed("attack"):# and is_on_floor()
		GlobalVar.player_attack = true
		attack_ip = true
		if $AnimatedSprite2D.flip_h == false:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("attack")
			$player_cooldown.start()
		if $AnimatedSprite2D.flip_h == true:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack")
			$player_cooldown.start()



func _on_player_cooldown_timeout():
	$player_cooldown.stop()
	#GlobalVar.player_attack = false
	attack_ip = false




func _on_area_2d_area_entered(area):
	if area.has_method("door") and GlobalVar.enemy_alive < 1:
		$AnimatedSprite2D.play("door in")
		area.door_in()
		
		await get_tree().create_timer(0.15).timeout
		can_control = false
		$AnimatedSprite2D.play("door in")
		
		await get_tree().create_timer(1).timeout

		position.x = 3050
		position.y = 180

func door_out():
	$AnimatedSprite2D.play("door out")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == ("door out"):
		can_control = true
	elif $AnimatedSprite2D.animation == ("attack"):
		GlobalVar.player_attack = false

