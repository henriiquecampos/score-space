extends Node2D

signal world_generated

const NEBULA = preload("res://world/events/nebula.tscn")

onready var entities = $entities

export var WIDTH = 128
export var HEIGHT = 128
export var OFFSET = 128

var world_noise

func _ready() -> void:
	randomize()
	world_noise = OpenSimplexNoise.new()
	
	world_noise.seed = randi()
	world_noise.octaves = 4
	world_noise.period = 20.0
	world_noise.persistence = 0.8
	_generate_world()

func _generate_world() -> void:
	var sample : float
	for x in range(WIDTH):
		for y in range (HEIGHT):
			sample = world_noise.get_noise_2d(float(x - WIDTH / 2), float(y - HEIGHT / 2))
			for entity in entities.get_children():
				if sample >= entity.NOISE_RANGE.x and sample <= entity.NOISE_RANGE.y:
					var pos = Vector2((x - WIDTH) * OFFSET, (y - HEIGHT) * OFFSET)
					if entity.SPAWN_DISTANCE > 0:
						if not entity.can_spawn_entity(pos):
							continue
					var new_entity = entity.SCENE.instance()
					new_entity.global_position = pos
					add_child(new_entity)
					entity.previous_positions.append(pos)
					break
	emit_signal('world_generated')