extends Area2D

func door2():
	pass
	
func door_in2():
	$AnimatedSprite2D.play("open")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "open":
		get_tree().change_scene_to_file("res://scenes/levels/node_2d.tscn")
