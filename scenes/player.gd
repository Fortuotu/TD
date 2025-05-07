extends CharacterBody3D

@export var speed: float = 7.0
@export var fall_acceleration: float = 75.0
@export var jump_velocity = 25.0

const MOUSE_SENSITIVITY: float = 0.001

var pitch = 0.0

var picked_object: Bomb

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
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
	
	if Input.is_action_just_pressed("jump"):
		jump = true
	
	if Input.is_action_just_pressed("use_item") && picked_object:
		picked_object.start_tick()
	
	var cam_xform = $Pivot.get_global_transform()
	
	var forward = cam_xform.basis.z.normalized()
	var right = cam_xform.basis.x.normalized()
	
	var direction = (right * input_dir.x + forward * input_dir.z).normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if not is_on_floor():
		velocity.y -= fall_acceleration * delta
	elif jump:
		velocity.y = jump_velocity
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		
		pitch = clamp(pitch - event.relative.y * MOUSE_SENSITIVITY, deg_to_rad(-70.0), deg_to_rad(70.0))
		$Pivot.rotation.x = pitch
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var collider = $Pivot/Camera3D/ItemGrabber.get_collider()
			if not collider or collider is not Bomb:
				return
			
			picked_object = collider
			picked_object.follow_node($Pivot/Camera3D/ItemGrabber/ItemHeld)
		else:
			if not picked_object:
				return
			
			picked_object.stop_follow()
			picked_object = null
