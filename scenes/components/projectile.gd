class_name Projectile extends Area3D

var _spawn: Vector3
var _target: Vector3
var _damage: int
var _pierce: int

func init(spawn: Vector3, target: Vector3, damage: int, pierce: int):
	_spawn = spawn
	_target = target
	_damage = damage
	_pierce = pierce
