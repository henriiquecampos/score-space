extends Button

export var ADDITIONAL_SLASHES = 5

var animating_enter : bool = false
var animating_exit : bool = false

var added_slashes : int = 0
var initial_slashes : int = 2

func _ready() -> void:
	connect('mouse_entered', self, '_on_mouse_entered')
	connect('mouse_exited', self, '_on_mouse_exited')

func _process(delta : float) -> void:
	if not animating_enter and not animating_exit:
		return
	
	if animating_enter:
		if added_slashes < ADDITIONAL_SLASHES:
			text = text.insert(initial_slashes + added_slashes - 1, '/')
			added_slashes += 1
			if added_slashes == ADDITIONAL_SLASHES:
				animating_enter = false
	elif animating_exit:
		if added_slashes > 0:
			text[initial_slashes] = ''
			added_slashes -= 1
			if added_slashes == 0:
				animating_exit = false

func _on_mouse_entered() -> void:
	$audio_stream_player_2d.play()
	animating_enter = true
	animating_exit = false

func _on_mouse_exited() -> void:
	animating_enter = false
	animating_exit = true
