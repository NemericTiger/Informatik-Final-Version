extends Area2D

@onready var anim = $AnimatedSprite2D
var cooldown = true

func _on_cooldown_timeout():
	cooldown = true

func _on_body_entered(body):
	if body.has_method("player") and cooldown:
		#print("Player in")
		var tween = create_tween()
	
		cooldown = false
		$cooldown.start()
	
		tween.tween_property(self, "position", position + Vector2(0, -30), 0.5)
		anim.play("collect")
		tween.tween_property(self, "modulate:a", 0.0, 0.45)
	
		GlobalVar.currency_01 = GlobalVar.currency_01 + 1
		print("dia. " + str(GlobalVar.currency_01))
	
		tween.tween_callback(queue_free)

