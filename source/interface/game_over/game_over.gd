extends 'res://interface/exitable_to_main_menu.gd'

const URL = 'https://firestore.googleapis.com/v1beta1/projects/score-space-game/databases/(default)/documents/scores'

onready var line_edit = $VBoxContainer/form/LineEdit

var request_format = """
{
	\"fields\": {
		\"score\": { \"integerValue\": {score_value} },
		\"player\": { \"stringValue\": \"{player_name}\" }
	}
}
"""

func _ready():
	$VBoxContainer/score.text = "Final Score: " + str(score_tracker.score)

func _on_send_button_pressed():
	if $VBoxContainer/form/LineEdit.text == '':
		return
	
	$VBoxContainer/form/send_button.disabled = true
	var score = score_tracker.score
	var headers = ["Content-Type: application/json"]
	var body = request_format.format({"score_value": str(score), "player_name": line_edit.text})
	var result = $HTTPRequest.request(URL, headers, true, HTTPClient.METHOD_POST, body)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	get_tree().change_scene('res://interface/main_menu/main_menu.tscn')
	
