class_name WaveSpawner extends Node

@export var path: Path3D

@onready var wave_gen: WaveGenerator = WaveGenerator.create(44)
var _wave_active = false

var next_unit := 0

func _enter_tree() -> void:
	Global.set_wave_spawner(self)

func _exit_tree() -> void:
	Global.set_wave_spawner(null)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		start_next_wave()

func start_next_wave():
	if _wave_active:
		return
	
	_wave_active = true
	
	var wave: Array[WaveGenerator.SpawnEntry] = wave_gen.generate_next()
	
	for entry in wave:
		if entry.balloon:
			spawn_balloon(entry.balloon)
		
		$Timer.start(entry.delay)
		await $Timer.timeout
	
	_wave_active = false

func spawn_balloon_at_progress(base: Balloon, balloon: Balloon, progress: float):
	var follow = PathFollow3D.new()
	balloon.set_follow(follow)
	balloon.get_follow().progress = progress
	balloon.id = next_unit
	if base:
		balloon.ancestor_ids = base.ancestor_ids.duplicate()
		balloon.ancestor_ids.append(base.id)
	next_unit += 1
	follow.add_child(balloon)
	path.add_child(follow)
	follow.h_offset = 0.75

func spawn_balloon(balloon: Balloon):
	spawn_balloon_at_progress(null, balloon, 0.0)
	
