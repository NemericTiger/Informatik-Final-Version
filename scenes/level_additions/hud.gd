extends CanvasLayer




# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Currency_Counter.text = "Diamonds: " + str(GlobalVar.currency_01)
	print(GlobalVar.alive)
	#if GlobalVar.alive == false:
		#new_modulate.a = 255

func _on_dia_body_entered(_body):
	$Currency_Counter.text = "Diamonds: " + str(GlobalVar.currency_01)


func _physics_process(_delta):
	
	#print(GlobalVar.alive)
	
	var deathscreen = $Deathscreen
	var new_modulate = deathscreen.modulate
	var FAIL = $FAIL
	var n_m = FAIL.modulate
	
	
	
	if GlobalVar.alive == false:
		
		new_modulate.a = 1
		deathscreen.modulate = new_modulate
		n_m.a = 1
		FAIL.modulate = n_m
	
	else:
		new_modulate.a = 0
		deathscreen.modulate = new_modulate
		n_m.a = 0
		FAIL.modulate = n_m






#

