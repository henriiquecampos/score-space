extends Control

func _on_play_button_pressed():
	$transition.change_scene('res://game/game.tscn')

func _on_leaderboard_button_pressed():
	$transition.change_scene('res://interface/leader_board/leader_board.tscn')

func _on_credits_button_pressed():
	$transition.change_scene('res://interface/credits/credits.tscn')

func _on_quit_button_pressed():
	$transition.quit_game()


func _on_upgrades_button_pressed():
	$transition.change_scene('res://interface/upgrades/upgrades.tscn')
