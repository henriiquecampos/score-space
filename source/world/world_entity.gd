extends Node
class_name WorldEntity

export var NOISE_RANGE : = Vector2(-0.2, 0.2)
export var SCENE : PackedScene

export var SPAWN_DISTANCE : float = 0
var previous_positions = []

func can_spawn_entity(pos : Vector2) -> bool:
	for last_position in previous_positions:
		if last_position.distance_to(pos) <= SPAWN_DISTANCE:
			return false
	return true