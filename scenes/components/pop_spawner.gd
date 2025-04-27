class_name PopSpawner extends Node

@export var spawned_balloon: PackedScene

func on_pop(progress: float) -> void:
	Global.get_wave_spawner().spawn_balloon_at_progress(spawned_balloon.instantiate(), progress)
