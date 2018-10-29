extends "res://interface/exitable_to_main_menu.gd"

const MAX_LEVEL : = 5
const BASE_PRICE : int = 750

var stats_loader

func _ready() -> void:
	_load_upgrades()

func _load_upgrades() -> void:
	stats_loader = load('res://utils/stats_loader.gd').StatsLoader.new()
	var stats = stats_loader.get_stats()
	$v_box_container/resources.text = "RESOURCES: " + str(stats.resources)
	$v_box_container/health_line.connect('stat_updated', self, '_on_stat_updated')
	$v_box_container/speed_line.connect('stat_updated', self, '_on_stat_updated')
	$v_box_container/acceleration_line.connect('stat_updated', self, '_on_stat_updated')
	$v_box_container/prospection_line.connect('stat_updated', self, '_on_stat_updated')

func _on_stat_updated():
	var stats = stats_loader.get_stats()
	$v_box_container/resources.text = "RESOURCES: " + str(stats.resources)
	$v_box_container/health_line.update_stat()
	$v_box_container/speed_line.update_stat()
	$v_box_container/acceleration_line.update_stat()
	$v_box_container/prospection_line.update_stat()
