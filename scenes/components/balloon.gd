class_name Balloon extends Area3D

signal before_pop

@export var health: HealthComponent

var _speed: float = 0.0
var _follow: PathFollow3D

func _ready() -> void:
	_follow.loop = false
	
	health.Died.connect(_on_pop)

func _physics_process(delta: float) -> void:
	if _follow.progress_ratio >= 1.0:
		_follow.queue_free()
	
	_follow.progress += _speed * delta

func _on_pop():
	before_pop.emit()
	_follow.queue_free()

func set_follow(follow: PathFollow3D):
	_follow = follow

func get_follow() -> PathFollow3D:
	return _follow
