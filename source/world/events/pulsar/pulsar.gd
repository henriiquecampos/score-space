extends Node2D
	
func _process(delta):
	$rays/Line2D.points[0] = $rays/ray_cast_2d.cast_to
	$rays/Line2D.points[1] = $rays/ray_cast_2d2.cast_to
	