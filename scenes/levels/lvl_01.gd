class_name Level
extends Node2D

@export var level_start_pos : Node2D

func _input(_event):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	elif Input.is_action_just_pressed("FAIL"):
		get_tree().change_scene_to_file("res://scenes/levels/lvl_01.tscn")
		GlobalVar.currency_01 = 0
		GlobalVar.alive = true
		GlobalVar.enemy_alive = 3

