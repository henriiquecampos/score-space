extends Node2D

const TEXTURES = [
	preload("res://world/planets/blue.png"),
	preload("res://world/planets/green.png"),
	preload("res://world/planets/pink.png"),
	preload("res://world/planets/purple.png"),
	preload("res://world/planets/yellow.png")
]

var animation_speed_range = Vector2(0.5, 2)

func _ready():
	randomize()
	$animation.playback_speed = rand_range(animation_speed_range.x, animation_speed_range.y)
	$sprite.texture = TEXTURES[rand_range(0, TEXTURES.size())]
