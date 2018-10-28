extends TextureRect

func _ready():
	hide()

func change_scene(scene_path : String) -> void:
	show()
	$animation_player.play('start')
	yield($animation_player, 'animation_finished')
	get_tree().change_scene(scene_path)

func quit_game() -> void:
	show()
	$animation_player.play('start')
	yield($animation_player, 'animation_finished')
	get_tree().quit()