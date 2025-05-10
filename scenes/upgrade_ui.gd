class_name UpgradeUI extends Control

var _manager: UpgradeManager
var player_controller: PlayerController

func attach(upgrade_manager: UpgradeManager):
	_manager = upgrade_manager
	
	$UpgradeButton.display(_manager.get_current())
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	player_controller.disable()
	visible = true

func detach():
	_manager = null
	
	$UpgradeButton.reset()
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_controller.enable()
	visible = false

func _on_close_button_down() -> void:
	detach()

func _on_upgrade_button_down() -> void:
	_manager.upgrade()
	$UpgradeButton.display(_manager.get_current())
