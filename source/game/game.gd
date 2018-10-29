extends Node

var score : int = 0

func _ready() -> void:
	$GUI.update_score_label(score)

func _on_world_world_generated():
	for planet in get_tree().get_nodes_in_group('planets'):
		planet = planet as Planet
		planet.connect('resources_depleted', self, '_on_planet_resources_depleted')

func _on_planet_resources_depleted(resources : int) -> void:
	score += resources
	$GUI.update_score_label(score)