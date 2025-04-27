class_name BalloonHealth extends Node

@export var balloon: Balloon
@export var pop_spawner: PopSpawner
@export var starting_health: int

var _health: HealthComponent

func _ready() -> void:
	_health.health = starting_health
	_health.Died.connect(_on_death)

func _on_death():
	pop_spawner.on_pop(balloon.get_follow().progress)
