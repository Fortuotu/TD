class_name UpgradeUI extends Control

var _manager: UpgradeManager
var player_controller: PlayerController

func attach(upgrade_manager: UpgradeManager):
	_manager = upgrade_manager
	
	
	$Label.text = _manager.get_current().description
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	player_controller.disable()
	visible = true
	

func detach():
	_manager = null
	
	$Label.text = ""
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_controller.enable()
	visible = false

func _on_close_button_down() -> void:
	detach()

func _on_upgrade_mouse_entered() -> void:
	$Label.visible = true
	

func _on_upgrade_mouse_exited() -> void:
	$Label.visible = false

func _label_follow() -> void:
	pass

func _on_upgrade_pressed() -> void:
	_manager.upgrade()
