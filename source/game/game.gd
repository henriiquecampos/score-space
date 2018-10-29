extends Node

var score : int = 0
var stats_loader

func _ready() -> void:
	stats_loader = load('res://utils/stats_loader.gd').StatsLoader.new()
	$GUI.update_score_label(score)

func _on_world_world_generated():
	for planet in get_tree().get_nodes_in_group('planets'):
		planet = planet as Planet
		planet.connect('resources_depleted', self, '_on_planet_resources_depleted')

func _on_planet_resources_depleted(resources : int) -> void:
	score += resources
	stats_loader.add_resources(resources)
	$GUI.update_score_label(score)