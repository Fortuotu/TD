class_name WeaponSingleShot extends Weapon

var _damage: int = 1

func _ready() -> void:
	set_projectile(preload("res://scenes/projectiles/dart.tscn"))

func shoot(target: Vector3):
	var projectile = _projectile_scene.instantiate() as Projectile
	projectile.init(global_position, target, _damage, 1)
	add_child(projectile)
