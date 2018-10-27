extends Node

func _input(event):
	if event.is_action_pressed('debug_fullscreen'):
		OS.window_fullscreen = not OS.window_fullscreen
	elif event.is_action_pressed('debug_exit'):
		get_tree().quit()