extends Node2D
class_name Planet

const TEXTURES = [
	preload("res://world/planets/blue.png"),
	preload("res://world/planets/green.png"),
	preload("res://world/planets/pink.png"),
	preload("res://world/planets/purple.png"),
	preload("res://world/planets/yellow.png")
]
export (int) var max_resource = 500
export (int) var min_resource = 100
var resources : int = 0
var animation_speed_range : Vector2 = Vector2(0.5, 2)
var player = null

signal resources_depleted(resources)

func _ready():
	randomize()
	set_process(false)
	$sprite.texture = TEXTURES[rand_range(0, TEXTURES.size())]
	resources = int(rand_range(min_resource, max_resource))
	$progress_bar.max_value = resources
	var ratio : float = float(resources)/float(max_resource)
	$sprite.scale *= ratio
	var new_shape = CircleShape2D.new()
	new_shape.radius = 128.0
	new_shape.radius *= ratio
	$Area2D/CollisionShape2D.shape = new_shape

func _process(delta):
	if not $progress_bar.visible or player == null:
		return
	$progress_bar.value += player.prospection_speed * delta
	$progress_bar.value = clamp($progress_bar.value, 0, $progress_bar.max_value)
	
func _on_Area2D_body_entered(body):
	if resources < 1:
		return
	if body.is_in_group("player"):
		player = body
		player.prospecting = true
		set_process(true)
		$progress_bar.show()

func _on_progress_bar_value_changed(value):
	if value >= $progress_bar.max_value:
		set_process(false)
		player.prospecting = false
		$progress_bar.value = 0
		$progress_bar.visible = false
		var init_scale = $sprite.scale
		$tween.interpolate_property($sprite, "scale", init_scale,
			$sprite.scale * Vector2(1.1, 1.1), 0.5,
			$tween.TRANS_ELASTIC, $tween.EASE_OUT)
		$tween.start()
		instance_score(resources)
		emit_signal('resources_depleted', resources)
		yield($tween, "tween_completed")
		$tween.interpolate_property($sprite, "scale", $sprite.scale,
			init_scale, 0.12,
			$tween.TRANS_QUAD, $tween.EASE_OUT)
		$tween.start()
		resources = 0
		
func instance_score(score):
	var scene = load("res://juice/poplabel.tscn").instance()
	scene.get_node("label").text = str(score)
	add_child(scene)

func _on_Area2D_body_exited(body):
	if resources < 1:
		return
	if body.is_in_group("player"):
		$progress_bar.hide()
		set_process(false)
		var remainder = int($progress_bar.max_value - $progress_bar.value)
		resources = remainder
		$progress_bar.max_value = remainder