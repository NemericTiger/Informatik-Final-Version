extends CharacterBody2D

var speed = 200
var chase = false
var player = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = 100
var player_in_range = false
var can_take_damage = true


func _physics_process(delta):

	if not is_on_floor():
		velocity.y = 100 #+= gravity * delta * 20
	

	if chase:
		#$AnimatedSprite2D.play("aggressive")
		velocity += (player.position - position).normalized() * speed * delta
		move_and_slide() 
		if velocity.x < 0:
			$AnimatedSprite2D.play("aggressive")
			$AnimatedSprite2D.flip_h = false
		elif velocity.x > 0:
			$AnimatedSprite2D.play("aggressive")
			$AnimatedSprite2D.flip_h = true

	if health <= 0:
		GlobalVar.enemy_alive = GlobalVar.enemy_alive - 1
		print("enemies_alive: " + str(GlobalVar.enemy_alive))
		$AnimatedSprite2D.play("death")
		
		self.queue_free()

	deal_with_damage()
	update_health()

func update_health():
	var  healthbar = $healthbar
	healthbar.value = health

func _on_detection_area_body_entered(body):
	player = body
	chase = true

func _on_detection_area_body_exited(_body):
	player = null
	chase = false

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_range = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_range = false

func deal_with_damage():
	if player_in_range and GlobalVar.player_attack == true :
		if  can_take_damage == true:
			health = health - 25
			$take_damage.start()
			can_take_damage = false
			print("enemy health:" + str(health))

func _on_take_damage_timeout():
	can_take_damage = true



func enemy():
	pass


