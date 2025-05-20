class_name WeaponTripleDart extends Weapon

var _damage: int = 1

func _ready() -> void:
	set_projectile(preload("res://scenes/projectiles/dart.tscn"))

func shoot(target: Vector3):
	var direction = (target - global_position).normalized()

	# Middle projectile (straight to target)
	var middle = _projectile_scene.instantiate() as Projectile
	middle.init(global_position, target, _damage, 1)
	add_child(middle)

	# Horizontal rotation: rotate around Y-axis (Vector3.UP)
	var spread_angle = deg_to_rad(5.0)  # Adjust spread angle as needed

	var left_direction = direction.rotated(Vector3.UP, spread_angle)
	var right_direction = direction.rotated(Vector3.UP, -spread_angle)

	var distance = global_position.distance_to(target)
	var left_target = global_position + left_direction * distance
	var right_target = global_position + right_direction * distance

	# Left projectile
	var left = _projectile_scene.instantiate() as Projectile
	left.init(global_position, left_target, _damage, 1)
	add_child(left)

	# Right projectile
	var right = _projectile_scene.instantiate() as Projectile
	right.init(global_position, right_target, _damage, 1)
	add_child(right)
