class_name WaveSpawner extends Node

var balloon_scene = preload("res://scenes/balloons/red_balloon.tscn")

@export var path: Path3D

var balloon_count = 1

func _enter_tree() -> void:
	Global.set_wave_spawner(self)

func _exit_tree() -> void:
	Global.set_wave_spawner(null)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		_start_next_wave()

func _start_next_wave():
	for i in range(balloon_count):
		spawn_balloon(balloon_scene.instantiate())
		
		$Timer.start(0.2)
		await $Timer.timeout
	
	balloon_count += 1

func spawn_balloon_at_progress(balloon: Balloon, progress: float):
	var follow = PathFollow3D.new()
	balloon.set_follow(follow)
	balloon.get_follow().progress = progress
	follow.add_child(balloon)
	path.add_child(follow)

func spawn_balloon(balloon: Balloon):
	spawn_balloon_at_progress(balloon, 0.0)
