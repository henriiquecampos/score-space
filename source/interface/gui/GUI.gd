extends CanvasLayer

onready var score_label : = $margin_container/top/score as Label
onready var health_bar : = $margin_container/top/health_bar as ProgressBar
func _ready():
	update_score_label(0)
	var player = get_tree().get_nodes_in_group('player')[0]
	player.connect('health_changed', self, '_on_player_health_changed')
	health_bar.max_value = player.health
	health_bar.value = player.health

func update_score_label(value : int):
	score_label.text = value as String

func _on_player_health_changed(health : int):
	health_bar.value = health