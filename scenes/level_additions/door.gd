extends Area2D



func _on_body_entered(_body):
	#if body.has_method("player"):
		#body.teleport()
	pass

func door():
	pass


func door_in():
	$AnimatedSprite2D.play("open")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "open":
		$AnimatedSprite2D.play("close")
