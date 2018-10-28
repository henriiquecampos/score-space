extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var init_scale = scale
	$tween.interpolate_property(self, "scale", init_scale, scale * 1.2,
		0.25, Tween.TRANS_BACK, Tween.EASE_OUT)
	$tween.start()
	yield($tween, "tween_completed")
	$tween.interpolate_property(self, "scale", scale, init_scale,
		0.25, Tween.TRANS_BACK, Tween.EASE_OUT)
	yield($tween, "tween_completed")
	$tween.interpolate_property(self, "global_position", global_position,
	global_position + Vector2(0, -100), 0.5, Tween.TRANS_BACK, Tween.EASE_IN)
	$tween.interpolate_property(self, "modulate", modulate,
	Color(1, 1, 1, 0.0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$tween.start()
	yield($tween, "tween_completed")
	queue_free()