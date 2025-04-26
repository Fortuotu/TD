extends Node

var balloon_scene = preload("res://balloon.tscn")

@export var path: Path3D

var balloon_count = 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		_start_next_wave()

func _start_next_wave():
	for i in range(balloon_count):
		var follow = PathFollow3D.new()
		var balloon = balloon_scene.instantiate()
		balloon.set_follow(follow)
		follow.add_child(balloon)
		
		path.add_child(follow)
		
		$Timer.start(0.2)
		await $Timer.timeout
	
	balloon_count += 1
