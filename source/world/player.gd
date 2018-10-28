extends KinematicBody2D
class_name Player

var speed = 0
export (float) var max_speed : float= 300
export (float) var turn_speed : float = 200.0
export (float) var max_angular_velocity : float = 10.0
export (float) var dampling : float = 0.5
export (float) var acceleration : float = 100.0
export (float) var prospection_speed : float = 40

var angular_velocity : float = 0.0
var velocity : Vector2 = Vector2(0, -1)
var prospecting = false

func _physics_process(delta):
	if not prospecting:
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
	pass

