class_name Dart extends Area3D

static var _scene = preload("res://scenes/projectiles/dart.tscn")

static func create(spawn: Vector3, target: Vector3):
	var inst = _scene.instantiate()
	inst._direction = spawn.direction_to(target)
	inst._spawn = spawn
	inst._target = target
	return inst

var dart_speed = 60.0
var _pierce_left = 1
var _damage = 2
var _lifetime = 5.0

var _direction: Vector3
var _spawn: Vector3
var _target: Vector3

func _ready():
	global_position = _spawn
	look_at(_target)
	
	$Lifetime.start(_lifetime)

func _on_area_entered(balloon: Balloon) -> void:
	if _pierce_left > 0:
		balloon.health.damage(_damage)
		queue_free()
		_pierce_left -= _damage

func _physics_process(delta: float) -> void:
	position += _direction * dart_speed * delta

func _on_lifetime_timeout() -> void:
	queue_free()
