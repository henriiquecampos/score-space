class StatsLoader:
	signal stats_updated
	
	const FILE_PATH = 'user://file_player.stats'
	
	var player_stats = {
		'resources': 0,
		'health_level': 1,
		'speed_level': 1,
		'acceleration_level': 1,
		'prospecting_level': 1,
	}
	
	func get_stats() -> Dictionary:
		var stats_file : File = File.new()
		stats_file.open(FILE_PATH, File.READ)
		if not stats_file.file_exists(FILE_PATH):
			create_initial_file()
		
		while not stats_file.eof_reached():
			var line = parse_json(stats_file.get_line())
			if line == null:
				break
			player_stats = line
		stats_file.close()
		
		return player_stats
	
	func create_initial_file(rewrite : bool = false) -> void:
		var stats_file : File = File.new()
		stats_file.open(FILE_PATH, File.WRITE)
		if stats_file.file_exists(FILE_PATH) and not rewrite:
			stats_file.close()
			return
		stats_file.store_line(to_json(player_stats))
		stats_file.close()
	
	func _write_stats() -> void:
		var stats_file : File = File.new()
		stats_file.open(FILE_PATH, File.WRITE)
		
		stats_file.store_line(to_json(player_stats))
		stats_file.close()
	
	func upgrade_stat(stat : String) -> void:
		player_stats[stat] += 1
		_write_stats() 
		emit_signal('stats_updated')
	
	func add_resources(value : int) -> void:
		player_stats = get_stats()
		player_stats.resources += value
		_write_stats()

