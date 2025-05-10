class_name Player extends CharacterBody3D

@export var speed: float = 7.0
@export var fall_acceleration: float = 75.0
@export var jump_velocity = 25.0

@export var upgrade_ui: UpgradeUI
@export var hoverer: HovererComponent
@export var controller: PlayerController

const MOUSE_SENSITIVITY: float = 0.001

var pitch = 0.0

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
