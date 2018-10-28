extends Control

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

func _on_send_button_pressed():
	randomize()
	var random_score = int(rand_range(5000, 100000))
	var headers = ["Content-Type: application/json"]
	var body = request_format.format({"score_value": str(random_score), "player_name": line_edit.text})
	var result = $HTTPRequest.request(URL, headers, true, HTTPClient.METHOD_POST, body)
