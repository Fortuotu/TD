class_name Player extends CharacterBody3D

@export var controller: PlayerController
@export var hoverer: HovererComponent
@export var upgrade_ui: UpgradeUI

var picked_object: Bomb

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	controller.left_mouse_down.connect(_left_mouse_down)
	controller.left_mouse_up.connect(_left_mouse_up)
	
	upgrade_ui.player_controller = controller

func _left_mouse_down():
	_check_tower()

func _left_mouse_up():
	pass

func _check_tower():
	var tower = hoverer.hovered_object() as Tower
	if tower:
		upgrade_ui.attach(tower.upgrade_manager)
	else:
		upgrade_ui.detach()
