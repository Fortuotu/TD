class_name Balloon extends Area3D

#@export var health: BalloonHealth

var speed: float = 10.0

signal on_pop

var _follow: PathFollow3D

func _ready() -> void:
	_follow.loop = false

func _physics_process(delta: float) -> void:
	if _follow.progress_ratio >= 1.0:
		_follow.queue_free()
	
	_follow.progress += speed * delta

func set_follow(follow: PathFollow3D):
	_follow = follow

func get_follow() -> PathFollow3D:
	return _follow

func damage():
	pass

func pop():
	on_pop.emit(self)
	
	_follow.queue_free()
