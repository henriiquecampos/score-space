extends Camera2D

export(float) var amplitude = 6.0
export(float) var duration = 0.8 setget set_duration
export(float, EASE) var DAMP_EASING = 1.0
export(bool) var shake = false setget set_shake

onready var timer = $timer

func _ready():
	self.duration = duration
	set_process(false)
	randomize()

func set_duration(value):
	duration = value
	if not timer:
		return
	timer.wait_time = duration

func set_shake(value):
	shake = value
	if shake:
		set_process(true)
	else:
		set_process(false)

func shake() -> void:
	set_process(true)
	$timer.start()

func _process(delta):
	var damping = ease(timer.time_left / timer.wait_time, DAMP_EASING)
	offset = Vector2(
		rand_range(amplitude, -amplitude) * damping,
		rand_range(amplitude, -amplitude) * damping)

func _on_timer_timeout():
	self.shake = false
