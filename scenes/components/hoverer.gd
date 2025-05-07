extends Node

@export var ray_cast: RayCast3D

var _hovered: Node3D
var _hovered_c: HoverOutlineC

func _physics_process(delta: float) -> void:
	var collider = ray_cast.get_collider()
	if not collider:
		_unhover_current()
		
		return
	
	if _hovered == collider:
		return
	
	_try_hover(collider)

func _try_hover(collider: Node3D):
	var component = _check_for_component(collider)
	if not component:
		return
	
	_unhover_current()
	
	_hovered = collider
	_hovered_c = component
	
	_hovered_c.mesh.visible = true

func _unhover_current():
	if _hovered:
		_hovered_c.mesh.visible = false
		
		_hovered = null
		_hovered_c = null

func _check_for_component(collider: Node3D) -> HoverOutlineC:
	for child in collider.get_children():
		if child is HoverOutlineC:
			return child
	
	return null
