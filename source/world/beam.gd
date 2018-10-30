extends Position2D

export (int) var damage = 5

func _ready():
	$ray_cast_2d.add_exception(get_parent())
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		visible = true
		get_parent().get_node("camera_2d").duration = 2.0
		get_parent().get_node("camera_2d").shake()
		
	if get_parent().get_node("camera_2d/timer").is_stopped():
		$beam_end.position = Vector2(0, 0)
		$ray_cast_2d.cast_to = $beam_end.position
		visible = false
		return
	if Input.is_action_just_released("shoot"):
		$beam_end.position = Vector2(0, 0)
		$ray_cast_2d.cast_to = $beam_end.position
		visible = false
		get_parent().get_node("camera_2d/timer").stop()
		
	$beam_end/particles_2d.emitting = $ray_cast_2d.is_colliding()
	if $ray_cast_2d.is_colliding():
		if $ray_cast_2d.get_collider().is_in_group("comet"):
			$ray_cast_2d.get_collider().get_parent().damage(int(damage))
		return
	if Input.is_action_pressed("shoot"):
		$beam_end.position -= Vector2(0, 600) * delta
		
		$ray_cast_2d.cast_to = $beam_end.position
		$line_2d.points[1] = $beam_end.position
		$line_2d2.points[1] = $beam_end.position
