class_name Player
extends KinematicBody2D

signal health_changed(current_health)

onready var camera = $camera_2d

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
	var stats = load('res://utils/stats_loader.gd').StatsLoader.new().get_stats()
	current_speed = max_speed + max_speed / 2 * (stats.speed_level - 1)
	health = health + health / 2 * (stats.health_level - 1)
	acceleration = acceleration + acceleration * 0.25 * (stats.acceleration_level - 1)
	prospection_speed = prospection_speed + prospection_speed / 2 * (stats.prospecting_level - 1)

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
	if health == 0:
		return
	camera.duration = 0.8
	camera.shake()
	health = max(health - value, 0)
	emit_signal('health_changed', health)
	if health == 0:
		set_physics_process(false)
		set_process_input(false)
		$particles_2d.emitting = false
		$collision_shape_2d.disabled = true
		$death_timer.start()
		yield($death_timer, 'timeout')
		get_tree().change_scene('res://interface/game_over/game_over.tscn')

func slow_down() -> void:
	current_speed = max_speed * 0.5

func speed_up() -> void:
	current_speed = max_speed
	
func _input(event):
	if event.is_action_pressed("thrust"):
		$particles_2d.emitting = true
	elif event.is_action_released("thrust"):
		$particles_2d.emitting = false
	elif event.is_action_pressed("break"):
		$particles_2d.emitting = false
	