class_name Dart extends Area3D

static var _scene = preload("res://dart.tscn")

static func create(spawn: Vector3, target: Vector3):
	var inst = _scene.instantiate()
	inst._direction = spawn.direction_to(target)
	inst._spawn = spawn
	inst._target = target
	return inst

var dart_speed = 30.0
var dart_lifetime = 5.0

var _direction: Vector3
var _spawn: Vector3
var _target: Vector3

func _ready():
	global_position = _spawn
	look_at(_target)
	
	$Lifetime.start(dart_lifetime)

func _on_area_entered(balloon: Balloon) -> void:
	balloon.pop()

func _physics_process(delta: float) -> void:
	position += _direction * dart_speed * delta

func _on_lifetime_timeout() -> void:
	print("delete dart.")
	queue_free()
