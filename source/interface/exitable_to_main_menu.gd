extends Control

func _input(event) -> void:
	if event.is_action_pressed('ui_cancel'):
		get_tree().change_scene('res://interface/main_menu/main_menu.tscn')
