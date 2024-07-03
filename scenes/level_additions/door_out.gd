extends Node2D

var cooldown : bool = true

func _on_cooldown_timeout():
	cooldown = true



func _on_body_entered(body):
	if body.has_method("player") and cooldown:
		$AnimatedSprite2D.play("close")
		body.door_out()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == ("close"):
		cooldown = false
