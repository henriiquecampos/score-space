extends Node2D

export var DAMAGE : float = 2.5
var player : Player = null

func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	player = body as Player
	if player == null:
		return
	player.slow_down()
	$timer.start()

func _on_Area2D_body_exited(body):
	player = body as Player
	if player == null:
		return
	player.speed_up()
	player = null
	$timer.stop()

func _on_timer_timeout():
	if player == null:
		return
	player.damage(DAMAGE)
	print('damage tick')
