class_name PopSpawner extends Node

@export var spawner_balloon: Balloon
@export var spawned_balloon: PackedScene

@export var count: int = 1
@export var gap: int = 1

func _ready() -> void:
	spawner_balloon.before_pop.connect(_spawn_balloon)

func _spawn_balloon() -> void:
	var balloon: Balloon
	var spawn_progress = spawner_balloon.get_follow().progress - (gap * count) / 2
	var overkill_remaining = spawner_balloon.health.overkill
	
	for i in range(count):
		balloon = spawned_balloon.instantiate()
		
		Global.get_wave_spawner().spawn_balloon_at_progress(
			spawner_balloon,
			balloon,
			spawn_progress
		)
		
		balloon.transfer_overkill_damage(overkill_remaining)
		overkill_remaining = balloon.health.overkill
		
		spawn_progress += gap
