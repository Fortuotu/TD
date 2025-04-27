extends Node3D

func _ready() -> void:
	$FireTimer.wait_time = 0.5
	$FireTimer.one_shot = false
	$FireTimer.start()
	$FireTimer.timeout.connect(_fire_dart)

func _fire_dart() -> void:
	var target = $TowerRange.get_first()
	
	if target:
		var dart = Dart.create(global_position, target.global_position)
		add_child(dart)
