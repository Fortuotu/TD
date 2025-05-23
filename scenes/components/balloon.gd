class_name Balloon extends Area3D

signal before_pop

@export var health: HealthComponent

var _speed: float = 0.0
var _follow: PathFollow3D

var id: int
var ancestor_ids: Array[int]

func _ready() -> void:
	_follow.loop = false
	
	health.Died.connect(_on_pop)

func _physics_process(delta: float) -> void:
	if _follow.progress_ratio >= 1.0:
		_follow.queue_free()
	
	_follow.progress += _speed * delta
	
	health.flush()

func _on_pop():
	Global.money_counter += 1

	before_pop.emit()
	_follow.queue_free()

func set_follow(follow: PathFollow3D):
	_follow = follow

func get_follow() -> PathFollow3D:
	return _follow

func get_speed() -> float:
	return _speed

func set_speed(speed: float):
	_speed = speed

func transfer_overkill_damage(damage: int):
	health.damage(damage)
