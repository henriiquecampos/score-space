extends Node2D

export var MAX_DRAG_FORCE : float = 250
export var DAMAGE : float = 2.5
var player : Player = null
var max_distance : float = 0

func _ready():
	print('BLACK HOLE SPAWNED')
	set_process(false)

func _process(delta : float) -> void:
	if player == null:
		return
	
	var direction = (position - player.position).normalized()
	var distance = position.distance_to(player.position)
	var calculated_force = (max_distance - distance) / max_distance  * MAX_DRAG_FORCE
	player.position += direction * calculated_force * delta

func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	player = body as Player
	if player == null:
		return
	
	max_distance = player.position.distance_to(position)
	set_process(true)

func _on_Area2D_body_exited(body : PhysicsBody2D) -> void:
	var check_player = body as Player
	if check_player == null:
		return
	
	player = null
	set_process(false)

func _on_damage_area_body_entered(body : Player) -> void:
	if body == null:
		return
	
	$timer.start()

func _on_damage_area_body_exited(body : Player) -> void:
	if body == null:
		return
	
	$timer.stop()

func _on_timer_timeout():
	print('damage tick')
	player.damage(DAMAGE)
