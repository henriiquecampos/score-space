extends HBoxContainer

var player_name : String = ''
var score : int = 0

onready var _name_label = $name as Label
onready var _score_label = $score as Label

func _ready() -> void:
	_name_label.text = player_name
	_score_label.text = str(score)
	
