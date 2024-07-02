extends Control


func _ready():
	$Background/VBoxContainer/PlayButton.grab_focus()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/lvl_01.tscn")


func _on_settings_button_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_quit_button_pressed():
	get_tree().quit()
