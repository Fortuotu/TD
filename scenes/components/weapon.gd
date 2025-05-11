class_name Weapon extends Node3D

var _projectile_scene: PackedScene

func set_projectile(scene: PackedScene):
	_projectile_scene = scene

func shoot(target: Vector3):
	pass
