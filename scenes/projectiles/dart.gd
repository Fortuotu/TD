class_name Dart extends Projectile

static var _scene = preload("res://scenes/projectiles/dart.tscn")

static func create(spawn: Vector3, target: Vector3):
	var inst = _scene.instantiate()
	inst._direction = spawn.direction_to(target)
	inst._spawn = spawn
	inst._target = target
	return inst

var dart_speed = 60.0
var _lifetime = 5.0

var _direction: Vector3

var hit_ids: Array[int] = []

func _ready():
	global_position = _spawn
	_direction = (_target - _spawn).normalized()
	_pierce = 2
	_damage = 1
	look_at(_target)
	
	$Lifetime.start(_lifetime)

func _on_area_entered(balloon: Balloon) -> void:
	for hit_id in hit_ids:
		if hit_id in balloon.ancestor_ids:
			return
	
	balloon.health.damage(_damage)
	
	hit_ids.append(balloon.id)
	
	_pierce -= 1
	if _pierce == 0:
		queue_free()

func _physics_process(delta: float) -> void:
	position += _direction * dart_speed * delta

func _on_lifetime_timeout() -> void:
	queue_free()
