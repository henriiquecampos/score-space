extends Control

const SCORE_ENTRY = preload('res://interface/leader_board/score_entry.tscn')

const GET_URL = 'https://firestore.googleapis.com/v1beta1/projects/score-space-game/databases/(default)/documents/scores'

onready var list = $VBoxContainer

func _ready():
	_get_highscores()

func _get_highscores() -> void:
	$HTTPRequest.request(GET_URL)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	for document in json.result.documents:
		var new_highscore = SCORE_ENTRY.instance()
		new_highscore.player_name = document.fields.player.stringValue
		new_highscore.score = document.fields.score.integerValue as int
		list.add_child(new_highscore)
