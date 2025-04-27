extends Area3D

var tracked_balloons: Array[Balloon] = []

func get_first() -> Balloon:
	var first: Balloon = null
	var max_progress = -INF
	
	for balloon in tracked_balloons:
		var progress = balloon.get_follow().progress
		if progress > max_progress:
			max_progress = progress
			first = balloon
	
	return first

func get_last() -> Balloon:
	var last: Balloon = null
	var min_progress = INF
	
	for balloon in tracked_balloons:
		var progress = balloon.get_follow().progress
		if progress < min_progress:
			min_progress = progress
			last = balloon
	
	return last

func get_closest() -> Balloon:
	var closest: Balloon = null
	var min_distance = INF
	
	for balloon in tracked_balloons:
		var dist = global_position.distance_to(balloon.global_position)
		if dist < min_distance:
			min_distance = dist
			closest = balloon
	
	return closest

func _on_area_entered(balloon: Balloon) -> void:
	balloon.before_pop.connect(_remove_balloon.bind(balloon))
	tracked_balloons.append(balloon)

func _on_area_exited(balloon: Area3D) -> void:
	_remove_balloon(balloon)

func _remove_balloon(balloon: Balloon):
	balloon.before_pop.disconnect(_remove_balloon)
	tracked_balloons.erase(balloon)
