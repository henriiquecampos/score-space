extends Node2D

export var MAX_HEALTH : int = 75
export var SPEED : float = 600.0
export var DAMAGE : float = 25.0

var move_direction : Vector2
var health = MAX_HEALTH

func _ready() -> void:
	$line_2d.points[1] -= Vector2(0, 0)
	set_process(false)

func _process(delta : float) -> void:
	position += move_direction * SPEED * delta
	$line_2d.points[1] -= move_direction * SPEED * delta

func _on_area_2d_body_entered(body: PhysicsBody2D) -> void:
	pass

func _on_damage_area_body_entered(body):
	var player = body as Player
	if player == null:
		return
	player.damage(DAMAGE)
	queue_free()

func _on_visibility_notifier_2d_screen_exited():
	queue_free()

func _on_visibility_notifier_2d2_viewport_entered(viewport):
	var player = get_tree().get_nodes_in_group("player")[0] as Player
	if player == null:
		return
	$timer.start()
	yield($timer, "timeout")
	move_direction = (player.position - position).normalized()
	set_process(true)

func damage(value : int) -> void:
	health = max(health - value, 0)
	if health == 0:
		queue_free()

