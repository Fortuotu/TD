class_name PlayerController extends Node

signal left_mouse_down
signal left_mouse_up

@export var player: Player

@export var pivot: Node3D

const jump_vel: float = 25.0
const fall_accel: float = 60.0
const mouse_sens: float = 0.001

var _pitch: float = 0.0
var _speed: float = 8.0
var enabled = true

func _physics_process(delta):
	if enabled:
		_movement()
	
	if not player.is_on_floor():
		player.velocity.y -= fall_accel * delta
	
	player.move_and_slide()

func _movement():
	var input_dir = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_back"):
		input_dir.z += 1
	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	
	var jump: bool = false
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = jump_vel
	
	var pivot_xform = pivot.get_global_transform()
	
	var forward = pivot_xform.basis.z.normalized()
	var right = pivot_xform.basis.x.normalized()
	
	var direction = (right * input_dir.x + forward * input_dir.z).normalized()
	
	player.velocity.x = direction.x * _speed
	player.velocity.z = direction.z * _speed

func _input(event: InputEvent) -> void:
	if not enabled:
		return
	
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		player.rotate_y(-event.relative.x * mouse_sens)
		
		_pitch = clamp(_pitch - event.relative.y * mouse_sens, deg_to_rad(-70.0), deg_to_rad(70.0))
		pivot.rotation.x = _pitch
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			left_mouse_down.emit()
		else:
			left_mouse_up.emit()

func enable():
	enabled = true

func disable():
	enabled = false
	player.velocity = Vector3.ZERO
