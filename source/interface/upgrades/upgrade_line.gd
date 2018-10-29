extends HBoxContainer

signal stat_updated

export var STAT_NAME : String
export var BASE_PRICE : int = 750

var stats_loader
var player_stats : Dictionary
var price : int = 0

func _ready():
	$button.connect('pressed', self, '_on_button_pressed')
	stats_loader = load('res://utils/stats_loader.gd').StatsLoader.new()
	stats_loader.connect('stats_updated', self, '_on_stats_updated')
	player_stats = stats_loader.get_stats()
	update_stat()

func update_stat() -> void:
	player_stats.clear()
	player_stats = stats_loader.get_stats()
	price = player_stats[STAT_NAME + '_level'] * BASE_PRICE
	$button.text = '↑ ' + str(price)
	$progress_bar.value = player_stats[STAT_NAME + '_level']
	$button.disabled = player_stats.resources < price or player_stats[STAT_NAME + '_level'] == 5

func _on_button_pressed() -> void:
	stats_loader.add_resources(-price)
	stats_loader.upgrade_stat(STAT_NAME + '_level')
	update_stat()
	emit_signal('stat_updated')
	
func _on_stats_updated() -> void:
	update_stat()	