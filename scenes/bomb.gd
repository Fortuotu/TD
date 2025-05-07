class_name Bomb extends RigidBody3D

signal before_delete

var _followed_node: Node3D

var _tween: Tween

func follow_node(node: Node3D):
	_followed_node = node
	print(_followed_node)

func stop_follow():
	_followed_node = null
	print(_followed_node)

func start_tick():
	const duration: float = 3.0
	
	_tween = create_tween()
	_tween.tween_method(_tween_shader, 0.0, 15.0, duration)
	_tween.tween_callback(_explode)

func _tween_shader(value: float):
	var model = $Model
	var shader_material = model.get_surface_override_material(0) as ShaderMaterial
	shader_material.set_shader_parameter("t", clamp(sin(value), 0.0, 1.0))

func _explode():
	const duration: float = 0.22
	const final_scale: float = 80.0
	
	$Model.visible = false
	
	_tween = create_tween()
	_tween.tween_property($Explosion, "scale", Vector3(final_scale, final_scale, final_scale), duration)
	_tween.tween_callback(_delete)

func _delete():
	_tween_shader(0.0)
	
	before_delete.emit()
	queue_free()

func _physics_process(delta: float) -> void:
	if not _followed_node:
		return
	
	linear_velocity = (_followed_node.global_position - global_position) * 6.0

func _on_explosion_area_area_entered(area: Area3D) -> void:
	if area is not Balloon:
		return
	
	var balloon: Balloon = area
	balloon.health.damage(10)
