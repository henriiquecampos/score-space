extends KinematicBody2D
class_name Player

signal health_changed(current_health)

var speed = 0
export (float) var max_speed : float= 300
export (float) var turn_speed : float = 200.0
export (float) var max_angular_velocity : float = 10.0
export (float) var dampling : float = 0.5
export (float) var acceleration : float = 100.0
export (float) var prospection_speed : float = 40
export var health : int = 100

var angular_velocity : float = 0.0
var velocity : Vector2 = Vector2(0, -1)
var prospecting = false
var current_speed = max_speed

func _ready() -> void:
	emit_signal('health_changed', health)

func _physics_process(delta):
	if Input.is_action_pressed("thrust"):
		speed += acceleration * delta
		speed = min(speed, max_speed)
	elif Input.is_action_pressed("break"):
		speed -= acceleration * delta
		speed = max(speed, 0)
	if Input.is_action_pressed("rotate_left"):
		angular_velocity -= (turn_speed * delta) * delta
	elif Input.is_action_pressed("rotate_right"):
		angular_velocity += (turn_speed * delta) * delta

	speed -= (speed * dampling) * delta
	angular_velocity -= (angular_velocity * dampling) * delta
	angular_velocity = min(angular_velocity, max_angular_velocity)
	if move_and_collide(speed * (velocity.rotated(rotation)) * delta):
		speed = 0
	rotate(angular_velocity * delta)

func damage(value : float) -> void:
	health = max(health - value, 0)
	emit_signal('health_changed', health)

func slow_down() -> void:
	current_speed = max_speed * 0.5

func speed_up() -> void:
	current_speed = max_speed
