extends Node2D

const SPEED = 1000

func _ready():
	randomize()

func _process(delta : float) -> void:
	if Input.is_action_pressed('ui_up'):
		position.y -= SPEED * delta
	elif Input.is_action_pressed('ui_down'):
		position.y += SPEED * delta
	
	if Input.is_action_pressed('ui_left'):
		position.x -= SPEED * delta
	elif Input.is_action_pressed('ui_right'):
		position.x += SPEED * delta
	
	if Input.is_action_just_pressed('ui_page_down'):
		$Camera2D.zoom.x += 1
	elif Input.is_action_just_pressed('ui_page_up'):
		$Camera2D.zoom.x -= 1
	


