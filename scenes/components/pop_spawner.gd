class_name PopSpawner extends Node

@export var spawner_balloon: Balloon
@export var spawned_balloon: PackedScene

func _ready() -> void:
	spawner_balloon.before_pop.connect(_spawn_balloon)

func _spawn_balloon() -> void:
	Global.get_wave_spawner().spawn_balloon_at_progress(
		spawned_balloon.instantiate(),
		spawner_balloon.get_follow().progress
	)
